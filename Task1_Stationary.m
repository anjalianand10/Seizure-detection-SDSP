clc
%loading and filtering the eye blinks
[eeg,f,T,t,n] = loadeeg();
%plot (t,eeg)

truemean= mean(eeg);

%segmenting
dur_of_seg=2;       %Set to whatever segment duration
ts=(0:1/f:dur_of_seg-(1/f));
ns=length(ts);
nseg=n/ns;
seg=zeros([nseg,ns]);
for k= 1:nseg
    seg(k,:)=eeg((k-1)*ns+1:k*ns);
end

avgs=[];
plotavgs=[];
for k=1:nseg
    avgs(k)= mean(seg(k,:));
    plotavgs((k-1)*ns+1:(k)*ns)= avgs(k);
end

if all(avgs == avgs(1))
    disp('Sequence is stationary as it has constant mean of ', num2str(truemean) ,' over all segments')
else 
    disp(['Sequence is not stationary as it does not have constant mean of ', num2str(truemean) ,' over all segments'])
end

%Visualisation
plot(t, plotavgs,t,ones(1,length(t))*truemean)
xlabel("Time")
ylabel("Mean")
legend('Mean of segments','True mean');

