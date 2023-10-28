#include "ros/ros.h"
#include "fetchrobot.h"
#include <thread>
#include <ros/ros.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/LaserScan.h>
#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>
#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>
#include <moveit_visual_tools/moveit_visual_tools.h>

// ros::Publisher image_pub;

// void callback_image(const sensor_msgs::Image::ConstPtr& msg){
//     ROS_INFO("here we are!!!");

//     // std_msgs::ColorRGBA
// }

int main(int argc, char **argv) {
    ros::init(argc, argv, "project2fetch_run");
    ros::NodeHandle nh;

    // ROS spinning must be running for the MoveGroupInterface to get information
    // about the robot's state. One way to do this is to start an AsyncSpinner
    // beforehand.
    ros::AsyncSpinner spinner(1);
    spinner.start();

    // MoveIt operates on sets of joints called "planning groups" and stores them in an object called
    // the `JointModelGroup`. Throughout MoveIt the terms "planning group" and "joint model group"
    // are used interchangably.
    static const std::string PLANNING_GROUP_ARM = "robot_arm";
    static const std::string PLANNING_GROUP_GRIPPER = "gripper";

    // The :planning_interface:`MoveGroupInterface` class can be easily
    // setup using just the name of the planning group you would like to control and plan for.
    moveit::planning_interface::MoveGroupInterface move_group_interface_arm(PLANNING_GROUP_ARM);
    moveit::planning_interface::MoveGroupInterface move_group_interface_gripper(PLANNING_GROUP_GRIPPER);


    while (ros::ok()){
        loop_rate.sleep();

        ros::spin();

        ros::shutdown();

        t.join();
    }

    return 0;
}
