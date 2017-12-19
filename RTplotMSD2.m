function maNEW = RTplotMSD2 (varargin)
%   plot msd for each var. 
%   last variables should be documentation and legend.

%   example: RTplotMSD2(control, treated, docu,{'control','treated'})


colors = ['b', 'r', 'g', 'c', 'y', 'm', 'k'];
    for i=1:length(varargin)-2
        tempTracks = [];
        maNEW = [];
        for j=1:length(varargin{i}.ma.tracks)
            tempTracks{j} = varargin{i}.ma.tracks{j};
            n = varargin{end-1}.pixelSize;
           
            tempTracks{j}(:,2) = tempTracks{j}(:,2) * n;
            tempTracks{j}(:,3) = tempTracks{j}(:,3) * n;


        end
        maNEW = msdanalyzer(2, 'µm', 'sec');
        maNEW = maNEW.addAll(tempTracks);
        maNEW = maNEW.computeMSD;
        
        maNEW = maNEW.fitLogLogMSD(0.25);
        maNEW.loglogfit
        varargin{end}{i} = strcat(varargin{end}{i},' (',num2str(nanmean(maNEW.loglogfit.alpha)),')');
        
        mmsd = maNEW.getMeanMSD;
        t = mmsd(:,1);
        x= mmsd(:,2);
        dx = mmsd(:,3) ./ sqrt(mmsd(:,4));
        dx(abs(dx)==Inf|isnan(dx))=[];
        x(length(dx)+1:end)=[];
        t(length(dx)+1:end)=[];
        
        % Adjust to frame interval:
        x = x/varargin{end-1}.frameInterval;
        dx = dx/varargin{end-1}.frameInterval;
        
%--------errorbar:
          h = errorbar(t, x, dx, colors(i));
          errorbar_tick(h,550,[])
          hold on
   
%--------shadded error bar:
       % shadedErrorBar(t',x',dx',{strcat(colors(i),'-o'),'markerfacecolor',colors(i)},1);
        %hold on;
        % scatter(t',x','o')    
        %hold on
    end
   

     xlim([0 100])
     legend(varargin{end})
   
     xlabel('Time (sec)');
     ylabel('Distance (µm)');
    
    
    
