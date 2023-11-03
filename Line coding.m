clc;clear;close all;
t=0:0.1:0.9;
fs =1000;
b = randi([0,1],1,1000);
x = length(t);
nrz_uni = [];
rz_uni = [];
nrz_pol = [];
rz_pol =[];
nrz_bi = [];
rz_bi = [];
manchester_bi = [];
one_bit= 0;
for i=1:length(b)
    if b(i)==0
        nrz_uni=[nrz_uni zeros(1,x)];
        nrz_pol=[nrz_pol -1*ones(1,x)];
        rz_uni =[rz_uni zeros(1, round(x))];
        rz_pol=[rz_pol -1*ones(1,x)];
    else
        nrz_uni=[nrz_uni ones(1,x)];
        nrz_pol=[nrz_pol ones(1,x)];
        rz_uni =[rz_uni ones(1, round(x/2))];
        rz_uni =[rz_uni zeros(1, round(x/2))];
    end
    if b(i)==0
        nrz_uni=[nrz_uni zeros(1,x)];
        nrz_pol=[nrz_pol -1*ones(1,x)];
        rz_uni =[rz_uni zeros(1, round(x))];
        rz_pol=[rz_pol -1*ones(1,x)];
    else
        nrz_uni=[nrz_uni ones(1,x)];
        nrz_pol=[nrz_pol ones(1,x)];
        rz_uni =[rz_uni ones(1, round(x/2))];
        rz_uni =[rz_uni zeros(1, round(x/2))];
        rz_pol =[rz_pol ones(1, round(x/2))];
        rz_pol =[rz_pol -1*ones(1, round(x/2))];
    end
    if b(i)==0
        nrz_bi=[nrz_bi zeros(1,x)];
        rz_bi=[rz_bi zeros(1,x)];
    elseif (b(i)==1 && one_bit==0)
        nrz_bi=[nrz_bi ones(1,x)];
        rz_bi =[rz_bi ones(1, round(x/2))];
        rz_bi =[rz_bi zeros(1, round(x/2))];
        one_bit = 1;
    elseif (b(i)==1 && one_bit==1)
        nrz_bi=[nrz_bi -1*ones(1,x)];
        rz_bi =[rz_bi -1*ones(1, round(x/2))];
        one_bit=1;
    end
    if b(i) == 0
        nrz_bi = [nrz_bi zeros(1, x)];
        % Manchester encoding for '0' (transition at midpoint)
        manchester_bi = [manchester_bi -1*ones(1, round(x/2))];
        manchester_bi = [manchester_bi ones(1, round(x/2))];
    elseif b(i) == 1 && one_bit == 0
        nrz_bi = [nrz_bi ones(1, x)];
        manchester_bi = [manchester_bi ones(1, round(x/2))];
        manchester_bi = [manchester_bi -1*ones(1, round(x/2))];
        one_bit = 1;
    elseif b(i) == 1 && one_bit == 1
        nrz_bi = [nrz_bi -1*ones(1, x)];
        manchester_bi = [manchester_bi ones(1, round(x/2))];
        manchester_bi = [manchester_bi -1*ones(1, round(x/2))];
        one_bit = 1;
    end
end
subplot (4,1,1);
plot(nrz_uni); axis([0 1000 -2 2]); title('Unipolar NRZ');
grid on;
subplot(4,1,2)
plot(nrz_pol); axis ([0 1000 -2 2]);
grid on;
title('Polar NRZ');
subplot (4,1,3);
plot(rz_uni); axis([0 1000 -2 2]);
grid on;
title('Unipolar RZ');
subplot(4,1,4);

plot(rz_pol); axis([0 1000 -2 2]);
grid on;
title('Polar RZ')
figure;
subplot (3,1,1)
plot(nrz_bi); axis ([0 1000 -2 2]);
grid on;
title('Bipolar NRZ')
subplot(3,1,2)
plot(rz_bi); axis ([0 1000 -2 2]);
grid on;
title('Bipolar RZ')
subplot(3,1,3)
plot(manchester_bi); axis([0 1000 -2 2]); title('manchester');
grid on;
figure(3);
subplot(141);
title("Unipolar NRZ");
pspectrum(nrz_uni, fs);
subplot(142);
title("polar NRZ");
pspectrum(nrz_pol, fs);
subplot(143);
title("Unipolar RZ");
pspectrum(rz_uni, fs);
subplot(144);
title("Polar RZ");
pspectrum(rz_pol, fs);
figure(4);
subplot(131);
title("Bipolar NRZ");
pspectrum(nrz_bi,fs);
subplot(132);
title("Bipolar RZ");
pspectrum(rz_bi, fs);
subplot(133);
title("Bipolar Mancester")
pspectrum(manchester_bi, fs);