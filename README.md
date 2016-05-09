# Hand_gesture_control
Approach( Algorithm used)
•	I took an input of real time video from my laptop and captured the frame at regular interval.
•	I calculated the optical flow vector using Horn Schunck Algorithm and performed this on coarse frame.
•	Calibrate my webcam and find the intrinsic, extrinsic parameter and the Projection Matrix.
•%	Then calculate the actual 3D velocity vector of the hand( still left to implement)
•	Transform the obtained velocity to the global  directional vector to control the 3D object in my laptop.  
•	Use a cube as the 3D object in my laptop that could approximately rotate and translate in the direction of my hand motion. 

Detail Algorithm 

1.	Create a video object and read a video from the webcam.
2.	Create a animated 3D cube object of dimension 1*1*1 with origin at (0,0,0)
3.	Get a snapshot of the video of a particular frame.
4.	Detect hand from the frame. Hand is detected using the image processing technique.
Hand Detection and segmentation:
a)	Capture image using webcam of laptop.
b)	Convert it to YCbCr color space. My webcam captured the frame in YCbCr color space so I didn’t have to convert from RGB to YCbCr.
c)	Detect skin color (You will get hand and face). The skin color range has to be used according to the person hand color. My skin was brown so, I used this color space to detect skin
(Cr>=135 & Cr<=160) & (Cb>=105 & Cb<=125) & (Y<150 & Y>91];
d)	Make hand and face image binary
e)	Then perform morphological operation. First I dilated the image to connect the slightly disconnected branches using a square structuring element 4*4 neighbourhood.
f)	Fill the open space within the closed region with imfill. This will give a more wholesome picture of hand and face.
g)	Find out the largest blob. Always keep hand closer to the camera and face far away from camera. In this way face will be smaller blob than hand. 
Otherwise face will be detected. To find the largest blob, we label the image with different connectivity and then we find the length of each label. 
The label that contains the largest number of pixel is the largest blob, so we label that blob as one and the rest zero.
h)	Segment the grayscale of the hand from the largest blob by converting the YCbCr to gray and taking only those pixel where the largest blob is labeled 1.
5.	Once the gayscale hand is segmented, make that frame coarser frame by downsampling by two and using nearest neighbour interpolation filter.
6.	This will continue unless we have two frames because to calculate optical flow we need two frames.
7.	I calculated the optical flow using Horn Schunck’s Algorithm. I will later discuss the theory of Horn Schunck algorithm in detail.
8.	After I obtained the optical flow motion vector , I interpolated the flow vector both in horizontal direction and vertical direction.
9.	I took vector at 5 pixel interval so that we can easily see the flow vector and computationally it can be faster.
10.	 By using the function quiver() and drawnow , we can see the magnitude and direction of  flow vector and after each frame we can see the updated flow vector as a continuous motion.
11.	A lot of features are accompanied with the image. The information from the foreground is used to determine the movement of the hand and that hand movement ultimately provides us
the corresponding gesture. Here the optical flow vectors acted as the feature vector.
12.	Experimentally set threshold is used to identify the gesture from the summed optical flow vectors both in horizontal and vertical direction respectively.
13.	In our experiment we tried to determine the movement of hand to left, right, up and down. This movement in turn lead us to determine different kind of gesture such as rotation of the
cube towards right, left , up and down. The optical flow we are implementing in our project is basically working on gray images of segmented hand.
14.	We obtain information such as rotation axis, rotation increment magnitude and the direction of rotation from the summed optical flow magnitude. I used the following algorithm to obtain this paramenter.
a)	First I calculated the mean of horizontal vector and mean of vertical flow vector.
b)	Then I found out the angle between the two resultant summation vector by using the following formula
teta = mod(atan2(ym,xm),2*pi)*180/pi
This gives me angle in degree and in the range of 0 degree to 360 degree.
c) I assigned angle between 45 to 135 as upward motion , angle between 135 to 225 as left  motion, angle between 225 to 315 as downward motion and angle between  315 to 45 as right motion and 
I defined the axis of rotation accordingly. If there is no motion then it will be treated as still object.
15.	I pass this parameter to the animated cube for rotation.
16.	 This frame in now treated as the 2nd frame and new frame is captured from the webcam and this process continues to give a continuation motion of the cube

