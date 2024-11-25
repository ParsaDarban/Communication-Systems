clc;clear;close all

%% PART1

x=0:1/100:5-1/100;
fzx=x.*exp((-x.^2)/(2));
Fzx=1-exp((-x.^2)/(2));
figure
subplot(2,1,1);
plot(x,fzx);
title PDF; xlabel z; ylabel PDF;
subplot(2,1,2);
plot(x,Fzx);
title CDF; xlabel z; ylabel CDF;

%% PART2&4

N=input('N= ');
x=randn(1,N);
y=randn(1,N);
xb=mean(x);
yb=mean(y);
xvar=var(x);
yvar=var(y);
bin=100;
figure
subplot(2,1,1);
histogram(x,bin);
title x histogram; xlabel x; ylabel PDF;
subplot(2,1,2);
histogram(y,bin);
title y histogram; xlabel y; ylabel PDF;
%% PART3

z=sqrt((x.^2)+(y.^2));
zb=mean(z);
zvar=var(z);
figure;
histogram(z,bin);
title Rayleigh histogram; xlabel z; ylabel PDF;