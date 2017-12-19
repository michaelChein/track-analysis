function [x, Y] = RTplot (varargin)
x = -5:0.4:5;
for i=1:length(varargin)
    
    Y(:,i) = histc(varargin{i},x)/length(varargin{i});

end

