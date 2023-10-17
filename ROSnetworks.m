% loaded using gazebo
close all
setenv('ROS_IP','172.25.128.1'); %Christians IP, also set correct IP on WSL through 
% '$ ifconfig', then set '$ export ROS_IP=xxxx.xxx.xxx.xxx' in WSL window

depthpoints = rossubscriber('/head_camera/depth_registered/points','DataFormat','struct');
points = receive(depthpoints,1);

% rosPlot(depth_ros) %makes a pointcloud
cart = rosReadXYZ(points);
cartValid = cart(~isnan(cart(:,1)),:);

% orienting in cartesian frame
holder = cartValid(:,2);
cartValid(:,2) = cartValid(:,3); %swap x and y
cartValid(:,3) = holder*-1 + 1.0597; %min value (floor) to set correct origin

% removing unwanted points
counter = 0;
cartObject = sortrows(cartValid,3,"ascend"); %sort coloumns by z value

%find values below the table
for i = 1:numel(cartObject(:,3))
    if cartObject(i,3) < 0.775 
        counter = counter + 1; 
    end
end

%delete values below table
cartObject(1:counter,:) = []; 

%point clouds
pc2 = pointCloud(cartValid);
pcshow(pc2)
figure;
Object = pointCloud(cartObject);
pcshow(Object)

%Grasping Position
xmin = min(cartObject(:,1));
xmax = max(cartObject(:,1));
ymin = min(cartObject(:,2));
ymax = max(cartObject(:,2));
zmin = min(cartObject(:,3));
zmax = max(cartObject(:,3));
xdiff = (xmax-xmin)/2;
ydiff = (ymax-ymin)/2;
zdiff = (zmax-zmin)/2;

GraspingPos = [(xmin+xdiff),(ymin+ydiff),(zmin+zdiff)]

%% RGB image
% rgb = rossubscriber('head_camera/rgb/image_raw','DataFormat','struct');
% rgb_data = receive(rgb,1);
% rgbImage = rosReadImage(rgb_data);
% imshow(rgbImage);