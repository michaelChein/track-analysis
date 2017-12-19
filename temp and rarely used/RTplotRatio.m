
function [average, stdErr, RV_NGF, p75] = RTplotRatio (varargin)
%this is a modified version of RTplotTrackAnalysis used to get the ratio of
% two values..

%---------------INITIALIZE VARIABLES:
                PARAMETERS = 2;

%   Speed
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,1)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.Speed);
            stdErr(i) = std(varargin{i}.results.Speed)/sqrt(length(varargin{i}.results.Speed)-1);
        end
   RV_NGF(1) = average(2)/average(1);
   p75(1) = average(4)/average(3);
  %  barweb(average, stdErr, [], [], 'Speed', [], 'µm/sec', 'Gray', [], varargin{end}, 2, 'axis')
   a(1) = bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('Speed')
   ylabel('µm/sec');
   hold on;
   b(1) = errorbar(average, stdErr, 'k.');

    

    %   percentage stopped:
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,2)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.P_stopped*100);
            stdErr(i) = std(varargin{i}.results.P_stopped*100)/sqrt(length(varargin{i}.results.P_stopped*100));
        end
   RV_NGF(2) = average(2)/average(1);
   p75(2) = average(4)/average(3);
   
   % barweb(average, stdErr, [], [], '% Stopped', [], '%', 'Gray', [], varargin{end}, 2, 'axis')
      a(2) =  bar(average,'w');
   set(gca,'xticklabel', varargin{end});
      title('% Stopped')
   ylabel('%');
   hold on;
   b(2) = errorbar(average, stdErr, 'k.');
%{
  subplot(PARAMETERS,2,4) -----------------------Left overs from an old
  code.
  for i=1:length(varargin)-1
            minVal(i) = min(varargin{i}.P_stopped);
            maxVal(i) = max(varargin{i}.P_stopped);
        end
        minVal = min(minVal);
        maxVal = max(maxVal);

    x = linspace(minVal, maxVal, 100);
        for i=1:length(varargin)-1
            Y(:,i) = histc(varargin{i}.P_stopped,x);
        end
    area(x,Y);
    legend(varargin{end})
    
    %   stop count:
%}
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,3)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.Stop_count);
            stdErr(i) = std(varargin{i}.results.Stop_count)/sqrt(length(varargin{i}.results.Stop_count));
        end
        
   RV_NGF(3) = average(2)/average(1);
   p75(3) = average(4)/average(3);
   
   % barweb(average, stdErr, [], [], 'Stop count per second', [], '#', 'Gray', [], varargin{end}, 2, 'axis')
     a(3) =  bar(average,'w');
   set(gca,'xticklabel', varargin{end});
      title('Stop count per second')
   ylabel('#');
   hold on;
   b(3) = errorbar(average, stdErr, 'k.');


    %   stop duration:
    temp= [];
for i=1:length(varargin)-1
    stops = varargin{i}.stops;
   for j=1:length(stops)
       temp =cat(1,temp,stops{j}(:,3) );
   end 
   temp= temp*varargin{i}.documentation.frameInterval;
   average(i) = mean(temp);
   stdev(i) = std(temp)/sqrt(length(temp)-1);
end

   RV_NGF(4) = average(2)/average(1);
   p75(4) = average(4)/average(3);

%[h, p] = ttest2(x5,x6)
subplot(2,2,4)
 a(4) = bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('stop duration');
   ylabel('sec')
   hold on;
   b(4) = errorbar(average, stdev, 'k.');
