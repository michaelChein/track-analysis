function RTfixmaC (maC)

    for i= 1:length(maC.tracks)%    for each track 
     
        for j=2:length(maC.tracks{i})%      for each point
            if maC.tracks{i}(j,1) <= maC.tracks{i}(j-1,1)
                maC.tracks{i}=[];
                break
            end
        end
    end
    
end