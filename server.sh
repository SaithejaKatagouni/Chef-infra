#!/bin/bash
# UN: vagrant
# pwd vagrant
# sudo su -

#log dea
#https://www.itzgeek.com/how-tos/linux/centos-how-tos/setup-chef-12-centos-7-rhel-7.html

#All machines
echo "10.0.0.10  chef-server.mylab.local  chef-server"  >> /etc/hosts
echo "10.0.0.11  chef-node001.mylab.local  chef-node001" >> /etc/hosts
echo "10.0.0.12  chef-workstation.mylab.local chef-workstation"  >> /etc/hosts

mkdir -p /opt/lab/chef
cd /opt/lab/chef

wget https://packages.chef.io/stable/el/7/chef-server-core-12.10.0-1.el7.x86_64.rpm
rpm -ivh chef-server-core-*.rpm
chef-server-ctl reconfigure
chef-server-ctl status

chef-server-ctl user-create admin admin admin admin@mylab.local password -f /etc/chef/admin.pem
chef-server-ctl org-create mylab "MyLab, Chef" --association_user admin -f /etc/chef/mylab-validator.pem

# firewall-cmd --permanent --zone public --add-service http
# firewall-cmd --permanent --zone public --add-service https
# firewall-cmd --reload
