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
        <img src='https://dev-mayuresh-s3.s3.us-east-1.amazonaws.com/Images/sting.jpg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjENj%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIFsj12e73kk%2FbryTKFzLwbjcfA6KNOIZ7H694aGfn8CwAiB2VxqXimb7mjlZRDms7Hn0ouZiD2cky1fqa5uUlPwZHir3AgggEAAaDDQzOTczMzk2MDgxNCIMO%2BMDvBDLa2vs4X4WKtQCSTJvfT7%2F%2FX%2FrT1k%2FuoMl%2BqCHMFg6LDY%2F4EQWM2ESiFv1pMGHi46A1fP60gpjpXMp0v2LTZYfPHWWDLIF8GpbM51%2Fg3y%2FtjEfgoEtgmgmKk3cuARwMStlYuRysQOD2d9qg0vJgTqAD%2BX1pKss1OOoujH1%2FUd9RKTS58%2Bl%2BPQeBZ0Q%2BcVITzwBiqBHnK%2FocYvsrgCoFmifwd%2F0cLG2Y6Fj%2FHHE4hrG%2BhKMXtAc3MSOyPtGHGGCs5B7YOIu8YRNVfbhNtJbnxt6YlP16AR%2BB69r4Vcyn31A92J93sZKGLEcMo9kR6cPh1kA71asF33HmDb8qAaaeUXVBE8%2Bs9x%2BPUiBTWGfF0xcXgypmfUyAxE9%2F68cHgy0sUyXhCCFPqWAskJO5BlOdtp3meM0EWlMAewu9D4WTP%2BD2%2FdIy4UAL3L5xiIfNH1kPPWxY7FOkcQDe27tV54%2FNzCQ84uxBjqIAjWftAENbIb%2BSUvYQ9NGEf50lWW9To2s9jJTV8E6binwX9LTR8guZ%2BDMzcsvtD3oDzMigJj%2FisuGpHoMpAXK%2Fwslkah%2BlgZO%2FYGgI3RXBXvIhWj5nucAqGXnL6VIKqYY9Fwgpe2S7lrJfKJ1ZIh%2BdelGPN%2FE5fWLb%2FD20dwIDjQaTA0sRn9yEyCbwaGDq%2Ffp0RsWPhyXzpTo1DMPJk3Abeg3UFjWDneUoKIrnlWxSVVG0i1AxpA4wLVeJ4H%2BDFrimqxXKRbdXal9%2FHpANnj49FhviiFQkM5H6BtL%2F3vkWqZ8WVMz7QaZatONYlUWRxYr1IJrbbdhM7Z8Nxjnn2O5bgHR3aFTMLPSRg%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240419T232836Z&X-Amz-SignedHeaders=host&X-Amz-Expires=1800&X-Amz-Credential=ASIAWMYRPYBXACYKNSUW%2F20240419%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=1c9b1f7de0037539d11c26143483bc2e92711914e9f6096d73b2813c10b77303' alt="Image from S3" width="100" height="100">
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