 #!/usr/bin/bash

# Download and install Nodejs with npm
wget https://nodejs.org/dist/v12.8.1/node-v12.8.1-linux-x64.tar.gz
tar -C /usr/local --strip-components 1 -xzf node-v12.8.1-linux-x64.tar.gz
rm node-v12.8.1-linux-x64.tar.gz
node -v
npm -v

# Install node modules and run tests
npm install
npm audit fix
npm test

# Publish new version of example app
cd examples
npm install
npm install -g npm-cli-login
npm-cli-login -u mar00nie -p dissertationproject -e yangyangteng@hotmail.com
npm whoami
npm publish
