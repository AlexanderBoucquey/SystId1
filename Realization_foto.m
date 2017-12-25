clear variables;
close all;

% Read the data.
data = imread('foto.JPG');
A = im2double(data);
A = rgb2gray(A);

% SVD of A.
[U, S, V] = svd(A);

% Plot singular values.
s = diag(S);
[m , n] = size(S);
grid = linspace(1, m, m);
figure();
plot(grid,s, 'ro');
xlabel('Index single value');
ylabel('Value');

% Show figures calculated with reduced information.
for i=[1,2,5,10,20,100]
    figure();
    dr = (m * i+ i + n * i)/(m*n)*100;    
    A1 = U(:,1:i)*S(1:i,1:i)*V(:,1:i)';
    imshow(A1);  
    title(['data reduction ' num2str(dr) '%']);
end