#!/bin/bash 

id=$(id -u)

if [ $id -eq 0 ]
then 
    echo "User is a root user"
else 
    echo "Please run with root access"
    exit 1
fi

VALIDATE ()
{
    if [ $1 -eq 0 ]
    then 
        echo "$2 is successfully installed"
    else 
        echo "$2 is not successfully installed"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then 
    dnf install mysql -y
    VALIDATE $? "Mysql"
else 
    echo "My Sql is already installed we are skipping!!!"
fi