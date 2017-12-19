function tracks = RTimportTracks(path,documentation)
%main function. you give it a path, and it does the rest.

tracks = struct;
files = dir2(path);
tracks.ma = createMaFromTxt (files, documentation);
[tracks.results, tracks.maFILTERED] = analyzeTracks(tracks.ma, documentation);
[junk, junk, tracks.stops,junk,tracks.vectorVelocityMultipliedByX] = analyzeTracks(tracks.maFILTERED, documentation);

documentation.path = path;
tracks.documentation = documentation;

end