import tkinter as tk
from tkinter import filedialog
import os

# 用于分段读取文件内容的生成器函数
def read_file_in_chunks(file_path, chunk_size=1024):
    with open(file_path, 'r') as file:
        while True:
            chunk = file.read(chunk_size)
            if not chunk:
                break
            yield chunk

def load_file():
    file_path = filedialog.askopenfilename()
    if file_path:
        file_size = os.path.getsize(file_path)
        if file_size > (1024 * 1024 * 1024):  # Check if file size exceeds 1GB
            status_label.config(text="文件过大，请选择小于1GB的文件")
        else:
            text_area.delete(1.0, tk.END)
            for chunk in read_file_in_chunks(file_path):
                text_area.insert(tk.END, chunk)
            status_label.config(text=f"已加载文件：{file_path}")

# 创建主窗口
root = tk.Tk()
root.title("大文件阅读器")

# 创建菜单
menu_bar = tk.Menu(root)
file_menu = tk.Menu(menu_bar, tearoff=0)
file_menu.add_command(label="打开文件", command=read_file_in_chunks("D:\\大学学习资料\\大三上学期学习\\分布式系统\\作业\\dblp.xml\\dblp.xml"))
file_menu.add_command(label="退出", command=root.quit)
menu_bar.add_cascade(label="文件", menu=file_menu)
root.config(menu=menu_bar)

# 创建文本区域和状态标签
text_area = tk.Text(root)
text_area.pack(fill=tk.BOTH, expand=1)

status_label = tk.Label(root, text="", bd=1, relief=tk.SUNKEN, anchor=tk.W)
status_label.pack(side=tk.BOTTOM, fill=tk.X)

root.mainloop()