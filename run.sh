#!/bin/sh
echo "Hello, this is a script running in Docker!"

if [ -z "$SMB_USER" ] || [ -z "$SMB_PASS" ] || [ -z "$SMB_SERVER" ] || [ -z "$SMB_SHARE" ]; then
  echo "One or more required environment variables are missing:"
  echo "SMB_USER, SMB_PASS, SMB_SERVER, SMB_SHARE"
  exit 1
fi

echo "Mount the qnap using environment variables"
mkdir /qnap
mount -t cifs //$SMB_SERVER/$SMB_SHARE /qnap -o username=$SMB_USER,password=$SMB_PASS,vers=3.0,iocharset=utf8,file_mode=0777,dir_mode=0777

if [ $? -eq 0 ]; then
  echo "Mounted qnap successfully."
else
  echo "Failed to mount qnap."
  exit 1
fi

/init
