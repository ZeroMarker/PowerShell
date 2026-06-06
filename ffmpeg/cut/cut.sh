#!/bin/bash
# 全局使用: export PATH="$PATH:~/PowerShell/ffmpeg/cut"
# 视频裁剪工具
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

to_sec() {
    IFS=: read -r h m s <<< "$1"
    echo $(( 10#$h * 3600 + 10#$m * 60 + 10#$s ))
}

DURATION_SEC=$(( $(to_sec "$END_TIME") - $(to_sec "$START_TIME") ))
DURATION=$(printf "%02d:%02d:%02d" $((DURATION_SEC/3600)) $(((DURATION_SEC%3600)/60)) $((DURATION_SEC%60)))

echo "裁剪: $INPUT_FILE"
echo "时间: $START_TIME -> $END_TIME (时长: $DURATION)"
echo "输出: $OUTPUT"

ffmpeg -y -ss "$START_TIME" -i "$INPUT_FILE" -t "$DURATION" -c copy "$OUTPUT"
