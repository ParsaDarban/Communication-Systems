clc;clear;close all
load('p.mat', 'p')

%% PART1

N=50000;
fs_c=N/3;
t_c=0:1/fs_c:3-1/fs_c;
mt_c=10+5*sin(3*pi*t_c)+3*(cos(pi*t_c).^3)+sin(pi*t_c/4);
figure
plot(t_c,mt_c);
title('Analog signal');xlabel t(s); ylabel mc(t);

%% PART2

fs=500;
t=t_c(1:fs:length(mt_c));
mt=mt_c(1:fs:length(mt_c));
figure
stem(t,mt);
title('smapled signal');xlabel t(s); ylabel m(t);

%% PART3

minm=round(min(mt),1);
maxm=round(max(mt),1);
QL=(maxm-minm)/31;
% Level
Q=minm:QL:maxm;
% 
x=zeros(1,100);
Quantized_sig=zeros(1,100);
Quantized_level=zeros(1,100);
figure
for k=1:100
    [~,x(k)]=min(abs(mt(k)-Q));   
end
Quantized_sig(1:100)=Q(x(1:100));
stem(t,Quantized_sig,LineStyle="none", MarkerEdgeColor='r');
hold on 
stem(t,mt, LineStyle="none" , MarkerEdgeColor='g');
hold on 
for n=0:31
    Quantized_level(1:100)=minm+n*QL;
    plot(t,Quantized_level,'b');
end
title('Quantization signal');xlabel t(s); ylabel m(t);
legend('Quantized_sig' ,'mt' , 'Quantized_level');
%% PART4-1

figure 
plot(p);
EnergyP=sum(p.^2);
title('Triangle Pulse');xlabel t(s); ylabel Pulse;
%% PART4-2 Graycode
figure 
tnew=0:3/100000:3-3/100000;
coding1=[0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8, 24, 25, 27, 26, 30,31, 29, 28, 20, 21, 23, 22, 18, 19, 17, 16];
coding2 = dec2bin(coding1);
Amp1= -31:2:31;
level=1:1:32;
codingarray=[Q ; coding1 ; Amp1 ; level];
Amp2=Amp1(x);  
decimalmod=coding1(x(1:100));
graycodemod=dec2bin(decimalmod);
Stringgraymod = reshape(graycodemod', 1, []);

pulse1=zeros(1,100000);
for i=1:100
    pulse1(1,(i-1)*1000+1:1000*i)=Amp2(i)*p;
end

plot(tnew,pulse1);
title('pulse converted message');xlabel t(s); ylabel ('discrete pulse');
%% PART5

Ps=sum(pulse1.^2)/100000;
Pn=Ps*(10^(-0.2));
noise=(sqrt(Pn)).*randn(1,100000);
figure
subplot(2,1,1);
plot(tnew,noise);
title('Gaussian noise');xlabel t(s); ylabel Noise;
mt_nt=pulse1+noise;
subplot(2,1,2);
plot(tnew,mt_nt);
title('pulsed signal + noise');xlabel t(s); ylabel ('receive signal');
%% PART6

rePulse=transpose(reshape(mt_nt,1000,100));
Ampulse=transpose((rePulse * p.')/EnergyP);
figure


newAmpindex=zeros(1,100);
round2odd1 = round_odd(Ampulse);

for i=1:100
        newAmpindex(i)=find(round2odd1(i)==codingarray(3,:));
end

decode=Q(newAmpindex(1:100));
stem(t,decode, 'r',LineStyle="none");
hold on 
for n=0:31
    Quantized_level(1:100)=minm+n*QL;
    plot(t,Quantized_level,'b');
end
legend('DeQuantized_sig' , 'Quantized_level');

coding3=coding1(newAmpindex);
graycodedemod=dec2bin(coding3);

% checking for difference
Amperror=(sum(x ~= newAmpindex)/length(newAmpindex))*100;


Stringgraydemod = reshape(graycodedemod', 1, []);
Graycode_dif=sum(Stringgraydemod ~= Stringgraymod);
Graycode_error = (Graycode_dif / length(Stringgraydemod))*100;

%% Part7
figure
Analog=spline(t,decode,t_c);
%Analog=Analog+mean(mt_c)-mean(Analog);
plot(t_c,Analog , 'b');
hold on 
plot(t_c,mt_c ,'r' , LineStyle="-");
title('convert to Analog') ; xlabel t(s) ; ylabel Analog;
legend('Analog signal' , 'first signal')
Receive_error=immse(Analog,mt_c);

%% Function

% from matlab
function S = round_odd(S)
idx = mod(S,2)<1;
S = floor(S);
S(idx) = S(idx)+1;
end





