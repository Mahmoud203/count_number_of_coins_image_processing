%clear
clear;
close all;
clc;

%Image read
img = imread ('bronze_coins.jpg');
figure,
imshow(img);




% convert it into Binary vertion Image
BW = imbinarize(img,0.5); % 0.5 is atest threshold value
figure,
imshow(BW);


% complement the image
BW1 = imcomplement(BW);
figure,
imshow(BW1);


% Fill the holes to make a solid objects
BW2 = imfill(BW1,'holes');
figure,
imshow(BW2);


% Filter the image
BW3 =  bwareaopen(BW2,10); 


% Now find the number of coins 
coins = bwconncomp(BW2);
NoOfCoins = coins.NumObjects; 
disp('The Total Number of Coins are    :');
disp(NoOfCoins);