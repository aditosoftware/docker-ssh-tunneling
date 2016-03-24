# docker-ssh-tunneling


## Environment Variables


#### `SSH_PERMITOPEN=`

hosts and ports you can connect from this container
example: SSH_PERMITOPEN=database:80 mysql:* redmine:80 redmine:443


#### `SSH_USER=`

name of the user to connect via ssh


#### `SSH_PASSWORD=`

password of the user to connect via ssh


## Connect at Windows

Thanks to [Simon Tathams](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) tool [plink](https://the.earth.li/~sgtatham/putty/latest/x86/plink.exe) you can easily mount remote ports on local ports.


This Batch-File makes it easy to connect.
You only have to fill in the variables and replace the "-L"-Parameters with your specific requirement.
```console
@echo off

set SERVER_ADR=
set SERVER_PORT=
set SERVER_USER=
set SERVER_PW=

echo ##############################################
echo Its running as long as this cmd-window is open
echo ##############################################
echo.

plink.exe ^
-v ^
-C ^
-N ^
-l %SERVER_USER% ^
-pw %SERVER_PW% ^
-P %SERVER_PORT% ^
-L 443:webserver:443 ^
-L 80:webserver:80 ^
-L 3306:mysql:3306 ^
%SERVER_ADR%
```