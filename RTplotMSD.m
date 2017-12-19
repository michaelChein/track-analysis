function RTplotMSD (varargin)
% plot MSD (actually just d) for each TRACK and asign a diferent color to each axon (ma file).
% note to self (mc) = > can't figure how to add legend. the problam is
% "varname" can not get the variable name from varargin...

%  example: RTplotMSD2(control, treated, docu,{'one','two'})

cc={'b','r','g','c'};
%cc=jet%(length(varargin)*10); % assign diferent hsv in each loop!
%cc = [0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725;0.8157,0.7765,0.9725;0.8157,0.7765,0.9725; 0.8157,0.7765,0.9725;...
%   0.8157,0.7765,0.9725;0.8157,0.7765,0.9725;0.2627,0.1922,0.6784;0.2627,0.1922,0.6784;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;...
%  0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;0.5,0.5,0.5;];

figure; 
hold on;


    for i=1:length(varargin)-1
        tempTracks = [];
        maNEW = [];
        for j=1:length(varargin{i}.tracks)
            tempTracks{j} = varargin{i}.tracks{j};
            n = varargin{end}.pixelSize;
            tempTracks{j}(:,2) = tempTracks{j}(:,2) * n;

        end
        maNEW = msdanalyzer(2, 'Âµm', 'sec');
        maNEW = maNEW.addAll(tempTracks);
        maNEW = maNEW.computeMSD;
        
         for j=1:length(maNEW.msd)
        %    if i==2
               plot(maNEW.msd{j}(:,1)*varargin{end}.frameInterval,maNEW.msd{j}(:,2)*varargin{end}.pixelSize,'LineWidth',1.8,'color',cc{i});
              
      %      else
                % plot(varargin{i}.msd{j}(:,1),varargin{i}.msd{j}(:,2),'g-')
      %          plot(maNEW.msd{j}(:,1)*varargin{end}.frameInterval,maNEW.msd{j}(:,2)*varargin{end}.pixelSize,'LineWidth',1.8,'color',cc(i*6,:));
      %      end
          % [pks1,locs] = findpeaks(varargin{i}.msd{j}(:,2));
          %  scatter(varargin{i}.msd{j}(locs,1),varargin{i}.msd{j}(locs,2));
          %  lastNumBeforeNaN = find(isnan(varargin{i}.msd{j}(:,2))==1,1)-1; %this is used to find the place where the track ends, because the matrix contunus with NaN.
          %  text(varargin{i}.msd{j}(lastNumBeforeNaN,1),varargin{i}.msd{j}(lastNumBeforeNaN,2), num2str(j),'FontSize',14); 
         end
    end
    
    xlabel('time(sec)')
    ylabel('distance(µm)')
    
    
    for i=1:length(varargin)-1
            text(max(xlim)-10, max(ylim)-(10+i*10),num2str(i),'color',cc{i});hold on
    end
    
    
  
    %{
    for i=1:length(varargin)
       for j=1:length(varargin{i}.msd)
              text(varargin{i}.msd{j}(end,1),varargin{i}.msd{j}(end,2), num2str(j)); hold on
       end
    end
    
    
%    a= ylim; 
%   for i=1:length(varargin)
%        varname(varargin{i})
%        ssstring = strcat('\fontsize{16} {\color[rgb]{',num,str(cc(i,:)),' }',varname(varargin{i}),'}')
%            text(.5,a(1,2)-i*500,[ssstring])
    end
    %}