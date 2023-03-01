# Create two variables with policy names
locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}
# Create the profile for the EC2 instance using the defined role. luego
resource "aws_iam_instance_profile" "this" {
  name = "EC2-Profile"
  role = aws_iam_role.this.name
}

# Add two policies to be able to connect to SSM and another the CloudWatchAgent.
resource "aws_iam_role_policy_attachment" "this" {
  count      = length(local.role_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = element(local.role_policy_arns, count.index)
}
# Creating an embedded policy for role
resource "aws_iam_role_policy" "this" {
  name   = "EC2-Inline-Policy"
  role   = aws_iam_role.this.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:GetParameter"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

# Define role for EC2 instance
resource "aws_iam_role" "this" {
  name = "EC2-Role"
  path = "/"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}