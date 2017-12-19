function histogramAnalysisForNoga (database)

subplot(1,3,1)
x=linspace(0,5,10);
bin_GUI([cell2mat(database.vectorVelocity)',cell2mat(database.vectorVelocity)'],[cell2mat(database.vectorVelocityMultipliedByX'),cell2mat(database.vectorVelocityMultipliedByX')])


subplot(1,2,1)
hist(database.results.Run_length)
title('Run length')
xlabel('µm')
ylabel('#')

subplot(1,2,2)
hist(database.results.Track_displacement)
title('Track diaplacement')
xlabel('µm')
ylabel('#')