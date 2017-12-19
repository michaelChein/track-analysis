
figure

Y(1) = mean(vTotal_RV);
Y(2) = mean(vTotal_NGF);
Y(3) = mean(vTotal_RV_p75);
Z(1) = std(vTotal_RV)/sqrt(length(vTotal_RV)-1);
Z(2) = std(vTotal_NGF)/sqrt(length(vTotal_NGF)-1);
Z(3) = std(vTotal_RV_p75)/sqrt(length(vTotal_RV_p75)-1);

subplot(2,3,[1:3])
 barweb(Y, Z, [], [], 'Instantaneous velocities', [], 'µm/sec', 'Gray', [], groupNames', 2, 'axis')
 
 subplot(2,3,4)
    hist(vTotal_RV,100)
    title('RV');
 subplot(2,3,5)
    hist(vTotal_NGF,100)
    title('NGF');
 subplot(2,3,6)
    hist(vTotal_RV_p75,100)
    title('RV p75');

    