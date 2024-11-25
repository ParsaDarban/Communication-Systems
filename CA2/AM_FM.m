clc;clear;close all

%% Q1
Ac=1;
fm=10;
fc=100;
fs=1000;
t=0:1/fs:0.2-1/fs;
xt=cos(2*pi*fm*t);
phd=3*pi/4;
fd=60;
spt=Pm(xt,t,Ac,fc,phd);
figure
subplot(2,1,1);
plot(t,spt);
title('phase modulation of x(t)');

%% Q2
L=length(spt);
f=-fs/2:fs/L:fs/2-1/L;
Spf=fftshift(fft(spt,L));
subplot(2,1,2);
plot(f,abs(Spf));
title('Fourier of phase modulation of x(t)');

%% Q3
sft=Fm(xt,t,Ac,fc,fd,fs);
figure
subplot(2,1,1);
plot(t,sft);
title('frequency modulation of x(t)');

%% Q4
Sff=fftshift(fft(sft,L));
subplot(2,1,2);
plot(f,abs(Sff));
title('Fourier of frequency modulation of x(t)');

%% Q5 
beta=(Ac*fd)/fm;
bessel=0:0.01:200;
LB=length(bessel);

for i=1:LB
    BWB(i)=BesselBW(bessel(i),fm);
end

BWC=2*fm*(bessel/Ac+1); 

figure
plot(bessel,BWB);
hold on
plot(bessel,BWC);

%% Q7
sptp=[0 spt];
sptd=diff(sptp);
sftp=[0 sft];
sftd=diff(sftp);
% tn=0:1/fs:0.2-2/fs;
figure
demodoutp=demodelating(sptd,fs);
demodoutp1=cumsum(demodoutp)/fs;
demodoutp2=Ac*fs*(demodoutp1-mean(demodoutp1))/phd;
subplot(2,1,1)
plot(t,real(demodoutp2));
title('output of demodulator for phase modulation');
subplot(2,1,2);
plot(t,xt);
title('input signal');

errp=immse(xt,demodoutp2);

figure
demodoutf=demodelating(sftd,fs);
demodoutf1=2*demodoutf/max(demodoutf);
subplot(2,1,1);
plot(t,real(demodoutf1));
title('output of demodulator for frequency modulation');

subplot(2,1,2);
plot(t,xt);
title('input signal');

errf=immse(demodoutf1,xt);

%% Functions
function  [PM]=Pm(xt,t,Ac,fc,phd)
PM=Ac.*cos(2*pi*fc*t + phd.*xt);
end

function [FM]=Fm(xt,t,Ac,fc,fd,fs)
xtintegral=cumsum(xt)/fs;
FM=Ac.*cos(2*pi*fc*t+2*pi*fd*xtintegral);
end

%% Q5
function [BW]=BesselBW(beta,fm)
err=0.01;
n=0;
bessel=besseli(n,beta);
    while bessel>= err
        n=n+1;
        bessel=besseli(n,beta);
    end
BW=2*n*fm;
end

%% Q6
function [xm]= demodelating(xct,fs)
L=length(xct);
f=-fs/2:fs/L:fs/2-fs/L;
Xcf=fftshift(fft(xct));
Xcf(f>0)=-1i.*Xcf(f>0);
Xcf(f<0)=1i.*Xcf(f<0);
xctt=ifft(ifftshift(Xcf));
xsm=sqrt((xctt.^2)+(xct.^2));
xm=xsm-mean(xsm);
end







