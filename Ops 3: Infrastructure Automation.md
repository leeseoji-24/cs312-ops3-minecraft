# CS 312 Ops 3: Infrastructure Automation
### By: Seojin Lee  
### ONID: leeseoji | 934-461-231

## Architecture diagram

## Terraform inputs/variables
### Variables:
**ami_id:** AMI ID for the EC2 instance (Ubuntu 24.04 in us-east-1)  
**Value:** ami-0d13e2317a7e75c95

**instance_type:** EC2 instance type  
**Value:** t3.small

**key_name:** Name of the SSH key pair (must already exist in AWS)  
**Value:** Whatever name you used to create the key pair (ex: cs312-key)

## Change Process
1. Clone the terraform file/ "git checkout" to a new branch
2. Make the wanted changes to the terraform config files
3. Run terraform to see if the changes worked correctly (ex: terraform plan -var="key_name=cs312-key" to preview the changes)
4. Notify teammates/team on what changes you made and if it works correctly
5. Merge the new terraform config files into the main branch and run terraform again to apply it
   
## Teardown Checklist
1. Run ```terraform destroy -var="key_name=cs312-key"``` to remove the EC2 and ECR
2. Delete the S3 bucket data and the bucket itself
3. Double check that all instances are down/deleted
4. Stop AWS

## World-data Recovery Strategy
The "Restore world data from S3" action within the ansible playbook should automatically restore backup world data onto the server.  
It uses the ```aws s3 sync s3://{{ s3_bucket }}/minecraft-world /opt/minecraft/data --region us-east-1``` command to do it.  

If S3 is empty, the playbook should make a new world

## GitHub repository
Link: https://github.com/leeseoji-24/cs312-ops3-minecraft

## Sources
- Class Labs
- https://github.com/darrelldavis/terraform-aws-minecraft (used for terrform help)
- https://medium.com/@alexlnguyen/deploying-a-minecraft-1-12-1-server-with-ansible-a1bc03c948b3 (used for ansible playbook help)
- https://www.infralovers.com/blog/2025-06-09-terraform-with-ansible-chef/ (used for chaining terraform to ansible help)

## AI Use
I used Claude to help double check my set up process. I also used it to help with prototyping the diagram and setting up some of the github files like the .gitignore file.
It was used mostly for shell commands and to help me understand some of the set up steps from the sources I used.
