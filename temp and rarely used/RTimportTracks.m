
function [ma, md, tracks] = RTimportTracks(trackPaths)
% This function goes over cell arrays containing paths for trackMate file
% paths and/or xls file paths, and imports the tracks to the variable "ma".
% note- in its current version, there is yet no support for xls.

ma = msdanalyzer(2, 'µm', 'sec');

for i=1:length(trackPaths)
   [tracks, md] = importTrackMateTracks(trackPaths{i},1); 
   %ma = ma.addAll(tracks);
end


