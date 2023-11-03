BPSK%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;clear all;close all;
f=1.5;
t=0:0.01:2;
b=randi([0,1],1,10);
disp(b);
c=cos(2*pi*f*t);
modu_sig=[];carr_sig=[];org_sig=[];

%BPSK MODULATION:
for k=1:length(b)
    if(b(k)==1)
        modu_sig=[modu_sig cos(2*pi*f*t)];
        org_sig=[org_sig ones(1,length(t))];
    else
        modu_sig=[modu_sig cos((2*pi*f*t)-pi)];
        org_sig=[org_sig zeros(1,length(t))];
   
    end
    
    carr_sig=[carr_sig c];
end
disp(modu_sig);

%BPSK DEMODULATION:
rec_sig=awgn(modu_sig,10);
dem_sig=rec_sig.*carr_sig;

subplot(511);
plot(carr_sig);xlabel("time");ylabel("AMPLITUDE");title("CARRIER SIGNAL");
subplot(512);
plot(modu_sig);xlabel("time");ylabel("AMPLITUDE");title("BPSK SIGNAL");
subplot(513);
plot(rec_sig);xlabel("time");ylabel("AMPLITUDE");
title("BPSK SIGNAL(NOISE ADDED)");
subplot(514);
plot(dem_sig);xlabel("time");ylabel("AMPLITUDE");title("DEMODULATED SIGNAL")
subplot(515);
plot(org_sig);xlabel("time");ylabel("AMPLITUDE");title("ORIGINAL SIGNAL")
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


BPSK BER VS SNR:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;clear all;close all;
n=10^6;
b=randi([0,1],1,n);
bpskmod = comm.BPSKModulator;
bpskdemod = comm.BPSKDemodulator;
b_mod=bpskmod(b');
ber=[];
for snr=0:12
    b_nois=awgn(b_mod,snr);
    b_demod=bpskdemod(b_nois);
    err=biterr(b',b_demod);
    rate=err/n;
    ber=[ber rate];
end
semilogy(0:12,ber,"-k*");
grid on;
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


QPSK%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;clear all close all;
f=5;
t=0:0.01:1;
b=[1,0,1,1,1,0,0,1,1,1];
disp(b);
c=cos(2*pi*f*t);
mod_sig=[];carr_sig1=[];org_sig=[];b_nrz=[];carr_sig2=[];

%ORIGINAL SIGNAL:
for i=1:length(b)
    if (b(i)==1)
        org_sig=[org_sig ones(1,length(t))];
    else
        org_sig=[org_sig zeros(1,length(t))];
    end
end

for i=1:length(b)
    if (b(i)==0)
        b_nrz=[b_nrz -1];
    else
        b_nrz=[b_nrz 1];
    end
end

for j=1:2:length(b_nrz)
    m1=b_nrz(j)*cos(2*pi*f*t);
    m2=b_nrz(j+1)*sin(2*pi*f*t);
    m=m1+m2;
    mod_sig=[mod_sig m];

    carr_sig1=[carr_sig1 cos((2*pi*t*f))];
    carr_sig2=[carr_sig2 sin((2*pi*t*f))];
end
%ADDING NOISE IN THE SIGNAL:
noi_sig=awgn(mod_sig,20); %SNR=2s0db

%DEMODULATING THE SIGNAL:
demod_sig1=(noi_sig).*(carr_sig1);
demod_sig2=(noi_sig).*(carr_sig2);

subplot(511);
plot(org_sig);xlabel("time");ylabel("Amplitude");
title("ORIGINAL SIGNAL");
subplot(512);
plot(mod_sig);xlabel("time");ylabel("Amplitude");
title("QPSK MODULATED SIGNAL");
subplot(513);
plot(noi_sig);xlabel("time");ylabel("Amplitude");
title("QPSK MODULATED SIGNAL WITH NOISE");
subplot(514);
plot(demod_sig1);xlabel("time");ylabel("Amplitude");
title("DEMODULATED SIGNAL-1");
subplot(515);
plot(demod_sig2);xlabel("time");ylabel("Amplitude");
title("DEMODULATED SIGNAL-2");
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


QPSK BER VS SNR::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;clear all;close all;
n=10^6;
b=randi([0,1],1,n);
qpskmod = comm.QPSKModulator;
qpskdemod = comm.QPSKDemodulator;
q_mod=qpskmod(b');
ber=[];
for snr=0:12
    q_nois=awgn(q_mod,snr);
    q_demod=qpskdemod(q_nois);
    err=biterr(b',q_demod);
    rate=err/n;
    ber=[ber rate];
end
semilogy(0:12,ber,"-k*");
grid on;
scatterplot(q_mod);
constellation(qpskmod);
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


QAM%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;
clear all;
close all;
Fs = 50; % Sampling frequency
T = 1; % Duration of the signal in seconds
N = Fs * T; % Total number of samples
M = 8; % QAM modulation order (change as needed)
% Generate a random message signal
message_signal = randi([0, M-1], 1, N);
% QAM Modulation
modulated_signal = qammod(message_signal, M);
% QAM Demodulation
demodulated_signal = qamdemod(modulated_signal, M);
% Plot the message signal
subplot(3,1,1);
stem(message_signal, 'r', 'linewidth', 1.5);
title('Message Signal');
xlabel('Sample Index');
ylabel('Amplitude');
% Plot the modulated signal
subplot(3,1,2);
plot(real(modulated_signal), 'b', 'linewidth', 1.5);
hold on;
plot(imag(modulated_signal), 'g', 'linewidth', 1.5);
title('Modulated Signal');
xlabel('Sample Index');
ylabel('Amplitude');
legend('Real', 'Imaginary');
% Plot the demodulated signal
subplot(3,1,3);
stem(demodulated_signal, 'm', 'linewidth', 1.5);
title('Demodulated Signal');
xlabel('Sample Index');
ylabel('Amplitude');
% Adjust plot spacing
sgtitle('QAM Modulation and Demodulation ');


QAM BER VS SNR:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
clc;clear all;close all;
n=10^5;M=16;
b=randi([0,1],n,4);
k=bi2de(b);
b_mod=qammod(k,M);
ber=[];
for snr=0:12
    b_nois=awgn(b_mod,snr);
    b_demod=qamdemod(b_nois,M);
    err=biterr(k,b_demod);
    rate=err/n;
    ber=[ber rate];
end
semilogy(0:12,ber,"-k*");
grid on;
scatterplot(b_mod);