function table = MACgetSpotsFromXls (path, numberOfCells)

    for i=1:numberOfCells
    sheet = strcat(num2str(i),'.tif');
    temp = xlsread(path,sheet);
    temp(isnan(temp(:,9)),:)=[];
    table{i} = temp;
    end

end
