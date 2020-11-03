#修改日期,将日期设定成2009年5月7日
date -s 2009-05-07
 
#修改时间,将时间设定成下午8点18分0秒
date -s 20:18:00

修改时区： 
找到相应的时区文件 /usr/share/zoneinfo/Asia/Shanghai替换当前的/etc/localtime。 
修改/etc/sysconfig/clock文件的内容为： 
ZONE=”Asia/Shanghai” 
UTC=false 
ARC=false 