function [Dmean, Dstd, D_for_each_track, good_enough_fit] = diffusionCoeficient (varargin)

ma = varargin{1};
if length(varargin)==1
   fitFilter = 0.8;
else
    fitFilter = varargin{2};
end
   
try
good_enough_fit = ma.lfit.r2fit > fitFilter;
catch
    ma = ma.fitMSD
    good_enough_fit = ma.lfit.r2fit > fitFilter;
end
Dmean = mean( ma.lfit.a(good_enough_fit) ) / 2 / ma.n_dim;
Dstd  =  std( ma.lfit.a(good_enough_fit) ) / 2 / ma.n_dim/length(good_enough_fit);

D_for_each_track = ma.lfit.a(good_enough_fit)./ 2 ./ ma.n_dim;