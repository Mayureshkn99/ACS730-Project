#!/bin/bash
sudo yum -y update
sudo yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACS Group Project</title>
</head>
<body>
    <center>
        <br>
        <hr>
        <h1>
            WELCOME TO <span style=color:#FF0000;>GROUP 5</span> WEB SERVER DEPLOYMENT IN AWS!
        </h1>
        <hr>
        <h1>
            This is a Dev environment provisioned by the team<br>
            <br>
            <strong style=color:#FF0000;>
                Trystan<br>
                Mayuresh<br>
                Jainam<br>
            </strong>
            <br>
            ACS 730
        </h1>
        <h3>
            My private IP address is <font color="red">$myip</font>!</p>
        </h3>
    </center>
</body>
</html>"  >  /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd