#ifndef MOVE_ARM_INTERFACE_H
#define MOVE_ARM_INTERFACE_H

#include <ros/ros.h>
#include <moveit/move_group_interface/move_group_interface.h>

class MoveArmInterface
{
public:
    MoveArmInterface(ros::NodeHandle& nh);
    bool moveTo(double x, double y, double z);

private:
    std::shared_ptr<moveit::planning_interface::MoveGroupInterface> move_group;
};

#endif // MOVE_ARM_INTERFACE_H
