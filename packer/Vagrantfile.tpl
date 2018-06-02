# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.network "public_network"
    config.vm.network "forwarded_port", guest: 12222, host: 12222, auto_correct: true
    config.ssh.guest_port = 12222

    config.vm.provider :virtualbox do |v, override|
        v.gui = false
        v.customize ["modifyvm", :id, "--memory", 512]
        v.customize ["modifyvm", :id, "--cpus", 1]
        v.customize ["modifyvm", :id, "--vram", "256"]
        v.customize ["modifyvm", :id, "--ioapic", "on"]
        v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
        v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        v.customize ["modifyvm", :id, "--hwvirtex", "on"]
        v.customize ["modifyvm", :id, "--paravirtprovider", "default"]
    end

    if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :box
    end

    config.vm.post_up_message = "To configure your honeypot:
$ vagrant ssh
# cd /home/vagrant/dshield/bin
# sudo ./install.sh
"

end
