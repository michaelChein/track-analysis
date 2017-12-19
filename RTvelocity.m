function vTotal = RTvelocity(ma,documentation)
%   output vTotal, and-
%   Plot an histogram of the instentanious velocities, an histogram for the 
%   instantenious velocities for x and y seperatly, and a plot of te average velocity for each track. 

v = ma.getVelocities; % ...
V = vertcat( v{:} ); %  concatenate velocities (x-y).

    if max(max(V))==inf || max(max(isnan(V)))==1 || min(min(V))==-inf
%   filter out NaN's and inf's:
    [a b] = find(isnan(V)); %find the NaN's!
    a = unique(a);
    V(a,:)=[]; %delete'Em...
    
    [a b] = find(abs(V)==inf); %find the inf's!
    a = unique(a);
    V(a,:)=[]; %delete'Em...
 
    end

vTotal = sqrt((V(:,2).^2)+(V(:,3).^2)); %    vector velocity
vTotal = vTotal.* sign(V(:,2)); % vector velocity with sign according to x.

    for i=1:length(v)
        avgVelocity(i) = mean(sqrt((v{i}(:,2).^2)+(v{i}(:,3).^2))); %  get average velocity.
    end


%{    
subplot(1,3,1) %    velocities (x-y)
hist(V(:, 2:end), 50)
box off
title('velocities (x-y)')
xlabel([ 'Velocity  (' documentation.spaceUnits '/' documentation.timeUnits ')' ])
ylabel('#')
legend('x','y')

subplot(1,3,2) %    Vector velocities
hist(vTotal, 50)
box off
title('Vector velocities')
xlabel([ 'Velocity (' documentation.spaceUnits '/' documentation.timeUnits ')' ])
ylabel('#')

subplot(1,3,3) %    Average velocity for each track
bar(avgVelocity);
box off
title('Average velocity for each track')
xlabel('Track number')
ylabel([ 'Average velocity (' documentation.spaceUnits '/' documentation.timeUnits ')' ])
%}
end

