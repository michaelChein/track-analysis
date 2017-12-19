function i = RTfindTrack(dataSet, cursor_info)
for i=1:length(dataSet.ma.tracks)
    for ii=1:length(dataSet.ma.tracks{i})
       if dataSet.ma.tracks{i}(ii,2:3) == cursor_info.Position
          return 
       end
    end
end

end