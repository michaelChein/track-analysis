
function [average, stdErr ,a ,b] = RTplotTrackAnalysis (varargin)
% plot all input variables in a subplot. bar graph with errors, and area
% for hist.
% using --barweb(average, stdErr, width, groupnames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend, error_sides, legend_type)
% last input variable should be groupnames.
% a and b are the handles to the figures.

%---------------INITIALIZE VARIABLES:
                PARAMETERS = 2;

%   Speed
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,1)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.Speed);
            stdErr(i) = std(varargin{i}.results.Speed)/sqrt(length(varargin{i}.results.Speed)-1);
        end
   
  %  barweb(average, stdErr, [], [], 'Speed', [], 'µm/sec', 'Gray', [], varargin{end}, 2, 'axis')
   a(1) = bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('Speed');
   %to add averages and stdErr to the graph:
   %title(horzcat('Speed (average: ',num2str(average(1)),' ',num2str(average(2)),' stE: ', num2str(stdErr(1)), ' ',num2str(stdErr(2)),')'))
   ylabel('µm/sec');
   hold on;
   b(1) = errorbar(average, stdErr, 'k.');

    

    %   percentage stopped:
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,2)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.P_stopped*100);
            stdErr(i) = std(varargin{i}.results.P_stopped*100)/sqrt(length(varargin{i}.results.P_stopped*100));
        end
   
   % barweb(average, stdErr, [], [], '% Stopped', [], '%', 'Gray', [], varargin{end}, 2, 'axis')
      a(2) =  bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('% stopped')
      %to add averages and stdErr to the graph:
   %title(horzcat('% stopped (average: ',num2str(average(1)),' ',num2str(average(2)),' stE: ', num2str(stdErr(1)), ' ',num2str(stdErr(2)),')'))
   ylabel('%');
   hold on;
   b(2) = errorbar(average, stdErr, 'k.');
%{
  subplot(PARAMETERS,2,4) -----------------------Left overs from an old
  code.
  for i=1:length(varargin)-1
            minVal(i) = min(varargin{i}.P_stopped);
            maxVal(i) = max(varargin{i}.P_stopped);
        end
        minVal = min(minVal);
        maxVal = max(maxVal);

    x = linspace(minVal, maxVal, 100);
        for i=1:length(varargin)-1
            Y(:,i) = histc(varargin{i}.P_stopped,x);
        end
    area(x,Y);
    legend(varargin{end})
    
    %   stop count:
%}
    average = [];
    stdErr = [];
subplot(PARAMETERS,2,3)
        for i=1:length(varargin)-1
            average(i) = mean(varargin{i}.results.Stop_count);
            stdErr(i) = std(varargin{i}.results.Stop_count)/sqrt(length(varargin{i}.results.Stop_count));
        end
   % barweb(average, stdErr, [], [], 'Stop count per second', [], '#', 'Gray', [], varargin{end}, 2, 'axis')
     a(3) =  bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('Stop count per second')
      %to add averages and stdErr to the graph:
   %title(horzcat('Stop count per second (average: ',num2str(average(1)),' ',num2str(average(2)),' stE: ', num2str(stdErr(1)), ' ',num2str(stdErr(2)),')'))
   ylabel('#');
   hold on;
   b(3) = errorbar(average, stdErr, 'k.');


    %   stop duration:
  
for i=1:length(varargin)-1
      temp= [];
    stops = varargin{i}.stops;
   for j=1:length(stops)
       temp =cat(1,temp,stops{j}(:,3) );
   end 
   temp= temp*varargin{i}.documentation.frameInterval;
   average(i) = mean(temp);
   stdev(i) = std(temp)/sqrt(length(temp)-1);
end

%[h, p] = ttest2(x5,x6)
subplot(2,2,4)
 a(4) = bar(average,'w');
   set(gca,'xticklabel', varargin{end});
   title('Stop duration')
      %to add averages and stdErr to the graph:
   %title(horzcat('Stop duration (average: ',num2str(average(1)),' ',num2str(average(2)),' stE: ', num2str(stdErr(1)), ' ',num2str(stdErr(2)),')'))
   ylabel('sec')
   hold on;
   b(4) = errorbar(average, stdev, 'k.');
   
   
