function RTtrackMap(dataSet,documentation, trackNumber)
 

v = dataSet.ma.getVelocities{trackNumber};
vectorVelocity = sqrt((v(:,2).^2)+(v(:,3).^2))';
vectorVelocityNormalizedToFrameInterval = vectorVelocity/documentation.frameInterval;
vectorVelocityMultipliedByX = vectorVelocityNormalizedToFrameInterval'.*-sign(v(:,2));

% plot the velocities (not normalized to X), over time as a heat map:
subplot(8,1,1)
imagesc(vectorVelocityNormalizedToFrameInterval)
title('velocity')

%plot the beginning and end of stops:
subplot(8,1,2)
try
[~, ~, stops] = analyzeTracks (dataSet.maNew, documentation);
catch
[~, ~, stops] = analyzeTracks (dataSet.ma, documentation);    
end
    st = zeros(1,length(vectorVelocityNormalizedToFrameInterval));
for i=1:size(stops{trackNumber},1)    
    st(stops{trackNumber}(i,1)-1:stops{trackNumber}(i,2)-1) = 1;
end
imagesc(st)
title('stops(in red)')

subplot(8,1,3)
plot(-sign(v(:,2))')
title('direction(1: retro, -1: antero, 0: 0)')

