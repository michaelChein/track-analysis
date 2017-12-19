function tmSteps (varargin)

for i=1:length(varargin)
hist2(varargin{i}.results.Speed,20);hold on 
end