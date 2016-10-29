%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Student: Chen Shufu
% ID: 2014141462015
%
%Last Modification Time��2016-9-14 23:25:15
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = imread('homework_yellowSeg.bmp');
[row,col,tmp] = size(I);
pxNum = row*col;

%ʹ��RGB��ɫ�ռ���ȡ��ɫ�ķ���
%˼·�ǻ�ȡ����R��G�������Ҳ�����B���������ص�
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
B = im2bw(B,graythresh(B));
R = im2bw(R,graythresh(R));
G = im2bw(G,graythresh(G));
RGB_res = R&G;
for i = 1: row
    for j = 1 : col
        if RGB_res(i,j) && B(i,j)
            RGB_res(i,j) = 0;
        end
    end
end
RGB_ans = sum(sum(RGB_res))/pxNum;

%ʹ��HSV��ɫ�ռ���ȡ��ɫ�ķ���
%˼·�ǻ�ȡH������45�㵽75��֮�����������
hsvImg = rgb2hsv(I);
H = hsvImg(:,:,1)*360;
HSV_res = false(row,col);
for i = 1: row
    for j = 1 : col
        if H(i,j)>=45 && H(i,j)<75
            HSV_res(i,j) = 1;
        else
            hsvImg(i,j,2) = 0;
            hsvImg(i,j,3) = 0;
        end
    end
end
HSV_ans = sum(sum(HSV_res)) /pxNum;

%�������������ֵͼ��
fid = fopen('results.txt','w+');
fprintf(fid,'RGB����ȡ������Ľ���ǣ�%g %% \n',RGB_ans*100);
fprintf(fid,'HSV����ȡ������Ľ���ǣ�%g %% \n',HSV_ans*100);
fclose(fid);
imwrite(RGB_res,'RGB_BW.bmp');
imwrite(HSV_res,'HSV_BW.bmp');