Kyler Lawbaugh
June 10, 2025


# What Does it Mean to Set Up a Minecraft Server?
We're going to set up a Minecraft Server!! This will be even easier with everything working in the background.
To help you understand what is going on here are some basic details on what setting up a server enables:

**Custom TCP 25565** for all IPv4 connections (0.0.0.0/0)

**SSH on port 22** for all IPv4 connections (0.0.0.0/0)

(**NOTE:** Port 22 is for SSH connections so we can set up our server. Port 25565 is the minecraft server port. We choose “Any IPv4” as the permitted CIDR blocks so we can have 0.0.0.0/0)

By using Terraform, we will create the AWS EC2 instance automatically, with security groups and key pairs already defined. This will allow an easy setup of the server.

Ansible works to install the dependencies we need to run the server, while also creating a service that makes the minecraft server automatically restart.


# What do you need to to install before?
**AWS CLI** of at least version 2.x by using `sudo apt install awscli`

**Terraform** of at least version 1.x by navigating to [terraform](https://developer.hashicorp.com/terraform/install) 

**Python 3** of at least version 3.8+

**Ansible** of at least version 2.10+ by using `pip install ansible`

**Git** latest version using `sudo apt install git`


**IMPORTANT** You will also need an **Amazon Access Key** stored in your directory **~/.aws/credentials**



# Setting up Your Server
Now that we have the dependencies and understand some of the basic background processes, let's get it set up!

**Step 1. Clone the git repo** - `git clone https://github.com/kylerlawbaugh/sysadminMC.git`

**Step 2. Configure AWS credentials** - `aws configure`

**Step 3. Create Instance with Terraform and get Public IP**
```
cd terraform
terraform init
terraform apply
```

Running these commands should result in the output of the public IP of your server. 
This is needed in the next step, so please copy this!


**Step 4. Run Ansible Playbook** - Please replace the "YOUR_PUBLIC_IP_GOES_HERE" in the "/config/host.ini" file

Once you've replace that value, please run the following commands to start your Ansible playbook:
```
cd ../ansible
ansible-playbook -i host.ini minecraft.yml
```

With these simple steps, you should have set up the server! Move onto the next step if you need brief help testing or troubleshooting your new server.



# Testing your Server
You can test that your server is running with a few different commands, or connect to the server!

**Journalctl** - `sudo journalctl -u minecraft.service -f`

**Install nmap** - `sudo install nmap -y`

**Scan with nmap** - `nmap -sV -Pn -p T:25565 SERVER_IP`


Journalctl will describe what is occurring in the background of the minecraft.service, while nmap will describe the open ports and information on its version. When the port is open, users will have the ability to connect to the server.

Enjoy the minecraft server!




# Resources / Help Used

[Minecraft Official Server Download](https://www.minecraft.net/en-us/download/server)


[AWS Blog for Setting Up Java MC Server](https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/)