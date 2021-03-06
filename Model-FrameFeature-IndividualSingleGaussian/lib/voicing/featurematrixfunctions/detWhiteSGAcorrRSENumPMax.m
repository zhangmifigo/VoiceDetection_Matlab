function [f] = detWhiteSGAcorrRSENumPMax(ex)
% rse, max peak, num peaks, for acorr from deterministically whitened psd

f = zeros(size(ex.fstructs,2), 3);

for i=1:size(ex.fstructs,2)
    f(i,1) = ex.fstructs(i).maxSG02;
    f(i,2) = length(ex.fstructs(i).peaksSG02);
    f(i,3) = ex.fstructs(i).relspecent;    
end
