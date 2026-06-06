#!/bin/bash
# 视频裁剪工具（流复制模式，快速）
# 用法: ./cut.sh <输入文件> <开始时间> <结束时间>
# 示例: ./cut.sh video.mp4 00:01:30 00:03:45

if [ $# -lt 3 ]; then
    echo "用法: $0 <输入文件> <开始时间> <结束时间>" >&2
    exit 1
fi

INPUT_FILE="$1"
START_TIME="$2"
END_TIME="$3"

if [ ! -f "$INPUT_FILE" ]; then
    echo "错误: 文件不存在: $INPUT_FILE" >&2
    exit 1
fi

DIR=$(dirname "$INPUT_FILE")
NAME=$(basename "$INPUT_FILE" | sed 's/\.[^.]*$//')
EXT="${INPUT_FILE##*.}"
START_CLEAN=$(echo "$START_TIME" | tr -d ':')
END_CLEAN=$(echo "$END_TIME" | tr -d ':')

if [ "$DIR" = "." ]; then
    OUTPUT="${NAME}_cut_${START_CLEAN}-${END_CLEAN}.${EXT}"
else
    OUTPUT="${DIR}/${NAME}_cut_${START_CLEAN}-${END_CLEAN}.${EXT}"
fi

echo "裁剪: $INPUT_FILE"
echo "时间: $START_TIME -> $END_TIME"
echo "输出: $OUTPUT"

ffmpeg -y -ss "$START_TIME" -i "$INPUT_FILE" -to "$END_TIME" -c copy -copyts "$OUTPUT" || exit 1

# 快速 remux 重置时间戳，方便后续二次剪辑
CLEAN="${OUTPUT%.*}_clean.${EXT}"
echo "重置时间戳: $CLEAN"
ffmpeg -i "$OUTPUT" -c copy -avoid_negative_ts make_zero "$CLEAN"
