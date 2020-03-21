#!/bin/bash
#authores : ahmad maqboul 
#project for backup remotly and on th same drive 
#date of start in project 17-4-2019

#bacup on the same disk use rsync command
thefile="Documents/final1"
thebackup="Documents/backup"

rsync -avh  $thefile  $thebackup

#log file status 
z=`echo $?`
if [ $z -eq 0 ] 
then
logger -p local1.err "Backup successfully done"
#check the error on the same host , check file exist 
else 

#check the file you want to backup
if [ ! -d $thefile ]
then
logger -p local1.err "some thing wrong in backup , the file you want backup not exist  "

#check the file you want to backup to it
elif [ ! -d $thebackup ]
then
logger -p local1.err "some thing wrong in backup , the file you want to backup to not exist check the path for the file "
fi
fi


#bacup on the server use rsync command

tar -c Documents/final1 | nc 192.168.10.3 22 -w 10

#log file status for server 
z=`echo $?`

if [ $z -eq 0 ] 
then
logger -p local1.err "Backup successfully done on server "

#check the error on the server host , check file exist and conniction 
else 
#ping to the server 
ping -c 2 192.168.10.3

z=`echo $?`
if [ $z -eq 0  ] 
then 
logger -p local1.err "connection is up check the port and dir"
else 
logger -p local1.err "connection down check it"

fi
fi

#on server nc -lp 22 -w 10 > back.tar
#first of all ifconfig eth0 192.168.10.3 on server 
#first of all ifconfig eth0 192.168.10.2 on clint


#for log file send use this command 
#logger -p local1.err "hi my name is ahmad "
