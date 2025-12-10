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

echo "开始处理 TXT 文件..."

for filename in *.txt; do

    tmpfile=$(mktemp)

    # 删除第 1 行 + 去除所有 "
    sed '1d' "$filename" | sed 's/"//g' > "$tmpfile"

    mv "$tmpfile" "$filename"

    echo "已处理：$filename"
done

echo "TXT 处理完成"

# ============ 生成 ZIP ============

echo "开始压缩成 ZIP..."

cd ..

zip_name="txt_files.zip"

# 删除旧 ZIP（如果存在）
[ -f "$zip_name" ] && rm "$zip_name"

# 压缩整个 txt 目录中的所有 txt 文件
zip -j "$zip_name" txt/*.txt

echo "ZIP 生成完成：$zip_name"
