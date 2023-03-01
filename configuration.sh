#! /bin/bash
set -e
# Print out all CloudWatch Agent logs
exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1

# Update packages
sudo apt-get update

# Download CloudWatch Agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
# Install CloudWatch Agent
dpkg -i -E ./amazon-cloudwatch-agent.deb
# Using the Cloudwatch SSM configuration received with the SSM parameter
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s

# Install Nginx
sudo apt-get install -y nginx
# Start Nginx
sudo systemctl start nginx
# Updating the default port to a custom port:8080
sed -i 's/listen 80/listen 8080/' /etc/nginx/sites-available/default
# Restart nginx to take the changes on port
systemctl restart nginx
# Print message for index
echo "Hello World $(date)" > /var/www/html/index.html