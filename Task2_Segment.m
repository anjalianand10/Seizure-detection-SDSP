clc
[eeg,f,T,t,n] = loadeeg();
plot (t,eeg)

%segmenting the signal
dur_of_seg=5;       %Set to whatever segment duration
ts=(0:1/f:dur_of_seg-(1/f));
ns=length(ts);
nseg=n/ns;
seg=zeros([nseg,ns]);
for k= 1:nseg
    seg(k,:)=eeg((k-1)*ns+1:k*ns);
end
disp(['Signal has been segmented into ',num2str(nseg),' parts'])

%To visualise 
hold ("on")
for k=1:nseg
    ax(k)= subplot(1,nseg,k);
    plot(t((k-1)*ns+1:k*ns), seg(k,:))
    axis("tight")
    xlabel("Time")
    ylabel("Amplitude")
    title(["Segment " + num2str(k)])
end
linkaxes(ax,'y')
hold('off')

