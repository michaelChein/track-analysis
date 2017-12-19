function [a, b] = bar2 (varargin)
% clean bars with stdError whiskers and siginificance astrixes!!
% bar2(averages, errors, {legend}, siginificance)

global fontSize
fontSize = 12;
   a= bar(varargin{1},'w');
   set(gca,'xticklabel', varargin{3},'FontSize',fontSize); hold on;
   b =errorbar(varargin{1}, varargin{2}, 'k.');
   if length(varargin)==4
      
       index = find(varargin{4}==1);
       for i=1:sum(varargin{4})
       plot(index(i),varargin{1}(index(i))+varargin{2}(index(i))+0.2,'k*'); 
       end
   end
   
end
