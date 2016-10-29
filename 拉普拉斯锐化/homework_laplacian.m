%��ʼ��ģ�����
H(:,:,1) = [ 0 -1 0;  -1 4 -1;  0 -1 0 ]; 
H(:,:,2) = [ -1 -1 -1;  -1  8 -1;  -1 -1 -1 ];    
H(:,:,3) = [ 1 -2 1;  -2 4 -2;  1 -2 1 ]; 
H(:,:,4) = [ 0 -1 0;  -1 5 -1;  0 -1 0 ];

I = imread ('homework_laplacian.jpg');
[row,col] = size(I);
row = row +2;  %�������Ҹ�����һ��
col = col +2;

I2 = zeros([row,col]);
I2(2:row-1,2:col-1) = I; %ԭͼ�ŵ������ľ����м�
I2(1,:) = I2(2,:);             %������������չһ��
I2(:,1) = I2(:,2);
I2(row,:) = I2(row-1,:);
I2(:,col) = I2(:,col-1);

outfile = [];
for idx = 1 : 4
    HC = H(:,:,idx);
    for i = 1 : row-2
         for k =1 : col-2
             sum = 0;
             tmp = I2(i:i+2, k:k+2); %ÿ��ȡ��һ��3x3��С����
             res = tmp .* HC;       %��ģ�������

             for sumi = 1:3         %���
                 for sumk = 1:3
                     sum = res(sumi,sumk) + sum;
                 end
             end
             outfile(i,k) = sum/255; %��ֵ�����������
         end
    end
    figure, imshow(outfile); %չʾ���
    title(['ģ�� H'  int2str(idx) '������ͼ��']);
    imwrite(outfile,['ģ�� H'  int2str(idx) '������ͼ��.jpg'])%����
end