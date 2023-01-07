resource "aws_autoscaling_group" "AutoScallingGroup" {
  name = "ASGGroupp"
  max_size             = var.MaxCapacity
  min_size             = var.MinCapacity
  launch_configuration = var.launch-config-name
  vpc_zone_identifier  = [var.privSub1Id, var.privSub2Id]
  target_group_arns = [var.target-group-arns]
  
}
resource "aws_autoscaling_policy" "ASGpolicy" {
  name = "ASGPoliccy"
  
 target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

  target_value = var.CPUPolicyTargetValue
 }
  policy_type= "TargetTrackingScaling"
  autoscaling_group_name= aws_autoscaling_group.AutoScallingGroup.name
  
}