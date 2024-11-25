clc;clear;close all
%% PART2

fs=100;
t=-0.5:1/fs:0.5-1/fs;
A=10;
xt=zeros(100,100000);
theta=unifrnd(0,2*pi,100,100000);
for i=1:100
    xt(i,:)=A*cos(5*pi*(t(i)) + (theta(i,:)));
end
thetabar=transpose(mean(xt,2));
% ee=xt(10,:);
% eeqe=mean(ee);
plot(thetabar);
title('theta`s mean');xlabel t(s); ylabel ('tehta`s mean');

%% PART3
tau=t;
autocorr=zeros(1,100);

for i=1:100
    for j=1:100
        autocorr(i,j)=(A^2).*mean((cos(5.*pi.*t(i)+theta(i,1:100000))).*(cos(5.*pi.*(t(i)+tau(j))+theta(i,1:100000))));
    end
end    
figure
mesh(t,tau,autocorr);
title('3D autocorrelation');xlabel tau(s); ylabel t(s);

%% PART4
figure
xtbar=zeros(1,length(tau));
subplot(2,1,1)
plot(tau,xtbar);
title('mean');xlabel t(s); ylabel mean;
Rxthandy=(A^2/2)*cos(5*pi*tau);
subplot(2,1,2);
plot(tau,Rxthandy);
title('Autocorrelation');xlabel tau(s); ylabel Rx;

%% PART5
autocorrbar=mean(autocorr);
figure
subplot(2,1,1);
plot(t,autocorrbar);
title('WSS signal');xlabel t(s); ylabel WSS;
subplot(2,1,2);
plot(t,Rxthandy);
title('WSS signal (hand calculation');xlabel t(s); ylabel WSS
error=immse(autocorrbar,Rxthandy);