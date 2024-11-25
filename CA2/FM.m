clc;clear;close all

%%
fs=10000;
t=0:1/fs:10-1/fs;
Ac=1;
xt=Ac.*sin(pi*t);
fc=100;
fd1=10;
fd2=0.01;

%% Q3
FM1=Fm(xt,t,Ac,fc,fd1,fs);
figure
subplot(2,1,1)
plot(t,FM1);
title('FM modulation (modulation index=10)')

NBFM1=NbFm(xt,t,Ac,fc,fd1,fs);
subplot(2,1,2)
plot(t,NBFM1);
title('NBFM modulation (modulation index=10)')

errFM1=immse(FM1,NBFM1);

%% Q4

FM2=Fm(xt,t,Ac,fc,fd2,fs);
figure
subplot(2,1,1)
plot(t,FM2);
title('FM modulation (modulation index=0.01)')

NBFM2=NbFm(xt,t,Ac,fc,fd2,fs);
subplot(2,1,2)
plot(t,NBFM2);
title('NBFM modulation (modulation index=0.01)')

errFM2=immse(FM2,NBFM2);

%% Q1&2
function [FM]=Fm(xt,t,Ac,fc,fd,fs)
xtintegral=cumsum(xt)/fs;
FM=Ac.*cos(2*pi*fc*t+2*pi*fd*xtintegral);
end

function [NBFM]=NbFm(xt,t,Ac,fc,fd,fs)
xtintegral=cumsum(xt)/fs;
NBFM=Ac.*cos(2*pi*fc*t)-Ac.*sin(2*pi*fc*t).*(2*pi*fd*xtintegral);
end