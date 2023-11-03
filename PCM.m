clc;close all;clear all;
n=3;
fm=3;fs=6;
L=2^n;
t=0:0.01:5; 
s=8*sin(2*pi*t*fm);

% Quantization Process
vmax=8;
vmin=-vmax;
del=(vmax-vmin)/L;
part=vmin:del:vmax; 
code=vmin-(del/2):del:vmax+(del/2); 
[ind,q]=quantiz(s,part,code); 
l1=length(ind);l2=length(q);

for i=1:l1
  if(ind(i)~=0)
  ind(i)=ind(i)-1;
  end 
end 
for i=1:l2  
   if(q(i)==vmin-(del/2))
   q(i)=vmin+(del/2);
   end
end 

% Encoding Process
code=de2bi(ind,'left-msb'); 
k=1;
for i=1:l1
  for j=1:n
  coded(k)=code(i,j); 
  k=k+1;
  end
end

% Demodulation Of PCM signal
qunt=reshape(coded,n,length(coded)/n);
index=bi2de(qunt','left-msb'); 
q=del*index+vmin+(del/2);


subplot(5,1,1);
plot(s);title('Analog Signal');ylabel('Amplitude');xlabel('Time');
subplot(5,1,2);
stem(s); title('Sampled Sinal'); ylabel('Amplitude'); xlabel('Time');
subplot(5,1,3);
stem(q);title('Quantized Signal');ylabel('Amplitude');xlabel('Time');
subplot(5,1,4); 
stairs(coded);axis([0 100 -2 3]); title('Encoded Signal');ylabel('Amplitude');
subplot(5,1,5); 
plot(q); title('Demodulated Signal');ylabel('Amplitude');xlabel('Time');