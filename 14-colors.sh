#!/bin/bash 

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $userid -ne 0 ]
then 
    echo -e "$R You are not running with root user access $N"
    exit 1
else 
    echo -e "$G You are running with root user access $N"
fi 

VALIDATE()
{
    if [ $1 -eq 0 ]
    then 
        echo -e "$G $1 is installed successfully $N"
    else 
        echo -e "$R $1 not installed successfully $N"
        exit 1 
    fi
}

dnf list installed mysql 
if [ $? -ne 0 ]
then 
    echo -e "$R MySql is not there we are going to install!!!"
    dnf install mysql -y 
    VALIDATE $? "MySql"
else 
    echo -e "$Y MySql is already there we are skipping $N"
fi 

dnf list installed nginx 
if [ $? -ne 0 ]
then 
    echo -e "$R Nginx is not there we are going to install $N"
    dnf install nginx -y
    VALIDATE $? "Nginx"
else 
    echo -e "$Y Nginx is already there we are skipping $N"
fi 

dnf list installed ansible
if [ $? -ne 0 ]
then 
    echo -e "$R ansible is not here we are going to install!!! $N"
    dnf install ansible -y
    VALIDATE $? "ansible"
else 
    echo -e "$Y ansible is already there we are skipping $N"
fi