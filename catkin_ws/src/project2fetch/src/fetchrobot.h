#ifndef FETCHROBOT_H
#define FETCHROBOT_H

#include "ros/ros.h"

class FetchRobotController {
    public:    
    FetchRobotController(ros::NodeHandle nh);

    void seperateThread();
    ros::NodeHandle nh_;

    private:


};

#endif // FETCHROBOT_H
