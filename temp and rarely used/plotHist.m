vTotalRV = RTvelocity(maRV_F,documentation);
vTotalNGF = RTvelocity(maNGF_F,documentation);
vTotalRVminusP75 = RTvelocity(maRVminusP75_F,documentation);
vTotalRVp75 = RTvelocity(maRV_p75_F,documentation);
vTotalRV_NGF = RTvelocity(maRV_NGF_new_F,documentation);
vTotalRV_NGF_slow = RTvelocity(maRV_NGF_new_slow,documentation);
vTotalRV_NGF_fast = RTvelocity(maRV_NGF_new_fast,documentation);
vTotalRV_new = RTvelocity(RV_new_F,documentation);
vTotalNGF_new = RTvelocity(NGF_new_F,documentation);


x= -5.2:0.4:5.2;
vNGF = hist(vTotalNGF,x);
vRV = hist(vTotalRV,x);
%vRVminusP75 = hist(vTotalRVminusP75,x);
%vRVp75 = hist(vTotalRVp75,x);
vRV_NGF = hist(vTotalRV_NGF,x);
vRV_NGF_slow = hist(vTotalRV_NGF_slow,x);
vRV_NGF_fast = hist(vTotalRV_NGF_fast,x);
vRV_new = hist(vTotalRV_new,x);
vNGF_new = hist(vTotalNGF_new,x);


close all
b=-5:0.01:5;
%plot (b,interp1(x,vRV/length(vTotalRV),b,'pchip')); hold on
%plot (b,interp1(x,vNGF/length(vTotalNGF),b,'pchip'));
figure;
%plot (b,interp1(x,vRV/length(vTotalRV),b,'pchip'));hold on
%plot (b,interp1(x,vNGF/length(vTotalNGF),b,'pchip')); hold on;

plot (b,interp1(x,vRV/length(vTotalRV),b,'pchip'),'b-'); hold on
plot (b,interp1(x,vRV_new/length(vTotalRV_new),b,'pchip'),'b--');
plot (b,interp1(x,vNGF/length(vTotalNGF),b,'pchip'),'r-');
plot (b,interp1(x,vNGF_new/length(vTotalNGF_new),b,'pchip'),'r--');



xlabel('Speed (µm/Sec')
ylabel('Rate')
legend ({'RV', 'RV_new','NGF','NGF_new'})
xlim ([-2 4])

clear x1 x2 x3 vTotalRV vTotalNGF vTotalRVminusP75 vTotalRVp75 vTotalRV_NGF x vNGF vRV vRVminusP75 vRVp75 vRV_NGF
