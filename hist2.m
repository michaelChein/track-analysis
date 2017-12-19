function [histFreq, histXout] = hist2 (varargin)

% This function plots histogram as precentage.
if length(varargin) == 1;
    [histFreq, histXout] = hist(varargin{1});
    bar(histXout, histFreq/sum(histFreq)*100);
else if length(varargin) == 2;
        [histFreq, histXout] = hist(varargin{1},varargin{2});
        bar(histXout, histFreq/sum(histFreq)*100);   
    else if length(varargin) == 3;
        [histFreq, histXout] = hist(varargin{1},varargin{2});
        bar(histXout, histFreq/sum(histFreq)*100,varargin{3});
        else
        [histFreq, histXout] = hist(varargin{1},varargin{2});
        stairs(histXout, histFreq/sum(histFreq)*100,varargin{3});
        end
    end 
end
ylabel('%')