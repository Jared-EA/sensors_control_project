function [GraspingPos] = GetGraspPos(PointCloud)
<<<<<<< HEAD
    xmin = min(PointCloud.Location(:,2));
    xmax = max(PointCloud.Location(:,2));
    ymin = min(PointCloud.Location(:,1));
    ymax = max(PointCloud.Location(:,1));
    zmin = min(PointCloud.Location(:,3));
    zmax = max(PointCloud.Location(:,3));
    xmid = ((xmax-xmin)/2);
    ymid = ((ymax-ymin)/2);
    % zmid = (zmax-zmin)/2;

    GraspingPos = [(xmin+xmid)*cos(deg2rad(35)),-(ymin+ymid),(zmax)];
=======
    xmin = min(PointCloud.Location(:,1));
    xmax = max(PointCloud.Location(:,1));
    ymin = min(PointCloud.Location(:,2));
    ymax = max(PointCloud.Location(:,2));
    zmin = min(PointCloud.Location(:,3));
    zmax = max(PointCloud.Location(:,3));
    xmid = (xmax-xmin)/2;
    ymid = (ymax-ymin)/2;
    % zmid = (zmax-zmin)/2;

    GraspingPos = [(xmin+xmid),(ymin+ymid),(zmax)];
>>>>>>> origin/main
    message = "The Grasping Position is: ";
    disp(message)
    disp(GraspingPos)
end