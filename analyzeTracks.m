function [results, maNew, stops, vectorVelocityNormalizedToFrameInterval, vectorVelocityMultipliedByX] = analyzeTracks (ma, documentation)
%   this function gets an ma variable and documentation and returns
%   "results", and "maNew".
%    results is a dataset table in which:
%
%    *results(:,1) = track number
%    *results(:,2) = track Displacement => The distance in microns between
%                    start and end point
%    *results(:,3) = run Length => sum of all instantaneous distances.
%    *results(:,4) = avg Velocity => average of all instentaneous
%                    Velocities (not taking into acount the direction)
%    *results(:,5) = percentRetro => % of time the particle was traveling
%                    retrogradely above the minimal speed.
%    *results(:,6) = percentAntero => % of time the particle was traveling
%                    antero above the minimal speed.
%    *results(:,7) = percentStopped => % of time the particle was traveling
%                    below the minimal speed.
%    *results(:,8) = alpha
%    *results(:,9) = stop count per second => stop is defines as 3
%                    consequative frames below the minimum velocity.
%    *results(:,10) = track duration => number of frames *time interval
%    *results(:,11) = speed;
%    *results(:,12) = avgStopDuration;
%    *results(:,13) = trackDisplacement'./trackDuration;
%    *results(:,14) = directionChangesPerSecond;
%    *results(:,15) = avgVelocityX;
%    *maNew is a filtered ma.


%this code assumes that the tracks were adjusted to pixel size.

%-------INITIALIZE VARIABLES:
minSpeed = 0.1; %particles moving slower than this value eill be regarded as stopped.
fastTransport = 1; %particles moving faster than this value will be regarded as transported via fast transport.
frameInterval = documentation.frameInterval;
stopsEnd = {}; % this variable is needed for calculating stops (the "end+1" cant work on a non existant variabl).
    
%   compute track duration    
    trackDuration = cellfun(@length, ma.tracks)*frameInterval;

%   Compute track displacement and run length
 v = ma.getVelocities;
 
 %multiplyByX is used later on to plot the velocitiy distrubution while
 %anterograde is minus on x axis. since some movies were reversed, there is
 %this if statement. if the last value of this function is set to true, the
 %next loop will be called:
 
 for i=1:length(v)
     vectorVelocity{i} = sqrt((v{i}(:,2).^2)+(v{i}(:,3).^2))';
     vectorVelocityNormalizedToFrameInterval{i} = vectorVelocity{i}/frameInterval;
     vectorVelocityMultipliedByX{i} = vectorVelocityNormalizedToFrameInterval{i}'.*-sign(v{i}(:,2));
     trackDisplacement(i) = pdist([ma.tracks{i}(1,2:3); ma.tracks{i}(end,2:3)]);
     runLength(i) = sum(abs(vectorVelocity{i})); 
     avgVelocity(i) = mean(vectorVelocityNormalizedToFrameInterval{i}); %  get average velocity.
     avgVelocityX(i) = mean(vectorVelocityMultipliedByX{i}); %  get average velocity.
 end
  
    for i=1:length(v)
        percentAntero(i) = sum(v{i}(:,2)>minSpeed)/size(v{i},1); %the ratio of forward movement faster then minimum speed.
        percentRetro(i) = sum(v{i}(:,2)<-minSpeed)/size(v{i},1); %the ratio of forward movement faster then minimum speed.
    end
    
%   compute number of stops:
%   variable stopCount counts all atpos for all tracks.
%   variable stops is a cell array for each track with the point number for the start, point number for end, and length of stop. 
    for i=1:length(vectorVelocityNormalizedToFrameInterval) %for each track
        
                stopsEnd =[]; % set to zero.
                
%   First, for the first element, do:
           if vectorVelocityNormalizedToFrameInterval{i}(1)<=minSpeed   
               stops{i}(1,1) = 0;
           else
               stops{i}(1,1) = NaN; % NaN is an indicator to delete this row.
           end
                stopsEnd(1,1) = NaN; % NaN is an indicator to delete this row.
           
        for j=2:size(vectorVelocityNormalizedToFrameInterval{i},2) %for each point
           
            if vectorVelocityNormalizedToFrameInterval{i}(j)<=minSpeed && vectorVelocityNormalizedToFrameInterval{i}(j-1)>minSpeed; % find stop start.
            stops{i}(end+1,1) = j;
            end
            
            if vectorVelocityNormalizedToFrameInterval{i}(j)>minSpeed && vectorVelocityNormalizedToFrameInterval{i}(j-1)<=minSpeed; % find stop end.
            stopsEnd(end+1,1) = j;
            end
            

        end
            %remove NaN row in stops if it exists:
            if isnan(stops{i}(1,1));
               stops{i}(1,:) = [];
            end
            %remove NaN row in stopsEnd(it exists):
            stopsEnd(1,:) = [];
            %   if the track ends in the middle of a stop, add last frame
            %   to stopEnd:
            while size(stops{i},1)~=size(stopsEnd,1)
                if size(stops{i},1)>size(stopsEnd,1)
                    stops{i}(end,:) = [];
                else
                    stopsEnd(end,:) = [];
                end
                
            end
            
            %finish up:
            stops{i}(:,2) = stopsEnd(:,1);
            stops{i}(:,3) = stops{i}(:,2)-stops{i}(:,1);
            stops{i}(stops{i}(:,3)<3,:)=[]; % remove stops that are shorter then 3 frames.
            avgStopDuration(i) = mean(stops{i}(:,3))*documentation.frameInterval; % calculate avg duration.
            avgStopDuration(isnan(avgStopDuration))=0;
            [stopCount junk] = cellfun(@size, stops);
            
            
%   re-compute P_stopped:
             percentStopped(i) = (stopCount(i)*avgStopDuration(i))/trackDuration(i); %UPDATED!! 010114   
             
%   compute number of direction changes:

            xamx = [];
            imax = [];  
            xmin = [];
            imin = [];
            [xmax,imax,xmin,imin] = extrema(vectorVelocityNormalizedToFrameInterval{i});
            directionChanges(i) = length(findpeaks(ma.tracks{i}(:,2),'Threshold',0.2))+ length(findpeaks(ma.tracks{i}(:,2)*-1,'Threshold',0.2))
             
               
    end

    
%   compute alpha (messure for directed motion)
    ma = ma.fitLogLogMSD(0.25);

%   compute speed 
    speed = runLength'./trackDuration;
        
%   compute stops per second:
    stopCountPerSecond = stopCount' ./ trackDuration;
    
%   compute direction changes per second:
    directionChangesPerSecond = directionChanges' ./ trackDuration;
    
%   add to table
    results(:,1) = 1:length(ma.tracks)'; 
    results(:,2) = trackDisplacement';
    results(:,3) = runLength';
    results(:,4) = avgVelocity';
    results(:,5) = percentRetro';
    results(:,6) = percentAntero';
    results(:,7) = percentStopped';
    results(:,8) = ma.loglogfit.alpha';
    results(:,9) = stopCountPerSecond;
    results(:,10) = trackDuration;
    results(:,11) = speed;
    results(:,12) = avgStopDuration;
    results(:,13) = trackDisplacement'./trackDuration;
    results(:,14) = directionChangesPerSecond;
    results(:,15) = avgVelocityX;
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    


%  filter criteria:
 % results(results(:,3)<5,:)=[];
 results(results(:,4)<0.2,:)=[];
 results(results(:,10)< 10* frameInterval,:)=[];
 % results(results(:,2)< 10,:)=[];
%  results(results(:,11)< 1.350,:)=[];
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    
%------------------------------------------------------------------------------------------    

   

%   filter out NaN's and inf's:
    [a b] = find(isnan(results)); %find the NaN's!
    a = unique(a);
    results(a,:)=[]; %delete'Em...
    
    [a b] = find(abs(results)== inf); %find the inf's!
    a = unique(a);
    results(a,:)=[]; %delete'Em...
  

%   create new ma file with just the tracks that passed the filter:
    maNew = msdanalyzer(2, 'µm', 'sec');
    maNew = maNew.addAll(ma.tracks(results(:,1)));
    

    
%   create headers:
    header = {'Track_number', 'Track_displacement', 'Run_length','Average_velocity', 'P_retrograde',...
        'P_anterograde', 'P_stopped', 'alpha', 'Stop_count','Track_duration', 'Speed','Average_stop_duration',...
        'displacment_to_duration','Direction_changes','Average_velocity_x'};
    results = dataset({results,header{:}});
    

   disp('///////////////////////////////')
   disp('///////////////////////////////')
   disp('DONT FORGET TO CHECK THE FILTER CRITERIA IN THE CODE!!!!')
   disp('///////////////////////////////')
   disp('///////////////////////////////')


