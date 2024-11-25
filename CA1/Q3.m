clc;clear;close all


%% first function in time 
figure

ts=0.01;
t1=0:ts:9-ts;
L=length(t1);
x1=sin(2*pi*20*t1)+sin(2*pi*40*t1);
plot(t1,x1);
title('S1');

%% second function in frequency
figure

t2=0:ts:5-ts;
x2=sin(2*pi*20*t2);

t3=5:ts:9-ts;
x3=sin(2*pi*40*t3);

x4=[x2 x3];
%x4=cat(2,x2,x3);
plot(x4);
title('S2')



%% first function in frequency
figure

fs=1/ts;
%L=lenght(t);
%f=0:fs/L:fs-fs/L;
f=-fs/2:fs/L:fs/2-fs/L;

x1f=fftshift(fft(x1),length(x1));

subplot(2,1,1);
plot(f , abs(x1f));
title('abs of fourier of x1');

subplot(2,1,2);
plot(f,angle(x1f));
title('ang of fourier of x1');

%% second function in frequency 
figure

x4f=fftshift(fft(x4,length(x4)));

subplot(2,1,1);
plot(f , abs(x4f));
title('abs of fourier of x4');

subplot(2,1,2);
plot(f , angle(x4f));
title('ang of fourier of x4');

%% spectrogram 
figure
spectrogram(x1, 512 , 256 ,512 ,fs)

figure
spectrogram(x4, 128 , 80 ,256 ,fs)