// rgbd_sensing.h
#ifndef RGBD_SENSING_H
#define RGBD_SENSING_H

#include <ros/ros.h>
#include <sensor_msgs/Image.h>

class RGBDSensor {
public:
    RGBDSensor(ros::NodeHandle& nh);
    void sensingThread();

private:
    ros::NodeHandle nh_;
    // Add subscribers, publishers, and other class members here
};

#endif  // RGBD_SENSING_H
