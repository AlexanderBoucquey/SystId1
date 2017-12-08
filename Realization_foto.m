clear all
close all

data = imread('foto.JPG');
A = im2double(data);
A = rgb2gray(A);
%figure();
%imshow(A);
hold off
[U, S, V] = svd(A);
s = diag(S);
[m , n] = size(S);
grid = linspace(1, m, m);
%figure();
%loglog(grid, s);
hold off
% A1
for i=[1,2,5,10,20,50,100]
    figure();
    dr = (m * i+ i + n * i)/(m*n)*100;    
    A1 = U(:,1:i)*S(1:i,1:i)*V(:,1:i)';
    imshow(A1);  
    title(['data reduction ' num2str(dr) '%']);
end