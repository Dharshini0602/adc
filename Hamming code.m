clc;clear all;close all;
l=8;
message=[1 0 1 0 0 1 0 1];             
disp("MESSAGE BITS:");disp(message); 
n=7;k=4;m=n-k;
Parity=[1 0 1;1 1 1;1 1 0;0 1 1];
disp("PARITY MATRIX");disp(Parity);
I=eye(k);
Generator=[Parity I];codeword=[];
disp("GENERATOR MATRIX:");disp(Generator);

j=1;
for i=0:k:length(message)
    if i==l
       break;
    end
    m=message(1+i:4+i);
    c=mod(m*Generator,2);
    codeword(j,:)=c;
    j=j+1;
end
disp("CODEWORDS:");disp(codeword);

fli=randi([1,5],1,2);
received=codeword(fli(1),:);
disp("ORIGINAL CODE WORD:");disp(received);
received(fli(2))=~received(fli(2));
received_error=received;
disp("RECEIVED CODEWORD WITH ERROR:");disp(received_error);
H=[Parity' eye(n-k)];disp("PARITY CHECK MATRIX H:");disp(H);
HT=H';
disp("H^T :");disp(HT);
syndrome=mod(received_error*HT,2);e=[];
for i=1:7
    if HT(i,:)==syndrome
        e=[e 1];
    else
        e=[e 0];
    end
end
disp("SYNDROME:");disp(syndrome);
disp("ERROR");disp(e);
corr_word=mod(received_error+e,2);
disp("CORRECTED CODEWORD:");disp(corr_word);