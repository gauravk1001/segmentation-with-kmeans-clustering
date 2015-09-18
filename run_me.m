
%This is the run file. Pls execute this.

%image to pick animal from
imname='images/zebra.jpg';
I=imread(imname);
I=im2double(I);
figure(10);
imshow(I);

%no. of segments
k=7;
grayI=rgb2gray(I);

segmentImg(grayI,k);