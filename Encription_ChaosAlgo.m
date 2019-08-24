clc;
clear all;
close all;

img=imread('im1.jpg');

img2=rgb2gray(img);
imshow(img2)

%encryption
function [ ] = encrpytion_ChaosAlgo()
P = int16([]);
img=imread('im1.jpg');
[M,N]=size(img);
L=M*N;
iter=5;
for i=1:iter
    x0(i)= uint8(randperm(256,5));
    y0(i)= uint8(randperm(256,5));
    Lambda_1(i)= uint8(randperm(256,5));
    Lambda_2(i)= uint8(randperm(256,5));
    
end 
    key=400;
    r=1;
    alpha= (10^14);
    
    while(r<=iter)
   
    S=L-1;
    i=0;
    x=x0;
    y=y0;
    Lambda_1=lambda_1(r);
    Lambda_2=lambda_2(r);
    Key=key(r);
           
    end
    
    for h=1:key
     
        x= Lambda_1*x*(1-x);
        y= Lambda_2*y*(1-y);
        
    end
    
    prev_chiphered_byte=0;
    
    while(i<L-2)
        
     x= Lambda_1*x*(1-x);
     y= Lambda_2*y*(1-y);
     y_norm= double(mod(floor(alpha*y),256));
     j= i + double(mod(floor(alpha*x),S));
     V1= bitxor(P[i], P[j]);
     V2= bitxor(V1, y_norm);
       if (i>0)
         prev_chiphered_byte= P[i-1];
       end
         V3= bitxor(V2,prev_chiphered_byte);
         V4= circshift(V3, 1+ mod(y_norm, 8));
         P[j]=P[i];
         P[i]= V4;
         i=i+1;
         S=S-1;

     end 
r=r+1;
P(r)= P(r-1);

end
I_enc= P;
disp(I_enc)
imshow(I_enc)
