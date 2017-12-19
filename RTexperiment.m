function experiment = RTexperiment (path,documentation, numOfFiles)
%this adds the tracks using the RTimportTRacks function for an entire
%folder containing several sub-folders for each experiment. it puts everything in the experiment variable, using the sub-folder
%names as variable names.  


fullPaths = dir2(path);
names = dir(path);

% now lets delete all files beginning with a dot (hidden files and such):
j=1;
for i=1:length(names)
   if names(i).name(1)=='.'
       index(j) = i;
       j=j+1;
   end
end

names(index)=[];

experiment = struct;

%RUN:
for i=1:numOfFiles
    try
        experiment.(names(i).name)= RTimportTracks(fullPaths{i},documentation);
    catch
        experiment.(strcat('RT',names(i).name))= RTimportTracks(fullPaths{i},documentation);
        
    end
end
