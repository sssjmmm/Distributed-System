import json
import sys
import re
import os

def process_json_file(file_path):
    pattern = re.compile(r'\s\d+')
    with open(file_path, 'r') as file:
        json_data = json.load(file)

    matching_data = {name: values for name, values in json_data.items() if pattern.search(name)}
    # print(json.dumps(matching_data, indent=2))

    # 移除名字中包含空格和一串数字的条目
    for name in matching_data:
        del json_data[name]

    # 移除名字中的空格和数字，并将相同名字的值相加
    merged_data = {}
    for name, values in matching_data.items():
        cleaned_name = re.sub(r'\s\d+', '', name)
        if cleaned_name not in merged_data:
            merged_data[cleaned_name] = values
        else:
            # 相同名字的值相加
            for key, value in values.items():
                if key in merged_data[cleaned_name]:
                    merged_data[cleaned_name][key] += value
                else:
                    merged_data[cleaned_name][key] = value

    # 将合并的数据代替原来对应的数据字段
    for name in merged_data:
        json_data[name] = merged_data[name]

    # print(json.dumps(json_data, indent=2))

    # 构建新的文件名
    base_path, file_name = os.path.split(file_path)
    file_name_without_extension, file_extension = os.path.splitext(file_name)
    new_file_name = f"{file_name_without_extension}_processed{file_extension}"
    new_file_path = os.path.join(base_path, new_file_name)

    # 将更新后的数据写入新文件
    with open(new_file_path, 'w') as file:
        json.dump(json_data, file, indent=2)

if __name__ == "__main__":
    # Check if the correct number of command line arguments is provided
    if len(sys.argv) != 2:
        print("Usage: python mypy.py <json_file_path>")
        sys.exit(1)

    json_file_path = sys.argv[1]
    process_json_file(json_file_path)
