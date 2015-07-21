Vagrant.configure("2") do |config|
  config.vm.box = "boxcutter/ubuntu1404-docker"

  config.vm.provider :virtualbox do |vb|
    vb.name = 'packer-builder'
    vb.customize ["modifyvm", :id, "--memory", "1024" ]
    vb.customize ["modifyvm", :id, "--cpus",  "2" ]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "shell", path: "scripts/golang.sh"
  config.vm.provision "shell", path: "scripts/packer-dockerfile.sh"

    config.vm.provision :shell, :inline => <<-END
      sudo apt-get update -qq
      sudo apt-get install bsdtar -y
      cd /usr/bin; wget -qO- https://dl.bintray.com/mitchellh/packer/packer_0.8.2_linux_amd64.zip | bsdtar -pxvf-;
      sudo chmod +x /usr/bin/packer*
    END

end
