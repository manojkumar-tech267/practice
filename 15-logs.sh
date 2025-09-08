#!/bin/bash 

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Logs_Folder="/var/log/shellscript-logs"
File_Name=$(echo $0 | cut -d "." -f1)
Log_File=$Logs_Folder/$File_Name.sh

if [ $userid -ne 0 ]
then 
    echo "You are not a root user run with root access"| tee -a $Log_File
    exit 1 
else 
    echo "You are a root user" | tee -a $Log_File
fi 

VALIDATE()
{
    if [ $1 -eq 0 ]
    then 
        echo "$2 installed successfully" | tee -a $Log_File
    else 
        echo "$2 not installed successfully" | tee -a $Log_File
        exit 1
}

dnf list installed mysql &>> $Log_File
if [ $? -ne 0 ]
then 
    echo "Mysql is not there we are going to install"
    dnf install mysql -y &>> $Log_File
    VALIDATE $? "MySql" | tee -a $Log_File
else 
    echo "MySql is already there we are skipping"

dnf list installed nginx &>> $Log_File
if [ $? -ne 0 ]
then
    echo "Nginx is not there we are going to install"
    dnf install nginx -y &>> $Log_File
    VALIDATE $? "Nginx" 
else 
    echo "Nginx is already there we are skipping" | tee -a $Log_File
fi