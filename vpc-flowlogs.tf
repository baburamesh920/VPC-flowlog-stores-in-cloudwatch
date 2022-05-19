resource "aws_flow_log" "ramesh" {
  iam_role_arn    = aws_iam_role.ramesh_role.arn
  log_destination = aws_cloudwatch_log_group.ramesh_lg.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.ramesh.id
}

resource "aws_cloudwatch_log_group" "ramesh_lg" {
  name = var.log_group_name
}

resource "aws_iam_role" "ramesh_role" {
  name = var.iam_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ramesh_pol" {
  name = var.iam_policy_name
  role = aws_iam_role.ramesh_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

//Note:- Hi Ramesh bro the above script will create vpc flowlogs and stream the logs to cloudwatch log-group automatically if you want to use s3 as the destination use below script


# resource "aws_flow_log" "ramesh1" {
#   log_destination      = aws_s3_bucket.ramesh_bkt.arn
#   log_destination_type = "s3"
#   traffic_type         = "ALL"
#   vpc_id               =  use your vpc id here
#   destination_options {
#     file_format        = "parquet" 
#     per_hour_partition = true
#   }
# }

# resource "aws_s3_bucket" "ramesh_bkt" {
#   bucket = var.bucket_name
# }
