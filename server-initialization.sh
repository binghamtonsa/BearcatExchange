#!/bin/bash
if [ ! -f /home/ubuntu/custom.log ]
    then
        echo "Proccess began at " >> /home/ubuntu/custom.log
        date >> /home/ubuntu/custom.log
        exec >> /home/ubuntu/custom.log 2>&1
        add-apt-repository ppa:ondrej/php5-5.6
        apt-get update -y && apt-get dist-upgrade -y
        apt-get autoremove -y && apt-get autoclean -y
        apt-get install python-software-properties
        curl https://bootstrap.pypa.io/get-pip.py -O /home/ubuntu/
        python3.4 get-pip.py
        apt-get install ruby2.0 apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli php5-fpm php5-gd libssh2-php mysql-server php5-mysqlnd git unzip zip postfix php5-curl mailutils php5-json phpmyadmin -y
        php5enmod mcrypt
        pip3.4 install awscli
        cd /var/www/html/
        aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region us-east-1
        chmod +x ./install
        ./install auto
        service codedeploy-agent start
        service codedeploy-agent status
        chmod 777 /etc/apache2/sites-available/000-default.conf
        echo "

#Added by Nick
Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/sites-enabled/000-default.conf
        service apache2 restart
        mkdir /var/www/html/live
        rm /var/www/html/index.html

#        This must be done manually:
#        nano /etc/phpmyadmin/config.inc.php
#        --ADD LINES BELOW THE PMA CONFIG AREA AND FILL IN DETAILS--
#$i++;
#$cfg['Servers'][$i]['host']          = 'bearcat.cqfnkzrzji1p.us-east-1.rds.amazonaws.com';
#$cfg['Servers'][$i]['port']          = '3306';
#$cfg['Servers'][$i]['socket']        = '';
#$cfg['Servers'][$i]['connect_type']  = 'tcp';
#$cfg['Servers'][$i]['extension']     = 'mysql';
#$cfg['Servers'][$i]['compress']      = FALSE;
#$cfg['Servers'][$i]['auth_type']     = 'config';
#$cfg['Servers'][$i]['user']          = 'root';
#$cfg['Servers'][$i]['password']      = 'codebook';
fi
