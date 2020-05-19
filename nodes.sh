
echo "10.0.0.10  chef-server.mylab.local  chef-server"  >> /etc/hosts
echo "10.0.0.11  chef-node001.mylab.local  chef-node001" >> /etc/hosts
echo "10.0.0.12  chef-workstation.mylab.local chef-workstation"  >> /etc/hosts

mkdir -p /opt/lab/chef
cd /opt/lab/chef

#Should be running from WS node only

knife bootstrap chef-node001 -x vagrant -P vagrant --sudo

knife node list

knife client show chef-node001
