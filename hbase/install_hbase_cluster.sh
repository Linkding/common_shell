#!/bin/bash
# -------------------------------------------------------------------------------
# Script_name  : install_hbase_cluster.sh
# Revision     : 1.0
# Date         : 2020-03-30 15:59:11
# Author       : Linkding
# Description  : 
# How to use   : 
# -------------------------------------------------------------------------------

tar_name=
root_dir=/opt/backend    #安装目录
masterIP=172.16.35.10
# slave 根据实际情况添加
slave_num=2  # 必填，有多少个slave写多少数字
slave1=172.16.35.11
slave2=172.16.35.12



# 打印日志
log(){
    echo -e "\033[32m $1 \033[0m"
}

#错误处理函数
error_exit(){
    echo -e "\033[31m ERROR: $1 \033[0m"
    exit 1
}

# create_dir
for ((i = 1;i<= ${slave_num};i++))
do
tmp=slave${i}
eval server=$(echo \$$tmp)
ssh $server "mkdir $root_dir"
done

#解压
tar zxvf ${tar_name} -C $root_dir  && log "解压完毕" || "解压失败，请检查！"

# 配置
## regionservers
for ((i = 1;i<= ${slave_num};i++))
do
tmp=slave${i}
eval server=$(echo \$$tmp)
echo $server >> $root_dir/hbase-2.1.5/conf/regionservers && log "添加 $server 到slave列表" || error_exit "添加 $server 到slave失败"
done

## hbase-env.sh
java_home=`echo $JAVA_HOME`
echo "export JAVA_HOME="$java_home >> $root_dir/hbase-2.1.5/conf/hbase-env.sh && echo "HBASE_MANAGES_ZK=false" >>$root_dir/hbase-2.1.5/conf/hbase-env.sh && log "变量同步hbase-env成功" || error_exit "变量同步hbase-env失败"


## hbase-site.xml
/bin/cp ./hbase-site.xml $root_dir/hbase-2.1.5/conf/ && log "覆盖hbase-site成功" || error_exit "覆盖hbase-sit失败""

# 同步配置到各个slave
for ((i = 1;i<= ${slave_num};i++))
do
tmp=slave${i}
eval server=$(echo \$$tmp)
scp -r $root_dir/hbase-2.1.5  $server:/opt/backend && log "已同步hbase目录到$server" || error_exit "同步到$server失败"
sleep 2
done



