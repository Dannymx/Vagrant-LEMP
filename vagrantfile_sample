Vagrant::Config.run do |config|
    config.vm.box     = "wheezy"
    config.vm.box_url = "https://www.dropbox.com/s/23gupgb0xompvkm/Wheezy64.box"
    
    config.vm.customize [ "modifyvm", :id, "--name", "devstation" ]
    config.vm.customize [ "modifyvm", :id, "--memory", "1024", "--cpus", "1" ]

    # config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :hostonly, "11.11.11.11"
    config.vm.host_name = "devstation"

    config.vm.share_folder "project", "/home/vagrant/www", :create => true, :remount => true

    config.vm.provision :shell, :inline => "echo \"America/Monterrey\" | sudo tee /etc/timezone"
        
    # STUFF
    config.vm.provision :shell, :path => "bootstrap.sh"

    # SERVER INSTALL
    # config.vm.provision :shell, :path => "servers/apache.sh"
    config.vm.provision :shell, :path => "servers/nginx.sh"

    # DATABASE
    config.vm.provision :shell, :path => "databases/mysql.sh"
end
