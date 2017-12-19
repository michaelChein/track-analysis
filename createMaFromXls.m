
function [maArray, cells] = createMaFromXls (path,documentation)
%   this function was built to accept txt files created with imageJ's manual tracking   


[status, sheets] = xlsfinfo(path);

for i=1:length(sheets)
    tempTracks = [];
    try
        tempTracks = xlsread(path, sheets{i}); %this will work for some versions of xls files.
    catch
        tempTracks = xlsread(path,i); %this will work for some other versions of xls files.
    end
    cells{i}.Name = sheets{i};
    try
        numberOfPunctas = max(tempTracks(:,2)); %this is for each time the track number chnges. hence, the number of tracks.
    catch
        disp(strcat('there was an error. possibly a problem with sheet number ', num2str(i)));
        continue;
    end
    
    k=1; %some of the tracks areappearently empty, so i use the if loop and advance k only when the track is longer than 0.
    for j=1:1
        if 1==1;
           % if corr([1:length(tempTracks(tempTracks(:,2)==j))]',tempTracks(tempTracks(:,2)==j,4))==1;
                cells{i}.Tracks{k}(:,1) = [1:size(tempTracks)];
                cells{i}.Tracks{k}(:,2:3) = tempTracks(:,2:3)*documentation.pixelSize;

                k=k+1;
            %end
        end
    end
    
 %   set y to constant.
 %   for kkk=1:length(cells{i}.Tracks)
 %       cells{i}.Tracks{kkk}(:,3)=1;
 %  end
    
    temp_ma = msdanalyzer(2, '??m', 'sec');
    try
    temp_ma = temp_ma.addAll(cells{i}.Tracks);
    cells{i}.ma.ma = temp_ma;
    %[cells{i}.results, cells{i}.ma.maFILTERED]  = analyzeTracks (cells{i}.ma.ma, documentation1);
    cells{i}.documentation = documentation;
    temp_ma = temp_ma.fitLogLogMSD
    maArray{i} = temp_ma;
    
    % export(cells{i}.results,'file',strcat('/Users/michael/Desktop/nogas data/',cells{i}.Name,'.txt'))
     catch
    end
end


end