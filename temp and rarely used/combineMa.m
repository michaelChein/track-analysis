function maCombined = combineMa (varargin)
%this function eccepts either multiple ma files or an array of ma files and
%outputs one cimbined ma file.

if length(varargin)==1 %which means it is an array.
    tracks = {};
    
    for i=1:length(varargin{1})
        tracks = cat(1,tracks,varargin{1, 1}{1, i}.tracks);
    end
    
    maCombined = msdanalyzer(2, 'µm', 'sec');
    maCombined = maCombined.addAll(tracks);
else
    tracks = {};
    
    for i=1:length(varargin)
        tracks = cat(1,tracks,varargin{i}.tracks);
    end
    
    maCombined = msdanalyzer(2, 'µm', 'sec');
    maCombined = maCombined.addAll(tracks);
end

maCombined = maCombined.fitLogLogMSD;