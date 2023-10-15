#include "ros/ros.h"
#include "fetchrobot.h"
#include <thread>

int main(int argc, char **argv) {
    ros::init(argc,argv, "project2fetch");
    ros::NodeHandle nh;

    FetchRobotController controller(nh);

    std::thread t(&FetchRobotController::seperateThread, &controller);

    ros::spin();
    ros::shutdown();

    t.join();

    return 0;
}