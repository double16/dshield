#!/bin/bash -e

# Clean up
# apt-get -y --purge remove linux-headers-$(uname -r) build-essential
# apt-get -y --purge autoremove
# apt-get -y purge $(dpkg --list |grep '^rc' |awk '{print $2}')
# apt-get -y purge $(dpkg --list |egrep 'linux-image-[0-9]' |awk '{print $3,$2}' |sort -nr |tail -n +2 |grep -v $(uname -r) |awk '{ print $2}')
apt-get -y clean
rm -f /etc/apt/apt.conf.d/proxy

# Remove history file
unset HISTFILE
rm ~/.bash_history /home/vagrant/.bash_history

rm -rf /tmp/*
rm -rf /home/vagrant/dshield/packer

if [[ ${PACKER_BUILDER_TYPE} =~ 'qemu' ]]; then
    fstrim -v /
else
    echo '==> Zeroing out empty area to save space in the final image'
    # Zero out the free space to save space in the final image.  Contiguous
    # zeroed space compresses down to nothing.
    dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
    rm -f /EMPTY
fi

# sync data to disk (fix packer)
sync
