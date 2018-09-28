# 针对yum安装的zabbix-agent配置自带的mysql监控

# 关闭selinux，必须/一定/肯定要关掉

# 给zabbix用户授权
mysql -uroot -p`cat /data/save/mysql_root` -S /tmp/mysql1.sock -e"GRANT USAGE ON *.* TO 'zabbix'@'localhost' IDENTIFIED BY 'zabbix'";


# 配置mysql账号密码和socket
vim /etc/zabbix/.my.cnf  
[mysql]  
host=localhost  
user=zabbix  
password=zabbix  
socket=/tmp/mysql.sock  
[mysqladmin]  
host=localhost  
user=zabbix  
password=zabbix  
socket=/tmp/mysql.sock 



# 调整监控项
vim /etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf

# 1、调整HOME
# 2、调整mysql和mysqladmin的路径为绝对路径

# For all the following commands HOME should be set to the directory that has .my.cnf file with password information.

# Flexible parameter to grab global variables. On the frontend side, use keys like mysql.status[Com_insert].
# Key syntax is mysql.status[variable].
UserParameter=mysql.status[*],echo "show global status where Variable_name='$1';" | HOME=/etc/zabbix /usr/local/mysql/bin/mysql -N | awk '{print $$2}'

# Flexible parameter to determine database or table size. On the frontend side, use keys like mysql.size[zabbix,history,data].
# Key syntax is mysql.size[<database>,<table>,<type>].
# Database may be a database name or "all". Default is "all".
# Table may be a table name or "all". Default is "all".
# Type may be "data", "index", "free" or "both". Both is a sum of data and index. Default is "both".
# Database is mandatory if a table is specified. Type may be specified always.
# Returns value in bytes.
# 'sum' on data_length or index_length alone needed when we are getting this information for whole database instead of a single table
UserParameter=mysql.size[*],echo "select sum($(case "$3" in both|"") echo "data_length+index_length";; data|index) echo "$3_length";; free) echo "data_free";; esac)) from information_schema.tables$([[ "$1" = "all" || ! "$1" ]] || echo " where table_schema='$1'")$([[ "$2" = "all" || ! "$2" ]] || echo "and table_name='$2'");" | HOME=/etc/zabbix /usr/local/mysql/bin/mysql -N

UserParameter=mysql.ping,HOME=/etc/zabbix /usr/local/mysql/bin/mysqladmin ping | grep -c alive
UserParameter=mysql.version,/usr/local/mysql/bin/mysql -V
You have new mail in /var/spool/mail/root

# 重启zabbix-agent
/etc/init.d/zabbix-agent restart
