#!/bin/bash
# 等待tracker启动成功
if [ "$FASTDFS_SERVER_NAME" == "storage" ]
   then
     ./wait-for-it.sh tracker01:8888
     ./wait-for-it.sh tracker02:8888
fi
/usr/bin/fdfs_${FASTDFS_SERVER_NAME}d /etc/fdfs/${FASTDFS_SERVER_NAME}.conf
# 将nginx挂到前台运行
/usr/local/nginx/sbin/nginx -g "daemon off;"
