function files = dir2 (path)

tempFiles = dir(path);

j=1;  % now lets delete all files beginning with a dot (hidden files and such).
for i=1:length(tempFiles)
   if tempFiles(i).name(1)=='.'
       index(j) = i;
       j=j+1;
   end
end

tempFiles(index)=[];

for  i=1:length(tempFiles)
    files{i}= strcat(path,'/',tempFiles(i).name);
end


