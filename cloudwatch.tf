# Save the AWSCloudAgent configuration file within the SSM parameter.
resource "aws_ssm_parameter" "cw_agent" {
  description = "Configuring the CloudwatchAgent to set up custom logging"
  name        = "/cloudwatch-agent/config"
  type        = "String"
  value       = file("cw_agent_config.json")
}

# Create a log group to be used in the CloudAgent configuration file.
resource "aws_cloudwatch_log_group" "Nginx-log-group" {
  name              = "application_logs"
  retention_in_days = 7
}

# Create log stream for system logs
resource "aws_cloudwatch_log_stream" "syslog" {
  name           = "Syslog"
  log_group_name = aws_cloudwatch_log_group.Nginx-log-group.name
}
# Create a log stream for CloudWatch Agent logs
resource "aws_cloudwatch_log_stream" "cloudwatch-logs" {
  name           = "Cloudwatch"
  log_group_name = aws_cloudwatch_log_group.Nginx-log-group.name
}

