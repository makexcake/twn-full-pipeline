module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_version = "1.24"
  cluster_name = "myapp-eks-cluster"

  vpc_id = module.myapp-vpc.vpc_id
  subnet_ids = module.myapp-vpc.private_subnets

  cluster_endpoint_public_access  = true


  tags = {
    environment = "development"
    application = "myapp"
  }

  eks_managed_node_groups = {

    dev = {
      min_size = 1
      max_size = 3
      desired_size = 3

      instance_types = ["t2.medium"]
    }
  }
}


output "ng_role_name" {
  value = module.eks.eks_managed_node_groups["dev"].iam_role_name
}


resource "aws_iam_role_policy_attachment" "csi-attach" {
  role       = module.eks.eks_managed_node_groups["dev"].iam_role_name
  policy_arn = "arn:aws:iam::536167534320:policy/aws-csi-policy"
}




