#!/bin/bash
# UN: vagrant
# pwd vagrant
# sudo su -

#All machines
echo "10.0.0.10  chef-server.mylab.local  chef-server"  >> /etc/hosts
echo "10.0.0.11  chef-node001.mylab.local  chef-node001" >> /etc/hosts
echo "10.0.0.12  chef-workstation.mylab.local chef-workstation"  >> /etc/hosts

mkdir -p /opt/lab/chef
cd /opt/lab/chef

wget https://packages.chef.io/stable/el/7/chefdk-0.19.6-1.el7.x86_64.rpm

rpm -ivh chefdk-*.rpm
chef verify

which ruby

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
. ~/.bash_profile
which ruby

chef generate repo chef-repo
ls -al   ~/chef-repo/

git config --global user.name "Sai"
git config --global user.email "admin@itzgeek.local"

cd ~/chef-repo/
git init
mkdir -p ~/chef-repo/.chef
echo '.chef' >> ~/chef-repo/.gitignore

cd ~/chef-repo/
git add .
git commit -m "initial commit"
git status

scp -pr vagrant@chef-server:/etc/chef/admin.pem ~/chef-repo/.chef/
scp -pr vagrant@chef-server:/etc/chef/mylab-validator.pem ~/chef-repo/.chef/


cat <<EOF >  ~/chef-repo/.chef/knife.rb
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "admin"
client_key               "#{current_dir}/admin.pem"
validation_client_name   "mylab-validator"
validation_key           "#{current_dir}/mylab-validator.pem"
chef_server_url          "https://chef-server.mylab.local/organizations/mylab"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["#{current_dir}/../cookbooks"]
EOF


cd ~/chef-repo/
knife client list
knife ssl fetch
knife client list
