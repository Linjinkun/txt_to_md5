#!/bin/bash

directory="./txt"

# 判断目录是否存在
if [ ! -d "$directory" ]; then
    echo "错误：目录 '$directory' 不存在"
    exit 1
fi

# 遍历目录中的所有 txt 文件
for filepath in "$directory"/*.txt; do
    # 如果没有匹配的文件，则跳过
    [ -e "$filepath" ] || continue

    filename=$(basename "$filepath")

    # 删除第一行 + 去除所有双引号
    # 使用临时文件确保安全写入
    tmpfile=$(mktemp)

    # tail -n +2 从第二行开始输出
    tail -n +2 "$filepath" | sed 's/"//g' > "$tmpfile"

    # 覆盖回原文件
    mv "$tmpfile" "$filepath"

    echo "已处理：$filename"
done

echo "处理完成"
