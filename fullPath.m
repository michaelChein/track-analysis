
function fullpath = fullPath (varargin)
[one, two] = uigetfile('..\*.*');
fullpath =  horzcat(two,one);

