clc;clear;close all
%% Am Q1
load("Signal.mat",'x_normal');
xt=x_normal;
fs=10000;
t=0:1/fs:2;
figure;
plot(t,xt);
title('Message signal in time');

%% Q2
L=length(xt);
Xf=fftshift(fft(xt));
f=-fs/2:fs/L:fs/2-1/L;
figure;
subplot(2,1,1);
plot(f,abs(Xf));
title('abs of Message signal in frequency');
subplot(2,1,2);
plot(f,angle(Xf));
title('angle of Message signal in frequency');

%% Q3
Ac=1;
fc=200;
mu=input('enter the modulation index: ');
    if mu>1
      disp('error')
    else
      xct=Ac.*cos(2*pi*fc*t).*(1+mu.*xt);
      figure; 
      plot(t,xct); 
      title('Transmitted signal in time');

      Lc=length(xct);
      Xcf=fftshift(fft(xct,Lc))/Lc;
      figure;
      subplot(2,1,1);
      plot(f,abs(Xcf));
      title('abs of Transmitted signal in frequency');

      subplot(2,1,2);
      plot(f,angle(Xcf));
      title('angle of Transmitted signal in frequency');

    end
    
%% Q4

%xfn=hilbert(Xcf);
%xtn=ifft(ifftshift(xfn));
xtn=demodelating(Xcf,fs,Ac,mu);
figure
plot(t,real(xtn));
title('demodulate signal');
% hold on
% plot(t,xt,'-.');

err1=immse(xtn,xt);

%% demodelator function
function [xm]= demodelating(Xcf, fs,Ac,mu)
L=length(Xcf);
f=-fs/2:fs/L:fs/2-fs/L;
xct=ifft(ifftshift(Xcf))*L;
Xcff = Xcf;
Xcff(f>0)=-1i.*Xcf(f>0);
Xcff(f<0)=1i.*Xcf(f<0);
xctt=ifft(ifftshift(Xcff))*L;
xm2=sqrt((xctt.^2)+(xct.^2));
xm=((xm2/Ac)-1)/mu;
end



