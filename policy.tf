#AWS provider
provider "aws" {
  region = var.aws_region
}

#Creation policy for role
resource "aws_iam_role_policy" "test" {
  name = var.role_name
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
       {  

	"Action": [
                "ec2:DescribeFastLaunchImages",
                "ec2:GetDefaultCreditSpecification",
                "ec2:GetIpamResourceCidrs",
                "ec2:GetIpamPoolCidrs",
                "ec2:GetEbsEncryptionByDefault",
                "ec2:ExportClientVpnClientConfiguration" 
	]
  	Effect   = "Allow"
        Resource = "*"
        },

	{
	"Action": [
                "s3:GetObject",
                "s3:GetBucketAcl"
 	]
 	Effect   = "Allow"
        Resource = "*"   
	},

	{
 	"Action": [
                  "ebs:ListSnapshotBlocks",
                "ebs:ListChangedBlocks",
                "ebs:GetSnapshotBlock" 
	]
 	Effect   = "Allow"
        Resource = "*"   
	},

	{

	"Action": [
	"resource-groups:GetGroupQuery",
                "resource-groups:GetGroup",
                "resource-groups:GetGroupConfiguration",
                "resource-groups:GetTags"
	]
         "Resource": "*"
 	 Effect   = "Allow"
	},


 	{
           
        "Action": [
                "cloudwatch:DescribeInsightRules",
                "cloudwatch:DescribeAlarmHistory",
                "cloudwatch:GetDashboard",
                "cloudwatch:GetInsightRuleReport",
                "cloudwatch:GetMetricData",
                "cloudwatch:DescribeAlarmsForMetric",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:GetMetricStream",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:GetMetricWidgetImage",
                "cloudwatch:DescribeAnomalyDetectors"
            ]
	Effect   = "Allow"
        "Resource": "*"
        },

 	{
          
            "Action": [
                "codebuild:BatchGetProjects",
                "codebuild:BatchGetBuildBatches",
                "codebuild:GetReportGroupTrend",
                "codebuild:BatchGetReports",
                "codebuild:DescribeTestCases",
                "codebuild:GetResourcePolicy",
                "codebuild:DescribeCodeCoverages",
                "codebuild:BatchGetReportGroups",
                "codebuild:BatchGetBuilds"
            ]
	Effect   = "Allow"
        "Resource": "*"
	},

	{
            "Action": [
                "autoscaling-plans:DescribeScalingPlans",
                "autoscaling-plans:GetScalingPlanResourceForecastData",
                "autoscaling-plans:DescribeScalingPlanResources"
            ]
	Effect   = "Allow"
            "Resource": "*"
        },

    ]
  })
}

#creation of role

resource "aws_iam_role" "role" {
  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}



