# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "Pysis/fedora29-workstation"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
   # Display the VirtualBox GUI when booting the machine
   vb.gui = true
   # Customize the amount of memory on the VM:
   vb.memory = 4096
   # Customize CPU cap
   vb.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
   # Customize number of CPU
   vb.cpus = 2
   # Customize VM name
   vb.name = "CamFlow-rpm"
   # Disable usb 2.0
   vb.customize ["modifyvm", :id, "--usb", "on"]
   vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    # Install Camflow
    sudo dnf -y install curl git
    git -C camflow-install pull || git clone https://github.com/CamFlow/camflow-install.git
    cd camflow-install && make install_rpm
		# Boot by default to Camflow
    sudo sed -i 's/saved/0/g' /etc/default/grub
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    sudo dnf -y install ruby ruby-devel redhat-rpm-config graphviz
    gem install json rgl mqtt rake bundler camtool
    cd ..
    # Install Concourse
    sudo dnf -y install docker
    sudo dnf -y install docker-compose
    sudo systemctl enable docker
    sudo systemctl start docker
    wget -nc https://concourse-ci.org/docker-compose.yml
    # Install Wget-1.17
    sudo dnf install -y gnutls-devel
    sudo dnf -y -v groupinstall 'Development Tools'
    sudo dnf install -y pkg-config
    cd /usr/share
    sudo wget https://ftp.gnu.org/gnu/wget/wget-1.17.tar.gz
    sudo tar xvzf wget-1.17.tar.gz
    sudo rm wget-1.17.tar.gz
    cd wget-1.17
    sudo ./configure
    sudo make
    sudo make install
    sudo make clean
    sudo ln -s /usr/share/wget-1.17 /usr/share/wget
  SHELL
end
