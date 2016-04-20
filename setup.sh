#! /bin/sh
#
# MailHog install as service script.

mkdir mh-temp
cd mh-temp
wget https://github.com/bmc/daemonize/archive/release-1.7.7.tar.gz
tar -zxvf release-1.7.7.tar.gz
cd daemonize-release-1.7.7/
./configure --prefix=/usr
make
make install
cd ..
mkdir /opt/mailhog
cd /opt/mailhog
wget https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64
mv MailHog_linux_amd64 mailhog
chmod +x mailhog
cd ..
wget https://github.com/ArtOfWP/mailhog-scripts/mailhog.sh
mv mailhog.sh mailhog
mv mailhog /etc/init.d/
cd ..
rm -R mh-temp