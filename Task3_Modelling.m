clc
%loading the data
[eeg,f,T,t,n] = loadeeg();
%plot(t,eeg)

%AR Modelling
x=eeg;
data=  iddata(x.', [],1/f);
sys = ar(data(1:500,:,:),5,'yw');       %Generating a fifth order model using a 2 second segment of the main signal
sys
yp = predict(sys,data,10);
plot(data,yp);
legend('Estimation data','Predicted data');
