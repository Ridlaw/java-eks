
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name = "myapp-eks-cluster"  
  cluster_version = "1.24"

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id = module.myapp-vpc.vpc_id

  tags = {
    environment = "development"
    application = "myapp"
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.small"]
      key_name       = "devopskeypair"
    }
  }
}


data "aws_eks_cluster" "myapp-cluster" {
    name = module.eks.cluster_name             
}

data "aws_eks_cluster_auth" "myapp-cluster" {
    name = module.eks.cluster_name             
}

#for the provider "kubernetes" block to work, the cluster must already be running and accessible because it takes data from running cluster.
#The provider "kubernetes" block allows Terraform to connect to an existing Kubernetes cluster and interact with it by creating, updating or deleting Kubernetes objects (e.g., pods, services, deployments, etc.). 

provider "kubernetes" {                        
    #load_config_file = "false"               
    host = data.aws_eks_cluster.myapp-cluster.endpoint
    token = data.aws_eks_cluster_auth.myapp-cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.myapp-cluster.certificate_authority.0.data)
}
