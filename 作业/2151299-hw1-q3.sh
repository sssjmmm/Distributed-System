#!/bin/bash

# 通过一个脚本文件（文件名字为:2151299-hw1-q3.sh），将题目2的日志文件“2151299-
# hw1-q2.log“名字作为一个参数给该脚本，依次输出如下4行内容，并将该4行内容输出到一
# 个日志文件(文件名字为:2151299-hw1-q3.log)：
# a) 文件“2151299-hw1-q2.log“的总行数；
# b) 文件“2151299-hw1-q2.log“的总字符数；
# c) 统计第一行和最后一行输出结果的时间戳之间的时间差；
# d) 统计最后三列（即过去1、5、15分钟内的系统负载）对应平均值，并通过空格键将该
# 三列平均值隔离。

# 首先检查是否提供2151299-hw1-q2.log文件名作为参数
if [ $# -ne 1 ]; then # $#表示当前脚本的参数个数（不包括程序本身）
    echo "请提供2151299-hw1-q2.log作为参数"
    exit 1
fi

# 获取输入的日志文件名
log_file="$1"

# 检查日志文件是否存在
if [ ! -f "$log_file" ]; then
    echo "日志文件 $log_file 不存在"
    exit 1
fi

# 输出a) 文件“2151299-hw1-q2.log“的总行数
total_lines=$(wc -l < "$log_file")
echo "a) 文件“$log_file“的总行数：$total_lines"
echo "a) 文件“$log_file“的总行数：$total_lines" > 2151299-hw1-q3.log

# 输出b) 文件“2151299-hw1-q2.log“的总字符数
total_chars=$(wc -m < "$log_file")
echo "b) 文件“$log_file“的总字符数：$total_chars"
echo "b) 文件“$log_file“的总字符数：$total_chars" >> 2151299-hw1-q3.log

# 提取第一行和最后一行的时间戳
first_timestamp=$(head -n 1 "$log_file" | awk '{print $1}')
last_timestamp=$(tail -n 1 "$log_file" | awk '{print $1}')
# echo $first_timestamp $last_timestamp
# 计算时间差
time_difference=$(( $(date -d "$last_timestamp" +%s) - $(date -d "$first_timestamp" +%s) ))
echo "c) 第一行和最后一行输出结果的时间戳之间的时间差：$time_difference 秒"
echo "c) 第一行和最后一行输出结果的时间戳之间的时间差：$time_difference 秒" >> 2151299-hw1-q3.log

# 提取最后三列（过去1、5、15分钟内的系统负载），计算平均值
# 写法一：利用 -F将[, ]作为分隔符
# awk -F '[, ]' '{print $(NF-4), $(NF-2), $NF}' "$log_file"
# average_load=$(awk -F '[, ]' '{sum1+=$(NF-4); sum5+=$(NF-2); sum15+=$NF} END {print sum1/NR, sum5/NR, sum15/NR}' "$log_file")

# 写法二：利用gsub函数将","替换为" "
# awk '{ gsub(",", " "); print $(NF-2), $(NF-1), $NF }' "$log_file"
average_load=$(awk '{ gsub(",", " "); sum1+=$(NF-2); sum5+=$(NF-1); sum15+=$NF} END {print sum1/NR, sum5/NR, sum15/NR}' "$log_file")
echo "d) 最后三列（过去1、5、15分钟内的系统负载）对应平均值：$average_load"
echo "d) 最后三列（过去1、5、15分钟内的系统负载）对应平均值：$average_load" >> 2151299-hw1-q3.log

echo "任务完成，结果已保存到2151299-hw1-q3.log文件中。"
