function maNEW =  MSD2converter (maOLD,documentation)

    for i=1:length(maOLD.tracks)
        tracks{i} = maOLD.tracks{i}*documentation.pixelSize;
    end
    maNEW = msdanalyzer(2, 'µm', 'sec');
    maNEW = maNEW.addAll(tracks);
end
