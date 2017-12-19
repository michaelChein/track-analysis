function RTpie(varargin)

for i=1:length(varargin)
   t = []; 
   subplot(1,length(varargin),i)
   t(1) = mean(varargin{i}.results.P_retrograde);
   t(2) = mean(varargin{i}.results.P_anterograde);
   t(3) = mean(varargin{i}.results.P_stopped);
   t(4) = 1-sum(t);
   pie3(t)
   labels = {'% retrograde', '% anterograde', '% stopped','below min speed'};
   legend(labels,'Location','southoutside','Orientation','horizontal');
   title(inputname(i))
end

