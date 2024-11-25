clc;clear;close all

load('Signal_F_V1.mat','X_xx');
%% Q1
LX=length(X_xx);
fs=10000;
f=-5000:fs/LX:5000-1/LX;
t=-10:1/fs:10;
fc=20000;
tt=10;
fc1=input('fc1= ');
fc2=input('fc2= ');
flp=10;

figure;
subplot(2,1,1);
plot(f,abs(X_xx));
title('abs of Xf');

xtt=ifft(ifftshift(X_xx,LX));
subplot(2,1,2);
plot(t,real(xtt));
title('real of xt');

[xt , xct , xdemodt , xfiltert , Xcf , Xdemodf , Xfilterf,filter]= DSBmodd(X_xx,fc1,fc2,flp,t,f);




errr=immse(Xfilterf,X_xx);
function [xt , xct , xdemodt , xfiltert , Xcf , Xdemodf , Xfilterf,filter]= DSBmodd(Xf,fc1,fc2,flp,t,f)
%L=length(Xf);
f1=stepfun(f,-flp);
f2=stepfun(f,flp);
filter=f1-f2;


xt=ifft(ifftshift(Xf));
xct=xt.*cos(2*pi*fc1*t);
xdemodt=xct.*cos(2*pi*fc2*t);
Xcf=fftshift(fft(xct));
Xdemodf=fftshift(fft(xdemodt));
Xfilterf=Xdemodf.*filter;
xfiltert=ifft(ifftshift(Xfilterf));

figure 
plot(f,filter);
title('filter');


figure 
subplot(2,1,1)
plot(t,real(xt));
title('xt');

subplot(2,1,2);
plot(t,real(xct));
title('xct');

figure
subplot(2,1,1);
plot(t,real(xdemodt));
title('xdemodt');

subplot(2,1,2);
plot(t,real(xfiltert));
title('xfiltert');

figure
subplot(3,1,1);
plot(f,abs(Xcf));
title('Xcf abs');

subplot(3,1,2);
plot(f,abs(Xdemodf));
title('Xdemodf abs');

subplot(3,1,3);
plot(f,abs(Xfilterf));
title('Xfilterf abs');
end



