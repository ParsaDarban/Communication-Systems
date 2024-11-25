clc;clear;close all

%% make dirac in time and frequency
load("VarFile.mat","device_1_New","device_2_New","mixed_Used"); 
figure
t = 0:0.01:2-0.01;
hc = 0.7*(dirac(t-0.17)>0) + 0.9*(dirac(t-0.55)>0);
x = hc == Inf; % find Inf
hc(x) = 1;     % set Inf to finite value
subplot(3,1,1);
plot(t,hc);
title('Delta Dirac');

Lh=length(hc);
fsm=Lh/2;
fm = -fsm/2:fsm/Lh:fsm/2-fsm/Lh;
Hf=fftshift(fft(hc));
subplot(3,1,2);
plot(fm, abs(Hf));
title('real Hf');
subplot(3,1,3);
plot(fm, angle(Hf));
title('angle Hf');
figure
tn = 0:1/fsm:4 - 1/fsm;
zt=conv(hc, mixed_Used);
plot(tn, zt);
title('Zt');

%% input in frequency

figure

Xf=fftshift(fft(mixed_Used, 200));
fm=-fsm/2:fsm/200:fsm/2-fsm/200;
subplot(4,1,1);
plot(fm,abs(Xf));
title('real Xf');
subplot(4,1,2);
plot(fm,angle(Xf));
title('angle Xf');

Zf=Xf.*Hf;
subplot(4,1,3);
plot(fm,abs(Zf));
title('real Zf');

subplot(4,1,4);
plot(fm,angle(Zf));
title('angle Zf');


%% make and compare equalizer
%beacause td=0 & k=1 so input=output=Xf
figure
Heq=Xf./Zf;
subplot(6,1,1);
plot(fm,abs(Heq));
title('Heq simulation abs');
subplot(6,1,2);
plot(fm,angle(Heq));
title('Heq simulation angle');

a=1;
fmm=1:201;
Heq2=a./Hf;
subplot(6,1,3);
plot(fm , abs(Heq2));
title('Heq2 simulation abs');
subplot(6,1,4);
plot(fm , angle(Heq2));
title('Heq2 simulation angle');

subplot(6,1,5);
Heqexp=a./((0.7*exp(i*-1*pi*fm*0.34))+(0.9*exp(-1*i*pi*fm*1.1)));
plot(fm,abs(Heqexp));
title('Handy Heq abs');

subplot(6,1,6);
plot(fm , angle(Heqexp));
title('Handy Heq angle');
%% equalizer in time
figure

Heqt=ifft(ifftshift(Heq));
subplot(3,1,1);
plot(t,Heqt);
title('Heq in time (first route)');


Heqt2=ifft(ifftshift(Heq2));
subplot(3,1,2);
plot(t,Heqt2);
title('Heq2 in time (second route)');

Heqexpt=ifft(ifftshift(Heqexp));
subplot(3,1,3);
plot(t,Heqexpt);
title('Handy Heq in time');

%% compare output with hand and simulation system
figure
Yf=Zf.*Heq;
subplot(4,1,1);
plot(fm,abs(Yf));
title('Yf real');
subplot(4,1,2);
plot(fm,angle(Yf));
title('Yf angle');


Yfh=Zf.*Heqexp;
subplot(4,1,3);
plot(fm,abs(Yfh));
title('Yf real handy system');
subplot(4,1,4);
plot(fm,angle(Yfh));
title('Yf angle handy system');

%% compare yt and xt
figure 
Lyf=length(Yf);
subplot(3,1,1);
yt=ifft(ifftshift(Yf));
plot(t,real(yt));
title('Yf inverse fourier real');

yth=ifft(ifftshift(Yfh));
subplot(3,1,2);
plot(t,real(yth));
title('Yfh inverse fourier real');

subplot(3,1,3);
plot(t , real(mixed_Used(1:200)));
title('mixed_Used real');
%% Calculate cross correlation
figure

subplot(4,1,1);
Rxy=CorrCovv(zt,mixed_Used);
plot(Rxy);
title('zt and mixed correlation');

subplot(4,1,2); %check written fucntion with xcorr
Rxyz=xcorr(zt,mixed_Used);
plot(Rxyz);
title('check written fucntion with xcorr');


subplot(4,1,3);
Rx=CorrCovv(mixed_Used , mixed_Used);
plot(Rx);
title('mixed used auto correlation');


subplot(4,1,4);
Rxy1=conv(Rx,hc);
plot(Rxy1);
title('convolution hc and Rx');

ERR=immse(Rxy,Rxy1);

%% SDF
% 
% figure
% 
% subplot(4,1,1);
% Ry=CorrCovv(zt,zt);
% plot(Ry);
% title('Ry');
% 
% subplot(4,1,2);
% Gy=fftshift(fft(Ry));
% plot(abs(Gy));
% title('Gy');
%  
% subplot(4,1,3);
% Gx=fftshift(fft(Rx));
% plot(abs(Gx));
% title('Gx');
% 
% subplot(4,1,4);
% left=((abs(Hf)).^2);
% left2=[left  left zeros(1,200)];
% left1=Gx.*left2;
% tm = 0:2:1199;
% plot(tm,abs(left1));
% title('Gx*|Hf|^2');

%%ERRR=immse(left1,Gy);

figure

Gyy=(abs(Zf)).^2;
Gxx=(abs(Xf)).^2;
Gxxx=Gxx.*(abs(Hf).^2);

subplot(2,1,1);
plot(fm,Gxxx);
title('Gx*(|Hf|^2)');

subplot(2,1,2);
plot(fm,Gyy);
title('Gy');

ERRR=immse(Gxxx,Gyy);
