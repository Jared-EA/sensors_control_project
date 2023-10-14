#include <ros/ros.h>
#include <trajectory_msgs/JointTrajectory.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "fetch_joint_control_node");
    ros::NodeHandle nh;

    ros::Publisher joint_command_pub = nh.advertise<trajectory_msgs::JointTrajectory>("/arm_controller/command", 10);

    // Create a JointTrajectory message with desired joint positions
    trajectory_msgs::JointTrajectory joint_trajectory;
    joint_trajectory.joint_names = {"joint1", "joint2", "joint3", "joint4", "joint5", "joint6"};

    // Set desired joint positions
    joint_trajectory.points.resize(1);
    joint_trajectory.points[0].positions = {1.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    joint_trajectory.points[0].time_from_start = ros::Duration(1.0);  // Duration for the motion

    while (ros::ok())
    {
        // Publish the joint trajectory command
        joint_command_pub.publish(joint_trajectory);

        // You can implement your control logic here

        ros::spinOnce();
    }

    return 0;
}
