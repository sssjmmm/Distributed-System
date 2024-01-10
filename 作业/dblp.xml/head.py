import xml.etree.ElementTree as ET

def read_xml_lines(file_path, lines_to_read=100):
    with open(file_path, 'r', encoding='utf-8') as file:
        current_line = 0
        for line in file:
            current_line += 1
            print(line, end='')  # 打印每一行
            if current_line >= lines_to_read:
                break

if __name__ == "__main__":
    xml_file_path = "dblp.xml"
    read_xml_lines(xml_file_path, lines_to_read=300)
