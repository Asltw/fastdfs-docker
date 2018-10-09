# fastdfs-docker
create a fastdfs cluster by docker

创建时间：2018/10/07

> 注意：镜像都是通过源码制作

##### 按照以下网络部署
![image](http://pceh5403k.bkt.clouddn.com/fastdf-docker%E9%9B%86%E7%BE%A4.jpg)
##### 在当前用户下拉取代码
```sh
git clone https://github.com/Asltw/fastdfs-docker.git
cd ~/fastdfs-docker/Dockerfile/
```
##### 创建tracker镜像
```sh
docker build -t sh/tracker:0.0.1 -f Dockerfile_tracker .
```
##### 创建storage镜像
```sh
docker build -t sh/storage:0.0.1 -f Dockerfile_storage .
```
##### 创建桥接网络，设定固定IP段
```sh
docker network create --subnet=172.18.0.0/16 fastdfs-docker
```
> 创建好镜像之后，可以通过docker-compose直接启动，也可以通过以下命令依次启动容器

##### 创建trakcer01容器
```sh
docker run -d -v ~/fastdfs-docker/tracker_1/tracker.conf:/etc/fdfs/tracker.conf -v ~/fastdfs-docker/tracker_1/nginx.conf:/usr/local/nginx/conf/nginx.conf --network  fastdfs-docker --ip 172.18.0.2 -e FASTDFS_SERVER_NAME=tracker --name tracker01 -p 22122:22122 -p 8888:8888 sh/tracker:0.0.1
```
##### 创建tacker02容器
```sh
docker run -d -v ~/fastdfs-docker/tracker_2/tracker.conf:/etc/fdfs/tracker.conf -v ~/fastdfs-docker/tracker_2/nginx.conf:/usr/local/nginx/conf/nginx.conf --network  fastdfs-docker --ip 172.18.0.3 -e FASTDFS_SERVER_NAME=tracker --name tracker02 -p 22123:22122 -p 8889:8888 sh/tracker:0.0.1
```
##### 创建storage1_group1容器
```sh
docker run -d -v ~/fastdfs-docker/storage1_group1/storage.conf:/etc/fdfs/storage.conf -v ~/fastdfs-docker/storage1_group1/nginx.conf:/usr/local/nginx/conf/nginx.conf -v ~/fastdfs-docker/storage1_group1/mod_fastdfs.conf:/etc/fdfs/mod_fastdfs.conf --network fastdfs-docker --ip 172.18.0.4 -e FASTDFS_SERVER_NAME=storage --name storage1_group1 sh/storage:0.0.1 "/bin/bash -c ln -s /fastdfs/storage/data /fastdfs/storage/data/M00;\ ll /fastdfs/storage/data/M00"
```
##### 创建storage2_group1容器
```sh
docker run -d -v ~/fastdfs-docker/storage2_group1/storage.conf:/etc/fdfs/storage.conf -v ~/fastdfs-docker/storage2_group1/nginx.conf:/usr/local/nginx/conf/nginx.conf -v ~/fastdfs-docker/storage2_group1/mod_fastdfs.conf:/etc/fdfs/mod_fastdfs.conf --network fastdfs-docker --ip 172.18.0.5 -e FASTDFS_SERVER_NAME=storage --name storage2_group1 sh/storage:0.0.1 "/bin/bash -c ln -s /fastdfs/storage/data /fastdfs/storage/data/M00;\ ll /fastdfs/storage/data/M00"
```
##### 创建storage3_group2容器
```sh
docker run -d -v ~/fastdfs-docker/storage3_group2/storage.conf:/etc/fdfs/storage.conf -v ~/fastdfs-docker/storage3_group2/nginx.conf:/usr/local/nginx/conf/nginx.conf -v ~/fastdfs-docker/storage3_group2/mod_fastdfs.conf:/etc/fdfs/mod_fastdfs.conf --network fastdfs-docker --ip 172.18.0.6 -e FASTDFS_SERVER_NAME=storage --name storage3_group2 -p sh/storage:0.0.1 "/bin/bash -c ln -s /fastdfs/storage/data /fastdfs/storage/data/M00;\ ll /fastdfs/storage/data/M00"
```
##### 创建storage4_group2容器
```sh
docker run -d -v ~/fastdfs-docker/storage4_group2/storage.conf:/etc/fdfs/storage.conf -v ~/fastdfs-docker/storage4_group2/nginx.conf:/usr/local/nginx/conf/nginx.conf -v ~/fastdfs-docker/storage4_group2/mod_fastdfs.conf:/etc/fdfs/mod_fastdfs.conf --network fastdfs-docker --ip 172.18.0.7 -e FASTDFS_SERVER_NAME=storage --name storage4_group2 sh/storage:0.0.1 "/bin/bash -c ln -s /fastdfs/storage/data /fastdfs/storage/data/M00;\ ll /fastdfs/storage/data/M00"
```
### [fastdfs集群](https://github.com/Asltw/personal-notes/blob/master/fastdfs/FastDFS%E9%9B%86%E7%BE%A4%E6%90%AD%E5%BB%BA%28ubuntu%29.md)

### 遇到的问题
> 运行容器后，通过docker ps 查看发现容器马上退出。Docker容器若需后台运行，必须有一个前台进程。

```sh
# 将nginx挂到前台运行
/usr/local/nginx/sbin/nginx -g "daemon off;"
```
