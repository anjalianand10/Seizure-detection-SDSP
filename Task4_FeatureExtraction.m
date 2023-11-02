clc
%loading the data
[eeg,f,T,t,n] = loadeeg();
%plot(t,eeg)

%AR Modelling
x=eeg;
data=  iddata(x.', [],1/f);
sys = ar(data(1:500,:,:),5,'yw');       %Generating a fifth order model using a 2 second segment of the main signal
sys

%Feature extraction
yp = predict(sys,data,10);
subplot(211)
plot(data,yp);
title('Signal vs AR modeling prediction')
legend('Estimation data','Predicted data');
subplot(212)
d=((data.y-yp.y).^2);
plot(t,d);
xlabel("Time")
ylabel("(Signal-Prediction)^2")
title('Squared error between the signal and its prediction')