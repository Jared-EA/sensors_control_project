% load using gazebo
close all

setenv('ROS_IP','172.25.128.1'); %Christians IP, also set correct IP on WSL through 
% '$ ifconfig', then set '$ export ROS_IP=xxxx.xxx.xxx.xxx' in WSL window

OBJECT_TO_FIND = 2; % 1 = coke 
                    % 2 = cube

%% Depth Cloud
depthpoints = rossubscriber('/head_camera/depth_registered/points','DataFormat','struct');
points = receive(depthpoints,5);

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

% find values below the table
for i = 1:numel(cartObject(:,3))
    if cartObject(i,3) < 0.775 
        counter = counter + 1; 
    end
end

% delete values below table
cartObject(1:counter,:) = []; 

% point clouds
Objects = pointCloud(cartObject);

%% POINT CLOUD OBJECT DETECTION 
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

%                         something wrong here

if length(matchpairs1) > length(matchpairs2)
    detectedObj = item{1};
else 
    if length(matchpairs1) < length(matchpairs2)
        detectedObj = item{2};
    else
        fprintf('There has been an error in object detection');
        return
    end
end

% switch OBJECT_TO_FIND
%     case 1
%         fprintf('doing case 1 \n')
%         if mean(scores1) < mean(scores2)
%             detectedObj = item{2};
%         else
%             fprintf('There has been an error in object detection');
%             return
%         end
%     case 2 
%         fprintf('doing case 2 \n')
%         if mean(scores2) < mean(scores1)
%             detectedObj = item{1};
% 
%         else
%             fprintf('There has been an error in object detection');
%             return
%         end
% end

%% Grasping Position
xmin = min(detectedObj.Location(:,1));
xmax = max(detectedObj.Location(:,1));
ymin = min(detectedObj.Location(:,2));
ymax = max(detectedObj.Location(:,2));
zmin = min(detectedObj.Location(:,3));
zmax = max(detectedObj.Location(:,3));
xmid = (xmax-xmin)/2;
ymid = (ymax-ymin)/2;
zmid = (zmax-zmin)/2;

GraspingPos = [(xmin+xmid),(ymin+ymid),(zmin+zmid)]

%% Figures
% figure;
% pc2 = pointCloud(cartValid); % view entire scene
% pcshow(pc2)
figure;
pcshow(Objects) % view all objects
figure;
pcshow(detectedObj); % view detected object

%% Publishing
[pub,msg] = rospublisher('position','geometry_msgs/Point');

msg.X = GraspingPos(1,1);
msg.Y = GraspingPos(1,2);
msg.Z = GraspingPos(1,3);
send(pub,msg);
