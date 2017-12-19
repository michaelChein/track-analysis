function ma = createMaFromTxt (files, documentation)

%   this function goes over a list of paths and returns an ma
%   (msdanalyzer) variable.
%   it requires a full path (it is recommended to use dir2.m) and a
%   documentation variable.

%   example: createMaFromTxt (files, documentation), where files =
%   {'c/desktop/control/1.txt',c/desktop/control/2.txt...etc}
%

if class(files) == 'cell'
    
    for ii=1:length(files)
        ma{ii} = readTheFile (files{ii}, documentation.pixelSize, documentation.frameInterval);
    end
    
    Tracks = {};
    
    for ii=1:length(ma)
        Tracks = cat(1,Tracks,ma{ii}.tracks);
    end
    
    maCombined = msdanalyzer(2, 'µm', 'sec');
    maCombined = maCombined.addAll(Tracks);
    ma = maCombined;
    
else % in case there is only one path:
    ma = readTheFile (files, documentation.pixelSize, documentation.frameInterval);
end

    function [ma, fileRead] = readTheFile (fileName, pixelSize, frameInterval)
        %   this function reciveves a path for  a text file and creates a ma file.
        %   it also creates an index for the times.
        
        fileRead = dlmread(fileName,'\t', 1,0); % Ignore first row (headers).
        trackNumbers = unique(fileRead(:,2));
        
        for i=1:length(trackNumbers)
            tracks{i}(:,1) = (fileRead(fileRead(:,2)==trackNumbers(i),3)-1)*frameInterval;
            tracks{i}(:,2:3) = fileRead(fileRead(:,2)==trackNumbers(i),4:5)*pixelSize;
        end
        
        %  check if there are any errors in the data:
        marker=[];
        for i= 1:length(tracks)%    for each track
            
            for j=2:size(tracks{i},1)%      for each point
                if tracks{i}(j,1) <= tracks{i}(j-1,1)
                    marker(end+1)=i;
                    break
                end
            end
        end
        disp(fileName)
        disp(num2str(length(marker))) %marker indicates tracks that were excluded because of some error. if all is well it shouldt appear on screen.
        tracks(:,marker) = [];
        
        ma = msdanalyzer(2, 'µm', 'sec');
        ma = ma.addAll(tracks);
    end

end
