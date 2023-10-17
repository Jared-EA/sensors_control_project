// rgbd_sensing_node.cpp

#include "ros/ros.h"
#include "rgbd_sensing.h"
#include <thread>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "rgbd_sensing_node");
    ros::NodeHandle nh;

    std::shared_ptr<RGBDSensor> sensor(new RGBDSensor(nh));
    std::thread t(&RGBDSensor::sensingThread, sensor);

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
