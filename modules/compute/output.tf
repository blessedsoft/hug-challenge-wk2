output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "alb_arn" {
  value = aws_lb.app.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "autoscaling_group_name" {
  value = aws_autoscaling_group.app.name
}