#!/bin/bash
echo "---------start-------------"
apt -y update
apt -y install apache2
apt -y install openjdk-11-jre
s=$(wget -qO- eth0.me)
echo "<html><body><br><br><br><center><a href="http://$s:1234">Jenkins</a></center><br><br><br><center></center></body></html>" > /var/www/html/index.html
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt -y update
apt -y install jenkins
sed -i "s/HTTP_PORT=8080/HTTP_PORT=1234/g" /etc/default/jenkins
service jenkins restart
echo "---------end-------------"
