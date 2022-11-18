resource "aws_iam_user" "usr2" {
  name = "user1"

}


resource "aws_iam_user_policy" "lb" {
  name = "test"
  user = aws_iam_user.usr2.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

