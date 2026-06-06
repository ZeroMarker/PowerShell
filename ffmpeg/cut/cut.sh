#!/bin/bash
# 视频裁剪工具（两阶段：快速粗剪 → 精确细剪）
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

to_sec() {
    IFS=: read -r h m s <<< "$1"
    echo $(( 10#$h * 3600 + 10#$m * 60 + 10#$s ))
}

DURATION=$(( $(to_sec "$END_TIME") - $(to_sec "$START_TIME") ))

DIR=$(dirname "$INPUT_FILE")
NAME=$(basename "$INPUT_FILE" | sed 's/\.[^.]*$//')
EXT="${INPUT_FILE##*.}"
START_CLEAN=$(echo "$START_TIME" | tr -d ':')
END_CLEAN=$(echo "$END_TIME" | tr -d ':')
OUTPUT="${NAME}_cut_${START_CLEAN}-${END_CLEAN}.${EXT}"

TEMP="${NAME}_temp.${EXT}"

echo "阶段1/2: 快速粗剪（流复制）..."
echo "  输入: $INPUT_FILE"
echo "  区间: $START_TIME -> $END_TIME"

ffmpeg -y -ss "$START_TIME" -i "$INPUT_FILE" -to "$END_TIME" -c copy -copyts "$TEMP" || exit 1

# 探测临时文件的首帧 PTS（即关键帧的原始时间戳）
FIRST=$(ffprobe -v error -select_streams v:0 -read_intervals '%+#1' -show_entries packet=pts_time -of csv=p=0 "$TEMP")
OFFSET=$(awk "BEGIN { print $(to_sec "$START_TIME") - $FIRST }")

echo "阶段2/2: 精确细剪（重新编码 偏移=${OFFSET}s）..."
echo "  输出: $OUTPUT"

ffmpeg -y -ss "$OFFSET" -i "$TEMP" -t "$DURATION" -c:v libx264 -crf 23 -preset fast -c:a aac "$OUTPUT" && rm -f "$TEMP"
