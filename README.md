
# Coin Counter in Images





## Project Overview
This project focuses on developing a robust and efficient algorithm to count coins in an image using MATLAB. The solution addresses practical needs in industries such as banking, retail, and vending systems. Leveraging MATLAB's image processing toolbox, the algorithm preprocesses the image, isolates the coins, and accurately counts them. This README details the methodology, steps, and usage instructions for the project.

## Features
Image Reading and Display: Load and visualize the original image data.

Grayscale Conversion: Simplify image processing by converting to grayscale.

Adaptive Thresholding: Convert grayscale images to binary, handling varying lighting conditions.

Image Complementation: Invert binary images for morphological operations.

Hole Filling: Ensure coins are represented as solid objects.

Noise Filtering: Remove small artifacts and noise from the image.


## Methodology
1-Image Reading and Display:

The imread function reads the image file and loads it into the workspace.

The imshow function displays the image for visualization.

2-Grayscale Conversion:

Convert the image to grayscale to reduce it to a single intensity channel.

3-Adaptive Thresholding:

Convert the grayscale image to a binary image where coins are white and the background is black.

Use adaptive thresholding to handle different lighting conditions.

4-Image Complementation:

Invert the binary image using the imcomplement function.

5-Hole Filling:

Fill holes inside the coin regions using the imfill function to create solid objects.

6-Noise Filtering:

Remove small objects using the bwareaopen function to eliminate noise and artifacts.

7-Coin Counting:

Identify and count the coins using the bwconncomp function.
