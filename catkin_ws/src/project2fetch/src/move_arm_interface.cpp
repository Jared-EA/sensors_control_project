#include "move_arm_interface.h"

MoveArmInterface::MoveArmInterface(ros::NodeHandle& nh)
{
    move_group = std::make_shared<moveit::planning_interface::MoveGroupInterface>("arm");
}

bool MoveArmInterface::moveTo(double x, double y, double z)
{
    // Create a target pose
    geometry_msgs::Pose target_pose;
    target_pose.orientation.w = 1.0;  // Make sure to set this to avoid undefined behavior
    target_pose.position.x = x;
    target_pose.position.y = y;
    target_pose.position.z = z;

    move_group->setPoseTarget(target_pose);

    // Plan the motion and then move
    moveit::planning_interface::MoveGroupInterface::Plan my_plan;
    bool success = (move_group->plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);

    if (success)
    {
        move_group->execute(my_plan);
    }

    return success;
}
