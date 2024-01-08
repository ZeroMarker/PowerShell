#!/bin/bash

# 设置source文件夹路径
sourceFolder="/mnt/host/c/Users/ttft3/Downloads/马世梅-转正材料"

# 设置target文件夹路径
targetFolder="/mnt/host/d/Users/ttft3/Desktop/target"

# 在开始时创建target文件夹
mkdir -p "$targetFolder"

# 递归遍历source文件夹
find "$sourceFolder" -type d -exec mkdir -p "$targetFolder/{}" \;
find "$sourceFolder" -type f -exec touch "$targetFolder/{}.txt" \;
