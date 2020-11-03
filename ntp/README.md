# 安装ntp服务器端
yum install  ntp

# 配置一个以本机为时间服务器
```
# cat /etc/ntp.conf

driftfile /var/lib/ntp/driftfile

restrict 127.0.0.1
restrict ::1

server 127.127.1.0   #注释掉其他server，修改为本机


```
# 启动服务端
systemctl start ntpd

# 查看同步情况
看到LOCAL的一行，就是已经把自己配成自己的时钟源，当然也可以做为别人的时钟源。
要等待几分钟，待前面加上*或+号后 就是已经同步成功了
```
# ntpq -p
```

