clc;clear;close all

%% in time
load("VarFile","device_1_New","device_2_New","mixed_Used");
figure
fs=100.5;
t=0:1/fs:2-1/fs;
subplot(3,1,1);
plot(t,device_1_New);
title('device-1-new');
subplot(3,1,2);
plot(t,device_2_New);
title('device-2-new');
subplot(3,1,3);
plot(t,mixed_Used);
title('mix-uesed');

%% in freqency
L1=length(device_1_New);
L2=length(device_2_New);
L3=length(mixed_Used);


X1=(fftshift(fft(device_1_New,L1)))/L1;
X2=(fftshift(fft(device_2_New,L2)))/L2;
X3=(fftshift(fft(mixed_Used,L3)))/L3;
figure
fs=100.5;
f=-fs/2:fs/L1:fs/2-1/L1; % lenghth of all variable are equal
%Device 1
subplot(3,2,1);
plot(f,abs(X1));
title('device-1-amp');
subplot(3,2,2);
plot(f,angle(X1));
title('device-1-ang');

%Device 2
subplot(3,2,3);
plot(f,abs(X2));
title('device-2-amp');
subplot(3,2,4);
plot(f,angle(X2));
title('device-2-ang');

%Mix
subplot(3,2,5);
plot(f,abs(X3));
title('mix-amp');
subplot(3,2,6);
plot(f,angle(X3));
title('mix-angle');

%% compare mix and devices sound
figure


Device2 = mixed_Used-device_1_New;
subplot(3,1,1);
plot(Device2);
title('Device2=mix-device1new');


subplot(3,1,2);
corrdevice2=CorrCovv(Device2,device_2_New);
plot(corrdevice2);
title('corrolation of device 2'); 

subplot(3,1,3);
plot(Device2);
hold on
plot(device_2_New);
title('Device2 & device2new');

Err2=immse(Device2,device_2_New);


figure
Device1 = mixed_Used-device_2_New;
subplot(3,1,1);
plot(Device1); 
title('Device1=mix-device2new'); 


subplot(3,1,2);
corrdevice1=CorrCovv(Device1,device_1_New);
plot(corrdevice1);
title('corrolation of device 1');

subplot(3,1,3);
plot(Device1);
hold on;
plot(device_1_New);
title('Device1 & device1new');

Err1=immse(Device1,device_1_New);

%% in frequency

%device2
figure
Xf2= X3 - X1;
subplot(3,1,1);
plot(f,abs(Xf2));
title('Device2 = mix - device1new in frequency');

subplot(3,1,2);
plot(f , abs(X2));
title('Device 2 in frequency');

subplot(3,1,3);
plot(f ,  abs(X2));
hold on
plot(f , abs(Xf2));
title('Device2 & device2new in frequency');

%device1
figure
Xf1=X3 - X2;
subplot(3,1,1);
plot(f,abs(Xf1));
title('Device1 = mix - device2new in frequency');

subplot(3,1,2);
plot(f,abs(X1));
title('Device1');

subplot(3,1,3);
plot(f,abs(X1));
hold on
plot(f,abs(Xf1));
title('Device1 & device_1_new in frequency');

Error2=immse(Xf2, X2);
Error1=immse(Xf1 , X1);
