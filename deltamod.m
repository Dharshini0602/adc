clc;
clear all;
close all;
Am = 2;
fm = 4;
fs = 250;

Tm = 1/fs;
t = 0: Tm : 1;
Ym = Am*cos(2*pi*fm*t); %% msg signal
subplot(3,1,1);
plot(Ym);
title("Message Signal");
xlabel("Time (sec)");
ylabel("Amplitude");
l = length(Ym);
delta = 0.3;
Yn=0; %% Delta modulated signal
for i=1:l;
if Ym(i)>Yn(i)
d(i)=1;
Yn(i+1) = Yn(i) + delta;
else
d(i)=0;
Yn(i+1) = Yn(i) - delta;
end
end
subplot(3,1,2);
stairs(Yn);
title("Delta Modulated Signal");
xlabel("Time (sec)");
ylabel("Amplitude");
for i = 1 : d
if d(i)>Yn(i)
Yn(i+1) = Yn(i) - delta;
else
Yn(i+1) = Yn(i) + delta;
end
end
subplot(3,1,3);
plot(Yn);
title("DeModulated Signal");
xlabel("Time (sec)");
ylabel("Amplitude");