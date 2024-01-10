import json
import math
import sys

def read_json(file_path):
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)
        return data
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"Error decoding JSON in file: {file_path}")
        sys.exit(1)

def write_json(file_path, data):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=2)

def split_json(data, num_blocks):
    total_entries = len(data)
    entries_per_block = math.ceil(total_entries / num_blocks)

    blocks = [{} for _ in range(num_blocks)]
    current_block = 0

    for key, value in data.items():
        blocks[current_block][key] = value
        current_block = (current_block + 1) % num_blocks

    return blocks

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_file_path> <output_directory> <num_blocks>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    output_directory = sys.argv[2]
    num_blocks = int(sys.argv[3])

    json_data = read_json(input_file_path)
    json_blocks = split_json(json_data, num_blocks)

    for i, block in enumerate(json_blocks):
        output_file_path = f"{output_directory}/block_{i + 1}.json"
        write_json(output_file_path, block)
        print(f"Block {i + 1} written to {output_file_path}")
