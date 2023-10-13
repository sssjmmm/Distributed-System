#!/bin/bash

my_id="2151299"

#计算1-100的质数和
sum=0

for((i=2;i<=100;i++));do
    prime=1
    for((j=2;j*j<=i;j++));do
        if((i%j==0));then
            prime=0
            break
        fi
    done

    if((prime==1));then
        sum=$((sum+i))
    fi
done

# 结果输出到终端
echo "sum: $sum"

# 结果输出到日志文件
log_file="${my_id}-hw1-q1.log"
echo "sum: $sum" > "$log_file"