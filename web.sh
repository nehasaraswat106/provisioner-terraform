#!/bin/bash
sudo yum install -y wget unzip httpd

sudo systemctl start httpd 
sudo systemctl enable httpd 

sudo wget -q https://www.tooplate.com/zip-templates/2131_wedding_lite.zip
sudo unzip -o 2131_wedding_lite.zip

sudo cp -r 2131_wedding_lite/* /var/www/html/ 

sudo systemctl restart httpd