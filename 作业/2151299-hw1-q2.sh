#!/bin/bash

# 通过一个脚本文件（文件名字为:2151299-hw1-q2.sh）生成一个日志文件（文件名字
# 为:2151299-hw1-q2.log），首先熟悉uptime，执行该命令将会显示出系统的当前时间、上线时
# 间、当前的用户数量以及过去1、5、15分钟内的系统负载。一个示例uptime的输出结果为（为
# 确保过去1、5、15分钟内的系统负载为非零值，可在系统打开视频文件播放或者操作其他文
# 件）
# 00:32:11 up 20 days, 23:07, 1 user, load average: 0.00, 0.00, 0.00
# 要求每隔 10 秒钟的输出 uptime 命令结果，按行将输出结果追加到该日志文件，确保
# uptime 执行不少于 15 次，然后结束该日志文件的追加。


# 设置日志文件名并定义计数器count
log_file="2151299-hw1-q2.log"
count=0

# 每隔10秒执行uptime命令，追加到日志文件
while [ $count -lt 15 ]; do
  # 执行uptime命令并将结果赋给变量uptime_result
  uptime_result=$(uptime)
  
  # 输出变量的值到终端
  echo "$uptime_result"
  # 追加到日志文件
  echo "$uptime_result" >> "$log_file"
  
  # 计数器自增
  count=$((count + 1))
  
  # 等待10秒
  sleep 10
done

echo "脚本执行完毕。"