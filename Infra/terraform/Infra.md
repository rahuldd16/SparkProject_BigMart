
### VPC (Virtual Private Cloud):
```terraform
    resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}
```


A Virtual Private Cloud (VPC) is a private network within the AWS cloud where you can launch your AWS resources, like EC2 instances (virtual servers), databases, and more. It's isolated from other networks for security and control.

CIDR Block
CIDR Block (Classless Inter-Domain Routing) is a way to define a range of IP addresses for your network. It helps you specify which IP addresses your VPC can use.

Example
Imagine you have a VPC that represents a private section of your AWS network. You want to assign a range of IP addresses to this VPC. You do this using a CIDR block.

For example:

CIDR Block: 10.0.0.0/16
This means:

The network starts at 10.0.0.0.
The /16 part defines the size of the network, allowing for 65,536 IP addresses (from 10.0.0.0 to 10.0.255.255).

##### Summary:
Simple Analogy
VPC: Think of it as a private office building (your isolated network).
CIDR Block: Think of it as the range of office numbers you can assign to rooms within that building.

Simple analogy
Office Building Analogy
VPC (Virtual Private Cloud)
Think of a VPC as an office building:

The office building is your own private space within a larger business complex (the AWS cloud).
Inside this building, you can set up various offices, meeting rooms, and departments (AWS resources like EC2 instances, databases, etc.).
CIDR Block
The CIDR block is like the floor plan and office numbering system in your building:

The CIDR block (10.0.0.0/16) is similar to saying "This office building has rooms numbered from 1000 to 1999."
The /16 part specifies how many rooms you have (like the total number of office spaces available).
Subnets
Subnets are like different floors or sections within your office building:

You can divide your office building into different floors, such as:
Public Floor (Public Subnet): Accessible to both employees and visitors.
Private Floor (Private Subnet): Restricted access, only for employees.
For example:
Public Floor: Rooms numbered from 1100 to 1199 (10.0.1.0/24).
Private Floor: Rooms numbered from 1200 to 1299 (10.0.2.0/24).
Uses of IP Addresses
Rooms/Offices (EC2 Instances): Each office (instance) gets a unique room number (IP address).

Web Server 1: Room 1101 (10.0.1.101)
Web Server 2: Room 1102 (10.0.1.102)
Database Server: Room 1201 (10.0.2.101)
Common Areas (Gateways, Routers): Just like common areas in an office building (like lobbies and reception desks), gateways and routers have IP addresses that help direct traffic.

Internet Gateway: Like the main entrance where deliveries and guests arrive.
Summary
VPC: Your private office building in the cloud.
CIDR Block: The range of room numbers you can use in your building.
Subnets: Different floors or sections of your building.
IP Addresses: Specific room numbers for offices, common areas, and resources.
This analogy helps visualize how a VPC organizes and manages resources within the AWS cloud, similar to how an office building is structured and managed.




### AWS_SUBNET:

```terraform
    resource "aws_subnet" "subnet" {
        count             = 2
        vpc_id            = aws_vpc.vpc.id
        cidr_block        = "10.0.${count.index}.0/24"
        availability_zone = element(data.aws_availability_zones.available.names, count.index)
        }
```


resource "aws_subnet" "subnet": This line defines a resource of type aws_subnet and names it subnet.
Count

count = 2: This specifies that Terraform should create two subnets.
VPC ID

vpc_id = aws_vpc.vpc.id: This line references the ID of the VPC created earlier (aws_vpc.vpc). Each subnet is being associated with this VPC.
CIDR Block

cidr_block = "10.0.${count.index}.0/24": This dynamically generates the CIDR block for each subnet using the count index.
For the first subnet (count.index = 0), the CIDR block is 10.0.0.0/24.
For the second subnet (count.index = 1), the CIDR block is 10.0.1.0/24.
Availability Zone

availability_zone = element(data.aws_availability_zones.available.names, count.index): This assigns each subnet to a different availability zone.
data.aws_availability_zones.available.names is a data source that fetches available availability zones.
element(..., count.index) selects an availability zone based on the count index.
For the first subnet, it selects the first availability zone.
For the second subnet, it selects the second availability zone.
Step-by-Step Breakdown
Count

Terraform will create two subnets because count = 2.
VPC Association

Both subnets will be associated with the VPC identified by aws_vpc.vpc.id.
CIDR Block Calculation

For the first subnet (count.index = 0):
cidr_block = "10.0.${count.index}.0/24" becomes 10.0.0.0/24.
For the second subnet (count.index = 1):
cidr_block = "10.0.${count.index}.0/24" becomes 10.0.1.0/24.
Availability Zone Assignment

element(data.aws_availability_zones.available.names, count.index) dynamically selects the availability zone:
For the first subnet (count.index = 0): It uses the first availability zone.
For the second subnet (count.index = 1): It uses the second availability zone.
#### Summary
This Terraform configuration creates two subnets within the specified VPC, each with a unique CIDR block and placed in different availability zones for redundancy and high availability.

summary:
Analogy
Continuing with the office building analogy:

VPC: The entire office building.
Subnets: Different floors or sections within the building.
The first floor (subnet) has rooms numbered from 10.0.0.0 to 10.0.0.255.
The second floor (subnet) has rooms numbered from 10.0.1.0 to 10.0.1.255.
Availability Zones: Different wings of the building (for example, East Wing and West Wing).
By placing each subnet in different availability zones, you ensure that if one wing of the building faces an issue, the other wing can continue functioning normally.



Summary
The data "aws_availability_zones" "available" {} block is a data source used to dynamically fetch the list of availability zones in the current AWS region.
It is empty because no additional configuration is needed to fetch this information.
The fetched availability zone names are used to configure resources dynamically, ensuring that your infrastructure is resilient and distributed across multiple zones.
```terraform
    data "aws_availability_zones" "available" {}
```

### Corporate Headquarters Building (EKS Cluster):
```terraform
    resource "aws_eks_cluster" "eks_cluster" {
      name     = "my-eks-cluster"
      role_arn = aws_iam_role.eks_role.arn
      version  = "1.21"
    
      vpc_config {
        subnet_ids = aws_subnet.subnet[*].id
      }
    }

```
Headquarters Building (EKS Cluster): This is like the blueprint for your new corporate headquarters, named my-eks-cluster. It represents the entire office complex where your teams (applications) will work.
Role ARN (Building Manager): The role_arn refers to the IAM role that will manage this headquarters. Think of it like giving the building manager (role) the authority to handle various operations in the building.
Version (Building Standards): The version (1.21) specifies the standards or specifications of the building, similar to choosing a particular building design or technology infrastructure.
VPC Configuration (Business Park Layout): The vpc_config specifies the layout of the business park (VPC) where the headquarters is located. subnet_ids are like different sections or wings of the business park where various departments (resources) will be set up.

resource "aws_eks_cluster" "eks_cluster":

Resource Type: aws_eks_cluster specifies that you are creating an Amazon EKS (Elastic Kubernetes Service) cluster.
Resource Name: eks_cluster is the name of this specific resource instance in Terraform, which you can reference in other parts of your Terraform configuration.
name = "my-eks-cluster":

Cluster Name: This sets the name of the EKS cluster to my-eks-cluster. It is the name you'll use to identify the cluster within AWS.
role_arn = aws_iam_role.eks_role.arn:

IAM Role ARN: This specifies the Amazon Resource Name (ARN) of the IAM role that the EKS cluster will assume to perform actions on your behalf. The role is defined elsewhere in your configuration (aws_iam_role.eks_role).
version = "1.21":

Kubernetes Version: This sets the Kubernetes version for the EKS cluster to 1.21. EKS manages Kubernetes for you, so you need to specify which version to use.
vpc_config:

VPC Configuration Block: This block contains settings related to the VPC (Virtual Private Cloud) where the EKS cluster will run.
subnet_ids = aws_subnet.subnet[*].id: This specifies the subnets in which the EKS cluster will launch its resources. It uses the IDs of the subnets you have defined earlier (aws_subnet.subnet[*].id), allowing the cluster to span across multiple subnets for better availability and scalability.

### Building Manager’s Credentials (IAM Role for EKS Cluster)
```terraform
resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

```


Sure! Let's break down the Terraform code for creating an AWS IAM Role used with Amazon EKS (Elastic Kubernetes Service):

Code Breakdown
hcl
Copy code
resource "aws_iam_role" "eks_role" {
name = "eks-cluster-role"

assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Action = "sts:AssumeRole"
Effect = "Allow"
Principal = {
Service = "eks.amazonaws.com"
}
},
]
})
}
Explanation
resource "aws_iam_role" "eks_role":

This declares a resource of type aws_iam_role, which is an IAM role in AWS. The identifier "eks_role" is a name given to this resource within your Terraform configuration.
name = "eks-cluster-role":

This sets the name of the IAM role to "eks-cluster-role". This is how the IAM role will be named in AWS.
assume_role_policy:

This block defines the policy that allows other entities (such as AWS services) to assume the role. It's specified in JSON format and is encoded using jsonencode for proper formatting.
Policy Details:

Version = "2012-10-17": This is the version of the policy language. It defines the syntax and features available for the policy.
Statement: Contains the policy statements.
Action = "sts:AssumeRole": Specifies that the action allowed is to assume the role. sts stands for AWS Security Token Service, which is used for temporary security credentials.
Effect = "Allow": Indicates that the action specified (assume role) is allowed.
Principal:
Service = "eks.amazonaws.com": Specifies the principal that is allowed to assume the role. In this case, it's the EKS service.
Analogy
Think of an IAM Role as a "key" to a "secure room" in your AWS environment:

IAM Role: This is like a special key that grants access to certain rooms (resources) in a building (AWS environment).
name: This is the label on the key, indicating which room it opens. Here, the label is "eks-cluster-role".
assume_role_policy: This is like the instructions on who can use the key. It specifies that only certain people or services (like EKS) can use this key to access the room.
Action: This is like saying, "The key can be used to enter the room."
Principal: This identifies who is allowed to use the key. In this case, it's the EKS service, which is like a specific employee or system that needs access.
In summary, this Terraform code sets up a key (IAM Role) that EKS (a specific service) can use to access resources in your AWS environment, following the permissions and instructions defined in the policy.

### Policy attachment to the role:

```terraform
resource "aws_iam_role_policy_attachment" "eks_role_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}
```

resource "aws_iam_role_policy_attachment" "eks_role_policy":

This defines a resource of type aws_iam_role_policy_attachment named "eks_role_policy". This resource is responsible for attaching a policy to an IAM role.
role:

This specifies the IAM role to which the policy will be attached. The value aws_iam_role.eks_role.name refers to the name of the IAM role defined elsewhere in your Terraform configuration.
policy_arn:

This specifies the ARN (Amazon Resource Name) of the IAM policy to be attached. In this case, "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" is a managed policy that provides the necessary permissions for EKS to operate. This policy allows the EKS cluster to perform actions such as managing cluster resources and interacting with other AWS services.

#### Analogies
Let's use an analogy to make this clearer:

IAM Role: Think of an IAM role as a "key" or "access badge" for a specific person or system.
IAM Policy: This is like a "permission slip" that specifies what the holder of the key (IAM role) is allowed to do.
Attaching Policies
aws_iam_role_policy_attachment for EKS Cluster Policy:

Role: This is the "key" (IAM role) that needs permissions.
Policy ARN: This is the "permission slip" granting the key (IAM role) the authority to perform specific actions related to managing the EKS cluster. The policy allows the keyholder (EKS) to perform necessary actions for cluster management.
aws_iam_role_policy_attachment for VPC Resource Controller:

Role: Again, this is the "key" (IAM role) in question.
Policy ARN: This "permission slip" allows the keyholder (EKS) to interact with VPC resources. It ensures that the keyholder can manage networking resources like subnets and route tables, which are crucial for running Kubernetes workloads within the VPC.
In summary, these Terraform resources are setting up permissions for an EKS cluster role to manage its own resources and interact with networking components. The policies are essential for granting the EKS cluster the required permissions to operate effectively.


### creating node group: [Employee Roles (IAM Role for Node Group)]->(Analogy)
####  creating node role:
```terraform
resource "aws_iam_role" "node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

```
##### analogy: 
Employee Roles (IAM Role for Node Group): This IAM role, eks-node-role, is like the role given to employees who will be working in the building. It specifies what permissions the employees (EC2 instances) have.
Assume Role Policy (Employee Access): This policy allows EC2 instances to assume this role, similar to how employees are given access to work within the headquarters.

#### creating node GROUP
##### node policy:.
```terraform
resource "aws_iam_role_policy_attachment" "node_role_policy" {
role       = aws_iam_role.node_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_role_cni_policy" {
role       = aws_iam_role.node_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}
```
##### AmazonEKSCNIPolicy:
Purpose: Grants permissions for managing network interfaces (ENIs), which is crucial for the worker nodes to handle networking within the Kubernetes cluster. This includes managing IP addresses and network connectivity for the pods.
Analogy:Think of this policy as an "additional responsibility" for network management, allowing the employee (worker node) to configure and manage network connections and interfaces as needed.
-> Networking for Pods: Kubernetes pods in EKS often require their own IP addresses to communicate with other services and pods. The AmazonEKSCNIPolicy ensures that EKS worker nodes have the necessary permissions to manage these network resources dynamically.
-> Scalability and Flexibility: By granting these permissions, the policy supports dynamic scaling of Kubernetes clusters and efficient management of network resources as pods are scheduled and terminated.


##### AmazonEKSWorkerNodePolicy:
Purpose: Provides the permissions necessary for the worker nodes to interact with the EKS cluster, manage Kubernetes resources, and perform actions required by the cluster.
Analogy: Imagine this policy as a "job description" that allows the employee (worker node) to perform tasks such as deploying applications and managing container workloads.

##### Node group:  Worker Nodes (Compute Resources) 1worker node= 1 ec2 intance

```terraform
resource "aws_eks_node_group" "node_group" {
cluster_name    = aws_eks_cluster.eks_cluster.name
node_group_name = "eks-node-group"
node_role_arn   = aws_iam_role.node_role.arn
subnet_ids      = aws_subnet.subnet[*].id
scaling_config {
desired_size = 2
max_size     = 3
min_size     = 1
}
}
```

Node Group Definition: This resource creates a node group within the EKS cluster. Node groups are the EC2 instances that actually run your containerized applications.
Cluster Name: Associates the node group with the EKS cluster created earlier.
Node Role ARN: The IAM role assigned to the EC2 instances in this node group, defining what AWS resources these nodes can access.
Subnet IDs: Specifies the subnets where the EC2 instances will be launched, ensuring they are placed within the network configuration of the cluster.
Scaling Configuration: Determines how many worker nodes (EC2 instances) will be running. It defines:
Desired Size: The number of nodes you want to have running (e.g., 2 nodes).
Max Size: The maximum number of nodes that can be running at any time (e.g., 3 nodes).
Min Size: The minimum number of nodes that should be running (e.g., 1 node).
Summary
EKS Cluster: Manages the Kubernetes control plane. It doesn’t directly involve itself with the number of worker nodes but needs to be configured to operate within a VPC.
Worker Nodes: These are EC2 instances that actually run the containerized applications. The aws_eks_node_group resource configures how many of these nodes will be present, along with their scaling behavior.



----------------------

1. Set Up AWS CLI
2. Create an EKS Cluster:  main.tf,provider.tf,network.tf
3. configure kubectl fro eks: cmd:   aws eks update-kubeconfig --region us-west-2 --name my-eks-cluster
4. Deploy Kubernetes Manifests: in this we create deployment and service file of k8
5. 