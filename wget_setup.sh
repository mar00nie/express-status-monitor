 #!/usr/bin/bash

# Download and install wget-1.17
apt-get install -y gnutls-dev
apt-get install -y build-essential
apt-get install -y pkg-config
apt-get install -y curl
curl -O https://ftp.gnu.org/gnu/wget/wget-1.17.tar.gz
tar xvzf wget-1.17.tar.gz
rm wget-1.17.tar.gz
cd wget-1.17
./configure
make
make install
make clean
ln -s wget-1.17 wget
cd ..
wget --version
