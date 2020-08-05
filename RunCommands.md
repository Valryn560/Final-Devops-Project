# Getting Front End up & Running

## Create a new VM, Either through portal or CLI
az vm create --resource-group resourcegroupname --name vmname --image UbuntuLTS --admin-username yourname --generate-ssh-keys

## Open Port 4200 & 80
az vm open-port --port 4200 --resource-group resourcegroupname --name vmname

az vm open-port --port 80 --resource-group resourcegroupname --name vmname

## Connect to VM
ssh username@ipaddress

## Update Apt 
sudo apt install

sudo apt update

## Install Node | Note this ones only for Ubuntu Distributions
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt-get install -y nodejs

## Install angular CLI
npm install -g @angular/cli@8.0.1

## Clone project
git clone https://github.com/MIhsanA/DevOps-Final-Project.git -b Development

## CD into angular project
CD DevOps-Final-Project/spring-petclinic-angular 

## Install project prerequisits
npm install

## Then run the application on local host
ng serve --open --host 0.0.0.0
