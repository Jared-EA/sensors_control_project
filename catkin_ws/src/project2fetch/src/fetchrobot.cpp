#include <iostream>
#include "fetchrobot.h"

FetchRobotController::FetchRobotController(ros::NodeHandle nh) : nh_(nh) {

}

void FetchRobotController::seperateThread() {
    std::cout << "test run for command output" << std::endl;
}