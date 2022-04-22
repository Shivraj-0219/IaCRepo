#!/bin/bash
sudo yum -y update
sudo yum install -y git
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo git clone https://github.com/Shivraj-0219/AngularCalculator.git /var/www/html