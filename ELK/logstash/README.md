Logstash是如何工作的
Logstash事件处理管道有三个阶段：input →filters→outputs。Input获取数据，filter处理这些数据，然后outputs将处理过的数据送到你需要的任何地方。Inputs和outputs支持编码器，以便你可以在数据输入或输出的时候进行编码或解码而不必使用一个单独的过滤器。

Inputs
你得使用Inputs将数据交给Logstash。下面是几个最常用的Inputs：

file：从文件系统上的一个文件进行读取，其工作原理有些类似UNIX的tail -0F命令
syslog：监听来自514端口的syslog消息，并将其转换为RFC3164格式
redis：从redis服务器读取。可以是redis频道或者redis列表。在一个集中部署的Logstash中，redis也用作中间件用来将传入的消息排队。（这段的意思应该是，redis可以用作消息队列将消息传递给Logstash或者作为数据源直接将数据传递给Logstash。原文：reads from a redis server, using both redis channels and redis lists. Redis is often used as a "broker" in a centralized Logstash installation, which queues Logstash events from remote Logstash "shippers".）
beats：处理由Beats发送过来的事件。
关于更多可用的inputs的信息，查看：Input Plugins

Filters
Filters在Logstash管道中是一个中间件的角色。你可以对符合某些条件的事件结合filters和附加条件对其进行处理，下面是一些比较实用的filters（原文：Filters are intermediary processing devices in the Logstash pipeline. You can combine filters with conditionals to perform an action on an event if it meets certain criteria. Some useful filters include:）：

grok：解析和构造文本。Grok是你将非结构化数据转换成高质量的结构化数据的最佳选择。Logstash集成了超过120条匹配规则，很大程度上你会找到一个你需要的。
mutate：对事件字段做常用的转换，比如：重命名、移动、替换或者修改某些字段。
drop：彻底丢弃某个事件，如debug事件。
clone：创建一个时间的副本，可能增加或移除字段。（直译。原文：make a copy of an event, possibly adding or removing fields.）
geoip：从IP地址添加物理地址信息（可以在Kibana创建很棒的图表。）
更多关于Filter Plugins的信息，查看Filter Plugins。

Outputs
Outputs是Logstash管道的最后阶段。一个事件可以通过Outputs发送到多个目的地。当这些过程一旦完成，这个事件的处理也就完全结束了。下面是一些使用的Outputs：

Elasticsearch：将事件数据发送到Elasticsearch。如果你计划以高效、方便和容易查询的格式存储数据，你应该选择Elasticsearch。是的，我们就是这么真实 : )

file：把事件数据写到磁盘上的文件

graphite：将数据发送给graphite，这是一个流行的开源存储和图形化工具。http://graphite.readthedocs.io/en/latest/

statsd：将数据发送给是statsd，statsd是一个“像计数器和计时器一样监听统计数据，并通过UDP发送聚合信息到一个或多个可插入后端”的服务。如果你准备好使用statsd，这个会对你有帮助。

注:引号部分为官方statsd官方介绍信息。有人翻译为“通过 UDP 或者 TCP 方式侦听各种统计信息，包括计数器和定时器，并发送聚合信息到后端服务”，不过我更倾向于我自己的翻译，因为statsd是一个监控软件，其应该是想表达像计时器一样统计信息而不是统计像计时器和定时器这样的数据。附上原文：listens for statistics, like counters and timers, sent over UDP and sends aggregates to one or more pluggable backend services

更多关于Outputs的信息，查看Output Plugins

编码器Codecs
编码器是最基本的流过滤器，可以替代部分input和output。编码器可以让你更容易的的从序列化数据中分离传送你的信息（原文：Codecs enable you to easily separate the transport of your messages from the serialization process）。流行的编码器包括json，msgpack，和plain（text）。

json：将数据编码或解码为JSON格式。
multiline：将类似java异常和java栈之类的多行文本事件合并成单个事件。
更多关于codecs的信息，查看Codec Plugins。

[来源](https://www.kancloud.cn/aiyinsi-tan/logstash/849585)