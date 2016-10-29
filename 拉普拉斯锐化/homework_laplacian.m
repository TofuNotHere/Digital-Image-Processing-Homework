%初始化模板矩阵
H(:,:,1) = [ 0 -1 0;  -1 4 -1;  0 -1 0 ]; 
H(:,:,2) = [ -1 -1 -1;  -1  8 -1;  -1 -1 -1 ];    
H(:,:,3) = [ 1 -2 1;  -2 4 -2;  1 -2 1 ]; 
H(:,:,4) = [ 0 -1 0;  -1 5 -1;  0 -1 0 ];

I = imread ('homework_laplacian.jpg');
[row,col] = size(I);
row = row +2;  %上下左右各扩充一行
col = col +2;

I2 = zeros([row,col]);
I2(2:row-1,2:col-1) = I; %原图放到扩充后的矩阵中间
I2(1,:) = I2(2,:);             %向上下左右延展一行
I2(:,1) = I2(:,2);
I2(row,:) = I2(row-1,:);
I2(:,col) = I2(:,col-1);

outfile = [];
for idx = 1 : 4
    HC = H(:,:,idx);
    for i = 1 : row-2
         for k =1 : col-2
             sum = 0;
             tmp = I2(i:i+2, k:k+2); %每次取出一个3x3的小矩阵
             res = tmp .* HC;       %与模板做点乘

             for sumi = 1:3         %求和
                 for sumk = 1:3
                     sum = res(sumi,sumk) + sum;
                 end
             end
             outfile(i,k) = sum/255; %赋值到结果矩阵中
         end
    end
    figure, imshow(outfile); %展示结果
    title(['模板 H'  int2str(idx) '处理后的图像']);
    imwrite(outfile,['模板 H'  int2str(idx) '处理后的图像.jpg'])%保存
end