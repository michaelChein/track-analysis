function RTplotVelocityHistograms(varargin)
%example: RTplotVelocityHistograms(control,hetro_NGF,docu,{'one','two'})
range = linspace(0,10,20);
documentation = varargin{end-1};
cc={'b','r','g','c'};

n = ceil(sqrt(length(varargin)-2));
for i=1:length(varargin)-2
    dataSet = varargin{i};
    if n==2
        a(i) = subplot(1,2,i);
    else
        a(i) = subplot(n,n,i);
    end
    
    v = dataSet.ma.getVelocities;
    v = vertcat(v{:});
    vectorVelocity = sqrt((v(:,2).^2)+(v(:,3).^2))'/documentation.frameInterval;
    vectorVelocityMultipliedByX = sqrt((v(:,2).^2)+(v(:,3).^2)).*sign(v(:,2))/documentation.frameInterval;
    c{i} = histc(vectorVelocity,range);
    c{i} = (c{i}/sum(c{i}))*100;
    bar(range,c{i}, cc{i})
    title(varargin{end}{i})
    xlabel('velocity(µm/sec)')
    ylabel('%')
end



linkaxes(a)
zoom xon

figure
for i=1:length(c)
    stairs(range,c{i}, cc{i}); hold on
    xlabel('velocity(µm/sec)')
    ylabel('%')
end

