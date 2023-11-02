clc
%loading the data
[eeg,f,T,t,n] = loadeeg();
%plot(t,eeg)

%AR Modelling
x=eeg;
data=  iddata(x.', [],1/f);
sys = ar(data(1:500,:,:),5,'yw');      
sys

%Feature extraction
yp = predict(sys,data,10);
d=(data.y-yp.y).^2;

dur_of_seg=0.5;       %Set to whatever segment duration
ts=(0:1/f:dur_of_seg-(1/f));
ns=length(ts);
nseg=n/ns;
mse=[];

for k= 1:nseg
    mse((k-1)*ns+1:(k)*ns)= mean(d((k-1)*ns+1:(k)*ns))./n;
end

plot(t, mse)
xlabel("Time")
ylabel("MSE")
title('Mean square error of the predicted signal')

for i=1:n
    if (mse(i)>0.033)
        disp(['Siezure starts at ',num2str(i/f),'s']);
        break
    end
end