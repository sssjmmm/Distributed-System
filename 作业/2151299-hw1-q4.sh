#!/bin/bash

# 首先在本机创建一个倒计时脚本（文件名字为:2151299-hw1-q4.sh），要求有一个输
# 入参数（即倒计时所需的秒数，比如60或者100等），该脚本每隔10秒输出当前剩下的秒数，
# 直至倒计时结束。要求通过scp将该脚本文件上传到队友的远端服务器，然后通过ssh在该服
# 务器远端执行该脚本并将结果追到本地日志文件（文件名字为:2151299-hw1-q4.log）


# 检查输入参数是否提供
if [ $# -ne 1 ]; then
    echo "请输入倒计时的秒数作为参数。"
    exit 1
fi

# 将输入参数赋给变量
countdown_seconds=$1

# 每隔10秒输出当前剩下的秒数
while [ $countdown_seconds -gt 0 ]; do
    if [ $(( ($1 - $countdown_seconds) % 10)) -eq 0 ]; then
        echo "剩余秒数：$countdown_seconds"
        echo "剩余秒数：$countdown_seconds" >&2
    fi
    sleep 1
    countdown_seconds=$((countdown_seconds-1))
done

echo "倒计时结束。"

# 将脚本上传到远程服务器
# scp 2151299-hw1-q4.sh sjm@100.80.67.59:~/2151299-hw1-q4.sh

# 远程执行脚本并将结果追加到本地日志文件
# ssh sjm@100.80.67.59 "./2151299-hw1-q4.sh 60" >> 2151299-hw1-q4.log
