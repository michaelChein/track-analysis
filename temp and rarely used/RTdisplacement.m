function RTdisplacement (ma, md)

%   Compute track displacement
    for i=1:length(ma.tracks)
           trackDisplacements(i) = pdist([ma.tracks{i}(1,2:end); ma.tracks{i}(end,2:end)]);
    end
    
%   Compute run length

    for i=1:length(ma.tracks)
        
        for j=1:size(ma.tracks{i},1)-1
         try
             localDisplacement(j) = pdist([ma.tracks{i}(j,2:end);ma.tracks{i}(j+1,2:end)]);
         catch
             h=1;
         end
         end
        
           runlength(i) = sum(localDisplacement);
    end
    
    %   plot data
    
    subplot(1,2,1)
    bar(trackDisplacements)
    title('Track displacements')
    xlabel('Track #')
    ylabel(md.spaceUnits)
    
    subplot(1,2,2)
    bar(runlength)
    title('Run length')
    xlabel('Track #')
    ylabel(md.spaceUnits)
    

