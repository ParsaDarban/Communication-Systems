clc;clear;close all

%%
fs=10000;
t=0:1/fs:10-1/fs;
Ac=1;
xt=sin(pi*t);
fc=100;
phd1=10;
phd2=0.01;

%% Q3
PM1=Pm(xt,t,Ac,fc,phd1);
figure
subplot(2,1,1)
plot(t,PM1);
title('PM modulation (modulation index=10)');

NBPM1=NbPm(xt,t,Ac,fc,phd1);
subplot(2,1,2)
plot(t,NBPM1);
title('NBPM modulation (modulation index=10)');

errPM1=immse(PM1,NBPM1);

%% Q4
PM2=Pm(xt,t,Ac,fc,phd2);
figure
subplot(2,1,1)
plot(t,PM2);
title('PM modulation (modulation index=0.01)');


NBPM2=NbPm(xt,t,Ac,fc,phd2);
subplot(2,1,2)
plot(t,NBPM2);
title('NBPM modulation (modulation index=0.01)');

errPM2=immse(PM2,NBPM2);

%% Q1&2
function  [PM]=Pm(xt,t,Ac,fc,phd)
PM=Ac.*cos(2*pi*fc*t + phd.*xt);
end

function [NBPM]=NbPm(xt,t,Ac,fc,phd)
NBPM=Ac.*cos(2*pi*fc*t)-Ac.*phd.*xt.*sin(2*pi*fc*t);
end
