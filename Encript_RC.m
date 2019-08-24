clc;
close all;

img = imread('im1.jpg');
flag= 0;
if flag== 1
    encrypt(img)
else
    decrypt()
end


function [ ] = encrypt(~) 
img = imread('im1.jpg');
img_1=rgb2gray(img);
disp(img_1)
[M,N]= size(img_1);
Kr = uint8(randperm(188,M));
disp(Kr)
Kc = uint8(randperm(255,N));

I1=zeros(188,250);
Ienc=zeros(188,250);
%itr_max=4;

row_sum = sum(img_1,2);
col_sum = sum(img_1);
Mod_row = uint8(mod(row_sum,2));

    
   
    for p=1:188
        if Mod_row(p)== 0
           img_1(p,:)= circshift(img_1(p,:),Kr(p));
          
        else
          img_1(p,:)= circshift(img_1(p,:),-Kr(p)); 
        end       
 
    end 
    
    Mod_col = uint8(transpose(mod(col_sum,2)));
     for q=1:250
        if Mod_col(q)== 0
           img_1(:,q)= circshift(img_1(:,q),-Kc(q));
          
        else
          img_1(:,q)= circshift(img_1(:,q),Kc(q)); 
        end       
 
     end 
 
I_scr= img_1;

        for i= 1:2:188
            for j=1:250
            I1(i,j)= bitxor(I_scr(i,j),Kc(j));
            end
        end
   
        for i= 2:2:188
            for j=1:250
            I1(i,j)= bitxor(I_scr(i,j),fliplr(Kc(j)));  
            end
        end
 I1=uint8(I1) ;  
       
        for j= 1:2:250
             for i=1:188
             Ienc(i,j)=bitxor(I1(i,j),Kr(i));
             end
        end
   
   
        for j= 2:2:250
             Ienc(:,j)=bitxor(I1(:,j),fliplr(Kr(i)));
        end
   Ienc=uint8(Ienc);
    
%             if mod(i,2)==0 
%                 
%             elseif mod(i,2)==1
%                
%             elseif mod(j,2)==0
%                 
%             elseif mod(j,2)==1
%                
           figure()
           imshow(Ienc)
           Ienc2=Ienc;
save I1;
save I_src;
save Ienc2;   
save Kr;
save Kc;
disp(Ienc)
end
   
function [] = decrypt()
%load I1;
%load I_src;
load Ienc2;   
load Kr;
load Kc;
Isrc = uint8(zeros(188,250));
I1= uint8(zeros(188,250));

 for j= 1:2:250
             for i=1:188
             I1(i,j)=bitxor(Ienc2(i,j),Kr(i));
             end
 end
   
   
        for j= 2:2:250
             I1(:,j)=bitxor(Ienc2(:,j),fliplr(Kr(i)));
        end

 for i= 1:2:188
            for j=1:250
            Isrc(i,j)= bitxor(I1(i,j),Kc(j));
            end
 end
 
 for i= 2:2:188
            for j=1:250
            Isrc(i,j)= bitxor(I1(i,j),fliplr(Kc(j)));  
            end
 end
 
  row_sum = sum(Isrc,2);
  col_sum = sum(Isrc);  
  
  
  Mod_col = transpose(mod(col_sum,2));
     for q=1:250
        if Mod_col(q)== 0
           Isrc(:,q)= circshift(Isrc(:,q),-Kc(q));
          
        else
           Isrc(:,q)= circshift(Isrc(:,q),Kc(q)); 
        end   
     end   
       
     Mod_row = mod(row_sum,2);
     for p=1:188
        if Mod_row(p)== 0
           Isrc(p,:)= circshift(Isrc(p,:),Kr(p));
          
        else
           Isrc(p,:)= circshift(Isrc(p,:),-Kr(p)); 
        end       
 
     end
    
    figure()   
    imshow(Isrc) 
  


    
    
    

    


end