close all;
clear global;
clc;

%picture = imread("image8.jpg");
picture_gray = rgb2gray(picture);
subplot(3,3,1), imshow(picture_gray), title('1. gray');

picture_edge = edge(picture_gray,'Prewitt');
subplot(3,3,2), imshow(picture_edge), title('2. edge');

struct1 = strel('line', 20, 200);
struct2 = strel('line', 35, 0);
picture_dilated = imdilate(picture_edge, [struct1 struct2]);
subplot(3,3,3), imshow(picture_dilated), title('3. dilated');

picture_filled = imfill(picture_dilated, 4, 'holes');
subplot(3,3,4), imshow(picture_filled), title('4. filled');

struct3 = strel('disk', 5);
pre_trim = imerode(picture_dilated, struct3);

picture_trimmed = imclearborder(pre_trim, 4);
subplot(3,3,5), imshow(picture_trimmed), title('5. trimmed');

picture_erosion1 = imerode(picture_trimmed, struct3);
picture_erosion2 = imerode(picture_erosion1, struct3);
picture_erosion3 = imerode(picture_erosion2, struct3);
subplot(3,3,6), imshow(picture_erosion3), title('6. eroded');

stats = regionprops(picture_erosion3, 'Area');
biggest_blob = max( [stats.Area] );

picture_biggest = bwareaopen(picture_erosion3,(biggest_blob - 1));
subplot(3,3,7), imshow(picture_biggest), title('7. blobed');

struct4 = strel('rectangle', [20, 40]);
picture_biggest_dilated = imdilate(picture_biggest, struct4);
subplot(3,3,8), imshow(picture_biggest_dilated), title('8. blobDil');

[labeledImage] = bwlabel(picture_biggest_dilated);
measurements = regionprops(labeledImage, 'Orientation');
picture_rotated = imrotate(picture, -measurements(1).Orientation);
picture_biggest_rotated = imrotate(picture_biggest_dilated, -measurements(1).Orientation);

picture_biggest_rotated_measurements = regionprops(picture_biggest_rotated, 'BoundingBox');
picture_biggest_boundig_box = picture_biggest_rotated_measurements.BoundingBox;
xLeft = picture_biggest_boundig_box(1);
yTop = picture_biggest_boundig_box(2);
width = picture_biggest_boundig_box(3);
height = picture_biggest_boundig_box(4);
picture_biggest_boundig_box2 = [xLeft, yTop, width, height];
icrop = imcrop(picture_rotated, picture_biggest_boundig_box2);
subplot(3,3,9), imshow(icrop), title('9. crop');
