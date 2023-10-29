% load using gazebo
close all

rosshutdown;

% Initialise the ROS node
rosinit('NodeName', 'ObjectDetection_node')

setenv('ROS_IP','192.168.0.227'); % Jared's IP, also set correct IP on WSL through 
% '$ ifconfig', then set '$ export ROS_IP=xxxx.xxx.xxx.xxx' in WSL window

OBJECT_TO_FIND = 1; % 1 = coke 
                    % 2 = cube

%% Depth Cloud
fprintf("\nLoading rostopics... \n");
depthpoints = rossubscriber('/head_camera/depth_registered/points','DataFormat','struct');
points = receive(depthpoints,1);

fprintf("Extracting point cloud... \n");
% rosPlot(depth_ros) %makes a pointcloud
cart = rosReadXYZ(points);
cartValid = cart(~isnan(cart(:,1)),:);

% orienting in cartesian frame
holder = cartValid(:,2);
cartValid(:,2) = cartValid(:,3); %swap x and y
cartValid(:,3) = holder*-1 + 1.0597; %min value (floor) to set correct origin

%% Camera Tilt Compensation
fprintf("Compensating for camera tilt... \n");
tilt_angle = -0.35; % Negative if the camera is tilted down
Rx = [1 0 0; 0 cos(tilt_angle) -sin(tilt_angle); 0 sin(tilt_angle) cos(tilt_angle)]; % Rotation matrix about x-axis
cartValid = (Rx * cartValid')'; % Apply rotation


% removing unwanted points
counter = 0;
cartObject = sortrows(cartValid,3,"ascend"); %sort coloumns by z value

% find values below the table
for i = 1:numel(cartObject(:,3))
    if cartObject(i,3) < 0.66
        counter = counter + 1; 
    end
end

% delete values below table
cartObject(1:counter,:) = []; 

% point clouds
Objects = pointCloud(cartObject);

%% POINT CLOUD OBJECT DETECTION 
fprintf("Segmenting point cloud... \n");
% segments point cloud clusters
[labels, numClusters] = pcsegdist(Objects,0.05);

% sorts clusters into their own point clouds
for i = 1:numClusters
    rowcount = 1;
    counter = 0;
    newArray = zeros(length(labels),3);
    for k = 1:length(labels)
        if labels(k,1) == i
            newArray(rowcount,:) = Objects.Location(k,:);
            rowcount = rowcount + 1;
        end
    end
        newArray = sortrows(newArray,3,"ascend");

    for k = 1:length(newArray)
        if newArray(k,:) == 0 
            counter = counter + 1; 
        end
    end
    newArray(1:counter,:) = [];

    item{i} = newArray;
    item{i} = pointCloud(item{i});
end

switch OBJECT_TO_FIND
    case 1
        fprintf("Searching for COKE CAN... \n\n");
    case 2
        fprintf("Searching for CUBE... \n\n");
end

% load in objects to compare to for detection
switch OBJECT_TO_FIND
    case 1
        obj = pcread("coke.ply");
    case 2
        obj = pcread("cube.ply");
end

objfeatures = extractFPFHFeatures(obj);

% extracts features
features{1} = extractFPFHFeatures(item{1});
features{2} = extractFPFHFeatures(item{2});

%match features
[matchpairs1,scores1] = pcmatchfeatures(objfeatures,features{1},obj,item{1});
[matchpairs2,scores2] = pcmatchfeatures(objfeatures,features{2},obj,item{2});


%                         SOMETHING FUNKY HAPPENS HERE
if length(matchpairs1) > length(matchpairs2)
    detectedObj = item{1};
    GraspingPos = GetGraspPos(item{1});
    % publishing
    [pub,msg] = rospublisher('position','geometry_msgs/Point');
    msg.X = GraspingPos(1,1);
    msg.Y = GraspingPos(1,2);
    msg.Z = GraspingPos(1,3);
    send(pub,msg);
    pause(0.1);

    GraspingPos = GetGraspPos(item{2});
    % publishing
    [pub,msg] = rospublisher('position','geometry_msgs/Point');
    msg.X = GraspingPos(1,1);
    msg.Y = GraspingPos(1,2);
    msg.Z = GraspingPos(1,3);
    send(pub,msg);
    
else 
    if length(matchpairs1) < length(matchpairs2)
        detectedObj = item{2};
        GraspingPos = GetGraspPos(item{2});
        % publishing
        [pub,msg] = rospublisher('position','geometry_msgs/Point');
        msg.X = GraspingPos(1,1);
        msg.Y = GraspingPos(1,2);
        msg.Z = GraspingPos(1,3);
        send(pub,msg);
        
        pause(1.0);

        GraspingPos = GetGraspPos(item{1});
        % publishing
        [pub,msg] = rospublisher('position','geometry_msgs/Point');
        msg.X = GraspingPos(1,1);
        msg.Y = GraspingPos(1,2);
        msg.Z = GraspingPos(1,3);
        send(pub,msg);
    else
        fprintf('There has been an error in object detection');
        return
    end
end

%% Figures
% figure;
% pc2 = pointCloud(cartValid); % view entire scene
% pcshow(pc2)
% figure;
% pcshow(Objects) % view all objects
% figure;
% pcshow(detectedObj); % view detected object

%% Publishing
% [pub,msg] = rospublisher('position','geometry_msgs/Point');
% 
% msg.X = GraspingPos(1,1);
% msg.Y = GraspingPos(1,2);
% msg.Z = GraspingPos(1,3);
% send(pub,msg);