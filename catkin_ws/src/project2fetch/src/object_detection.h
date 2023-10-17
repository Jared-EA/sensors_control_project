// object_detection.h
#ifndef OBJECT_DETECTION_H
#define OBJECT_DETECTION_H

#include <ros/ros.h>
#include <sensor_msgs/Image.h>
#include <std_msgs/String.h>  // For simplicity, replace with a custom message for detected objects

class ObjectDetector {
public:
    ObjectDetector(ros::NodeHandle& nh);
    void detectionThread();

private:
    ros::NodeHandle nh_;
    // Add subscribers, publishers, and other class members here
};

#endif  // OBJECT_DETECTION_H
