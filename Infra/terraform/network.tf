/*
VPC (Virtual Private Cloud)
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

Summary:
Simple Analogy
VPC: Think of it as a private office building (your isolated network).
CIDR Block: Think of it as the range of office numbers you can assign to rooms within that building.
*/

/* Simple analogy
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
*/

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

/*
Key Components
Resource Definition

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
Summary
This Terraform configuration creates two subnets within the specified VPC, each with a unique CIDR block and placed in different availability zones for redundancy and high availability.
*/
/*
summary:
Analogy
Continuing with the office building analogy:

VPC: The entire office building.
Subnets: Different floors or sections within the building.
The first floor (subnet) has rooms numbered from 10.0.0.0 to 10.0.0.255.
The second floor (subnet) has rooms numbered from 10.0.1.0 to 10.0.1.255.
Availability Zones: Different wings of the building (for example, East Wing and West Wing).
By placing each subnet in different availability zones, you ensure that if one wing of the building faces an issue, the other wing can continue functioning normally.

*/

resource "aws_subnet" "subnet" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

/*
Summary
The data "aws_availability_zones" "available" {} block is a data source used to dynamically fetch the list of availability zones in the current AWS region.
It is empty because no additional configuration is needed to fetch this information.
The fetched availability zone names are used to configure resources dynamically, ensuring that your infrastructure is resilient and distributed across multiple zones.
*/
data "aws_availability_zones" "available" {}
