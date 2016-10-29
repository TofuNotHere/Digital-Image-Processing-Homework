%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Student: Chen Shufu
% ID: 2014141462015
%
%Last Modification Time：2016-10-14 11:54:31
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = imread('homework_boy_hist.png');
[row,col] = size(I);
H = zeros(1,255);
HS = zeros(1,255);
HP = zeros(1,255);
for i = 1:row
    for k = 1:col
        H(I(i,k)) =  H(I(i,k)) + 1; %统计各灰度数量
    end
end

for i = 1 : 255
    HS(i) = H(i) / row / col;%求灰度占比
    if i > 1
        HP(i) = HS(i) + HP(i-1);%求各灰度级分布
    end
end

res = I;
for i = 1:row
    for k = 1:col
        if res(i,k) ~= 0 %求得新图像
           res(i,k) = HP(I(i,k))*255;
        end 
    end
end

imwrite(res,'homework_boy_res.png');
imshow(res);



