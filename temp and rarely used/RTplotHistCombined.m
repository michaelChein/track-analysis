function RTplotHistCombined (varargin)
%this was created to deal with the reversed data as in- left right- antero
%retro..
%the function combines varargins 1 and 2, and 3 and 4..
%plot histogram of instantanious velocities.
%last variable should be legend!!!

figure;
colors = jet;
for i=[1,3]
vTotal_1 = RTvelocity(varargin{i}.maFILTERED,varargin{i}.documentation);
vTotal_2 = RTvelocity(varargin{i+1}.maFILTERED,varargin{i+1}.documentation)*-1;

vTotal = cat(1,vTotal_1,vTotal_2);

x= -5.2:0.4:5.2;
v = hist(vTotal,x);

b=-5:0.01:5;

plot (b,interp1(x,v/length(vTotal),b,'pchip'),'Color',colors(i*10,:)); hold on

end

xlabel('Speed (µm/Sec')
ylabel('Rate')
legend (varargin{end})
xlim ([-2 4])
