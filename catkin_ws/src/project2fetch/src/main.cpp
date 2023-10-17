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

ros::Publisher image_pub;

void callback_image(const sensor_msgs::Image::ConstPtr& msg){
    ROS_INFO("here we are!!!");

    // std_msgs::ColorRGBA
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "project2fetch");
    ros::NodeHandle nh;

    ros::Subscriber  image_scan = nh.subscribe("/head_camera/rgb/image_raw", 1, callback_image);

    image_pub = nh.advertise<std_msgs::ColorRGBA>("image_topic", 1);

    FetchRobotController controller(nh);

    // // Name of the move group (should be defined in your SRDF)
    // moveit::planning_interface::MoveGroupInterface group("arm_with_torso"); 
    // // Set a target pose for the Fetch robot's arm
    // geometry_msgs::Pose target_pose;
    // target_pose.orientation.w = 1.0;
    // target_pose.position.x = 0.4;
    // target_pose.position.y = -0.2;
    // target_pose.position.z = 0.8;
    // group.setPoseTarget(target_pose);

    // // Plan the motion and execute it
    // moveit::planning_interface::MoveGroupInterface::Plan my_plan;
    // bool success = (group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
    // if (success) {
    //     ROS_INFO("Plan found. Executing...");
    //     group.execute(my_plan);
    // } else {
    //     ROS_WARN("No plan found. Ensure that the target pose is reachable and not in collision.");
    // }

    std::thread t(&FetchRobotController::seperateThread, &controller);

    ros::Rate loop_rate(20);

    while (ros::ok()){
        loop_rate.sleep();

        ros::spin();

        ros::shutdown();

        t.join();
    }

    return 0;
}
