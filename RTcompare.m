function RTcompare (varargin)
%RTcompare(control,treated,documentation)

C = jet();

% this part adds legends for the different groups based on the input name.
% if you want to overide this, simply comment it out and set nameLG be
% whatever you want:
if nargin == 1
    varargin = varargin{1};
    for i=1:length(varargin)-1
        nameLG{i} = num2str(i);
    end
else
    
    for i=1:length(varargin)-1
        nameLG{i} = inputname(i);
    end
end

%nameLG = {'wt', 'mSOD','mSOD_Ab','wt_after'};



%plot some bars:
%try

figure(1)% for the bars. figure(2) is for the distributions.

%===========================================================================
%   vector velocity    
for i=1:length(varargin)-1
v = vertcat(varargin{i}.ma.getVelocities{:});
vectorVelocity = sqrt((v(:,2).^2)+(v(:,3).^2))';
vectorVelocityNormalizedToFrameInterval = vectorVelocity/varargin{end}.frameInterval;
vectorVelocityMultipliedByX = vectorVelocityNormalizedToFrameInterval'.*-sign(v(:,2));
average(i) = mean(vectorVelocityNormalizedToFrameInterval);
stE(i) = stdErr(vectorVelocityNormalizedToFrameInterval);
figure(2)
subplot(3,3,1)
if i==1
hist2(vectorVelocityNormalizedToFrameInterval,20, 'b'); hold on
else
hist2(vectorVelocityNormalizedToFrameInterval,20, 'r')    
end
title('instantaneous velocities')
xlabel('(µm/sec)')
end
figure(1)
subplot(3,3,1)
bar2(average,stE,nameLG)
title('instantaneous velocities')
 rotateXLabels( gca(), 45 )
ylabel('(µm/sec)')

%========================================================================

subplot(3,3,2)
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.results.Average_velocity_x);
    stE(i) = stdErr(varargin{i}.results.Average_velocity_x);
    figure(2)
    subplot(3,3,2)
    if i==1
    hist2(varargin{i}.results.Average_velocity_x,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Average_velocity_x,20, 'r')    
    end
title('Average velocity')
xlabel('(µm/sec)')
end

figure(1)
subplot(3,3,2)
bar2(average,stE,nameLG) 
title('Average velocity')
 rotateXLabels( gca(), 45 )
ylabel('(µm/sec)')


%======================================================================== 
 
for i=1:length(varargin)-1
    temp = varargin{i}.results.Average_stop_duration(varargin{i}.results.Average_stop_duration~=0)
    average(i) = mean(temp);
    stE(i) = stdErr(temp);
        figure(2)
    subplot(3,3,3)
    if i==1
    hist2(varargin{i}.results.Average_stop_duration,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Average_stop_duration,20, 'r')    
    end
title('average stop duration')
xlabel('(sec)')
end

figure(1)
subplot(3,3,3)
bar2(average,stE,nameLG)
title('average stop duration')
 rotateXLabels( gca(), 45 )
ylabel('(sec)')
%========================================================================
 
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.results.Direction_changes);
    stE(i) = std(varargin{i}.results.Direction_changes)/sqrt(length(varargin{i}.results));
    figure(2)
    subplot(3,3,4)
    if i==1
    hist2(varargin{i}.results.Direction_changes,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Direction_changes,20, 'r')    
    end
title('Direction changes')
xlabel('#')
end

figure(1)
subplot(3,3,4)
bar2(average,stE,nameLG)
title('Direction changes')
 rotateXLabels( gca(), 45 )
ylabel('#')
%========================================================================

 
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.results.Stop_count);
    stE(i) = std(varargin{i}.results.Stop_count)/sqrt(length(varargin{i}.results));
    figure(2)
    subplot(3,3,5)
    if i==1
    hist2(varargin{i}.results.Stop_count,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Stop_count,20, 'r')    
    end
title('stop count')
xlabel('#')
end
figure(1)
subplot(3,3,5)
bar2(average,stE,nameLG)
title('stop count')
 rotateXLabels( gca(), 45 )
ylabel('#')
%========================================================================

 
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.results.Track_displacement);
    stE(i) = std(varargin{i}.results.Track_displacement)/sqrt(length(varargin{i}.results));
    figure(2)
    subplot(3,3,6)
    if i==1
    hist2(varargin{i}.results.Track_displacement,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Track_displacement,20, 'r')    
    end
title('track displacement')
xlabel('µm')
end
figure(1)
subplot(3,3,6)
bar2(average,stE,nameLG)
title('track displacement')
 rotateXLabels( gca(), 45 )
ylabel('µm')
 %===================================================================
  
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.results.Run_length);
    stE(i) = stdErr(varargin{i}.results.Run_length);
    figure(2)
    subplot(3,3,7)
    if i==1
    hist2(varargin{i}.results.Run_length,20, 'b'); hold on
    else
    hist2(varargin{i}.results.Run_length,20, 'r')    
    end
title('Run length')
xlabel('µm')
end
figure(1)
subplot(3,3,7)
bar2(average,stE,nameLG)
title('Run length')
 rotateXLabels( gca(), 45 )
 ylabel('µm')
 %===================================================================
 for i=1:length(varargin)-1
 v = vertcat(varargin{i}.ma.getVelocities{:});
vectorVelocity = sqrt((v(:,2).^2)+(v(:,3).^2))';
vectorVelocityNormalizedToFrameInterval = vectorVelocity/varargin{end}.frameInterval;
vectorVelocityMultipliedByX = vectorVelocityNormalizedToFrameInterval'.*-sign(v(:,2));
average(i) = mean(vectorVelocityMultipliedByX);
stE(i) = stdErr(vectorVelocityMultipliedByX);
figure(2)
subplot(3,3,8)
if i==1
hist2(vectorVelocityMultipliedByX ,20, 'b'); hold on
else
hist2(vectorVelocityMultipliedByX,20, 'r')    
end
title('instantaneous velocities X')
xlabel('(µm/sec)')
end
figure(1)
subplot(3,3,8)
bar2(average,stE,nameLG)
title('instantaneous velocities X')
 rotateXLabels( gca(), 45 )
 ylabel('(µm/sec)')

 
 
end 
 
%{
try
subplot(3,3,9)
for i=1:length(varargin)-1
    [average(i), stE(i)] = diffusionCoeficient(varargin{i}.ma);
end

bar2(average*40,stE*40,nameLG)
title('diffusion coeficient')
 rotateXLabels( gca(), 45 )
catch 
end
 %}
%{
 try
subplot(3,3,5)
for i=1:length(varargin)-1
    average(i) = mean(varargin{i}.ma.loglogfit.alpha(varargin{i}.ma.loglogfit.r2fit>0.8));
    stE(i) = std(varargin{i}.ma.loglogfit.alpha(varargin{i}.ma.loglogfit.r2fit>0.8)/sqrt(length(varargin{i}.ma.loglogfit.r2fit>0.8)));
    nameLG{i} = horzcat('Axon ',num2str(i));
end

bar2(average,stE,nameLG)
title('alpha')
 rotateXLabels( gca(), 45 )
 catch
 end
%}
 %{
 try
     subplot(3,3,7)
     for i=1:length(varargin)-1
         average(i) = length(varargin{i}.results)/length(varargin{i}.cells);
         stE(i) = 0;
         nameLG{i} = horzcat('Axon ',num2str(i));
     end
     
     bar2(average,stE,nameLG)
     title('# tracks')
     rotateXLabels( gca(), 45 )
 catch
 end
 %}
%{ 
 try
subplot(3,3,8)
for i=1:length(varargin)
    try
    average(i) = length(varargin{i}.maFiltered.tracks)/length(varargin{i}.ma.tracks)*100;
    catch
    average(i) = length(varargin{i}.maFILTERED.tracks)/length(varargin{i}.ma.tracks)*100;
    end
    stE(i) = 0;
   nameLG{i} = horzcat('Axon ',num2str(i));
end

bar2(average,stE,nameLG)
title('% passing crieria')
 rotateXLabels( gca(), 45 )
 catch
 end
%}

















