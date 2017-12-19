function RTcorrelation(cells)

S = fieldnames(cells);

for i=1:length(S)
   table(1,i) = length(cells.(S{i}).ma.tracks)/((length(dir(cells.(S{i}).documentation.path)))-2);
   table(2,i) = length(cells.(S{i}).maFILTERED.tracks)/length(cells.(S{i}).ma.tracks);
   table(3,i) = mean(cells.(S{i}).results.Speed);
   table(4,i) = mean(cells.(S{i}).results.Track_displacement);
   table(5,i) = mean(cells.(S{i}).results.Run_length);
   table(6,i) = mean(cells.(S{i}).results.Stop_count);
   table(7,i) = mean(cells.(S{i}).results.Average_stop_duration);
end

[d1,d2] = sort(table(1,:));
table = table(:,d2);

subplot(3,2,1)
x = table(1,:);
y = table(2,:);
plot(x,y,'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('total tracks/final tracks');

subplot(3,2,2)
plot(table(1,:),table(3,:),'k*')
x = table(1,:);
y = table(3,:);
plot(x,y,'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('Speed')

subplot(3,2,3)
x = table(1,:);
y = table(4,:);
plot(x,y,'k*')
plot(table(1,:),table(4,:),'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('Track displacement')

subplot(3,2,4)
x = table(1,:);
y = table(5,:);
plot(x,y,'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('run length')

subplot(3,2,5)
x = table(1,:);
y = table(6,:);
plot(x,y,'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('stop count')

subplot(3,2,6)
x = table(1,:);
y = table(7,:);
plot(x,y,'k*')
R = beatIt(x,y);
xlabel(cat(2,'# punctas. (R=',num2str(R),')'))
ylabel('average stop duration')



function [R] = beatIt(x,y)
[coeff, s]  = polyfit(x,y,1);
yFitted = polyval(coeff, x);
% Plot the fitted line over the specified range.
hold on; % Don't blow away prior plot
plot(x, yFitted, 'r-', 'LineWidth', 1);

R = 1 - s.normr^2 / norm(y-mean(y))^2;
end

end




