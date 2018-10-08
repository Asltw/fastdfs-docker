#!/bin/bash
/usr/bin/fdfs_${FASTDFS_SERVER_NAME}d /etc/fdfs/${FASTDFS_SERVER_NAME}.conf
if [ $? -ne 0 ]
  then
    exit 0
fi
/usr/local/nginx/sbin/nginx
if [ $? -ne 0 ]
  then
    exit 1
fi

if [ "z$FASTDFS_SERVER_NAME" == "ztracker" ]
  then
    FASTDFS_BASE_PATH=/fastdfs/tracker
  else
    FASTDFS_BASE_PATH=/fastdfs/storage
fi
PID="${FASTDFS_BASE_PATH}/data/fdfs_${FASTDFS_SERVER_NAME}d.pid"
while [ ! -e "$PID" ]
do
  sleep 1s
done
