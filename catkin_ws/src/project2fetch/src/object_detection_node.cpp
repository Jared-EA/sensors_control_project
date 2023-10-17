// object_detection_node.cpp

#include "ros/ros.h"
#include "object_detection.h"
#include <thread>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "object_detection_node");
    ros::NodeHandle nh;

    std::shared_ptr<ObjectDetector> detector(new ObjectDetector(nh));
    std::thread t(&ObjectDetector::detectionThread, detector);

    ros::Rate loop_rate(20);
    while (ros::ok())
    {
        // Any additional logic or checks if needed
        
        loop_rate.sleep();
        ros::spinOnce();
    }

    t.join();
    return 0;
}
