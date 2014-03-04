VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box     = "wheezy"
    config.vm.box_url = "https://www.dropbox.com/s/23gupgb0xompvkm/Wheezy64.box"
    
	config.vm.provider "virtualbox" do |vb|
		vb.customize [ "modifyvm", :id, "--name", "devstation" ]
		vb.customize [ "modifyvm", :id, "--memory", "1024", "--cpus", "1" ]
	end

    # config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :private_network, ip: "11.11.11.11"
    config.vm.host_name = "devstation"

    #config.vm.share_folder ".", "/home/vagrant", :create => true, :remount => true

    config.vm.provision :shell, :inline => "echo \"America/Monterrey\" | sudo tee /etc/timezone"
        
    # STUFF
    config.vm.provision :shell, :path => "bootstrap.sh"

    # SERVER INSTALL
    # config.vm.provision :shell, :path => "servers/apache.sh"
    config.vm.provision :shell, :path => "servers/nginx.sh"

    # DATABASE
    config.vm.provision :shell, :path => "databases/mysql.sh"
end
