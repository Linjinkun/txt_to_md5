import os


def process_txt_files(directory):
    # 检查目录是否存在
    if not os.path.isdir(directory):
        print(f"错误：目录 '{directory}' 不存在")
        return

    # 遍历目录中的所有文件
    for filename in os.listdir(directory):
        # 只处理.txt文件
        if filename.endswith('.txt'):
            file_path = os.path.join(directory, filename)

            try:
                # 读取文件内容
                with open(file_path, 'r', encoding='utf-8') as file:
                    lines = file.readlines()

                # 如果文件至少有一行，删除第一行
                if len(lines) >= 1:
                    lines = lines[1:]

                # 处理剩余行，去除所有双引号
                processed_lines = [line.replace('"', '') for line in lines]

                # 写回处理后的内容
                with open(file_path, 'w', encoding='utf-8') as file:
                    file.writelines(processed_lines)

                print(f"已处理：{filename}")

            except Exception as e:
                print(f"处理 {filename} 时出错：{str(e)}")


if __name__ == "__main__":
    # 请替换为你的目标目录路径
    target_directory = "./txt"

    # 调用函数处理文件
    process_txt_files(target_directory)
    print("处理完成")
