#!/bin/bash

directory="./txt"

# 判断目录是否存在
if [ ! -d "$directory" ]; then
    echo "错误：目录 '$directory' 不存在"
    exit 1
fi

# 进入目录（避免 *.txt 变成字面量）
cd "$directory" || exit 1

shopt -s nullglob   # 让 *.txt 没有匹配时变成空，不报错

for filename in *.txt; do

    tmpfile=$(mktemp)

    # Mac 的 tail 使用更兼容的写法：tail -n +2 -> tail -n +2
    # 但为了兼容性，改用 `sed '1d'` 删除第一行
    sed '1d' "$filename" | sed 's/"//g' > "$tmpfile"

    mv "$tmpfile" "$filename"

    echo "已处理：$filename"
done

echo "处理完成"
