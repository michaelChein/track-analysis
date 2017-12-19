function RTplotHist (varargin)
%plot histogram of instantanious velocities.
%last variable should be legend.

figure;
colors = jet;
for i=1:length(varargin)-1
vTotal = RTvelocity(varargin{i}.maFILTERED,varargin{i}.documentation);
x= -5.2:0.4:5.2;
v = hist(vTotal,x);

b=-5:0.01:5;

plot (b,interp1(x,v/length(vTotal),b,'pchip'),'Color',colors(i*10,:)); hold on

end

xlabel('Speed (µm/Sec')
ylabel('Rate')
legend (varargin{end})
xlim ([-2 4])
