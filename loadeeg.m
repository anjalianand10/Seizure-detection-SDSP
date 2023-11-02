function [eeg,f,T,t,n] = loadeeg()      %This function is for loading and filtering the eye blinks
    load('bio_eeg.mat', 'FP1segment')
    f =250;  
    T=length(FP1segment)/f;
    t= (0:1/f:T-(1/f))';
    n=length(t);
    
    %removing eye blinks
    blink = 100;  % Duration of eye blinks in samples
    for blink_time_instance = [7.9,9.6,13,15.5,18.3,19.5]
        FP1segment(blink_time_instance*f - blink/2 : blink_time_instance*f + blink/2) = NaN;
    end
    l = 1:numel(FP1segment);
    nan_indices = isnan(FP1segment); 
    FP1segment(nan_indices) = interp1(l(~nan_indices), FP1segment(~nan_indices), l(nan_indices), 'spline');
    eeg=FP1segment;
end