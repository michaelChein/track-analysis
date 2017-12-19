function experiment = createMaFromXlsBatch (path)
%this goes over all the xls files and adds them into one variable.

documentation1 = documentation;
documentation1.name = path;
documentation1.frameInterval = 2;
documentation1.pixelSize = 0.143; 
documentation1.timeUnits = 'sec';
documentation1.spaceUnits = 'µm';

fullPaths = dir2(path);
names = dir(path);
err = {}; %error variable that will print the files not analyzed.

% now lets delete all files beginning with a dot (hidden files and such). dir2 actualy does that for the paths,
% but since this function's "names' variable also uses the built in dir function, I have to delete these files anyway.:
j=1;
for i=1:length(names)
   if names(i).name(1)=='.'
       index(j) = i;
       j=j+1;
   end
end

names(index)=[];
%fullPaths(index)=[];

%the next bit is to replace spaces or dots or whatever from folder names,
%because they dont work as variables:
for i=1:length(names)
   names(i).name = strrep(names(i).name, '+', 'plus');
   names(i).name = strrep(names(i).name, ' ', '_');
   names(i).name = strrep(names(i).name, '.', '');
end


experiment = struct;

%RUN:
for i=1:length(names)
    try
   [maArray, experiment.(names(i).name(1:end-5)).neurites] = createMaFromXls (fullPaths{i});
    catch
       err{end+1}= names(i).name(1:end-5);
    end
    
    experiment.(names(i).name(1:end-5)).ma.ma = combineMa(maArray);
    [experiment.(names(i).name(1:end-5)).results, experiment.(names(i).name(1:end-5)).ma.maFILTERED, experiment.(names(i).name(1:end-5)).stops, experiment.(names(i).name(1:end-5)).vectorVelocity, experiment.(names(i).name(1:end-5)).vectorVelocityMultipliedByX]  = analyzeTracks (experiment.(names(i).name(1:end-5)).ma.ma, documentation1);
end

disp (err)