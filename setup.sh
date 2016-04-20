#! /bin/sh
#
# MailHog install as service script.
## Detect the user who launched the script
usr=$(env | grep SUDO_USER | cut -d= -f 2)

## Exit if the script was not launched by root or through sudo
if [ -z $usr ] && [ $USER <> "root" ]
then
    echo "The script needs to run as root" && exit 1
fi
echo "Creating temp dir"
mkdir mh-temp
cd mh-temp
temp_path = $(PWD)
wget https://github.com/bmc/daemonize/archive/release-1.7.7.tar.gz
tar -zxvf release-1.7.7.tar.gz
cd daemonize-release-1.7.7/
./configure --prefix=/usr
make
make install
cd ..
mkdir -p /opt/mailhog
cd /opt/mailhog
wget https://github.com/mailhog/MailHog/releases/download/v0.2.0/MailHog_linux_amd64
mv MailHog_linux_amd64 mailhog
chmod +x mailhog
cd $temp_path
wget https://raw.githubusercontent.com/ArtOfWP/mailhog-scripts/master/mailhog.sh
mv mailhog.sh mailhog
chmod +x mailhog
mv mailhog /etc/init.d/
rm -R mh-temp
