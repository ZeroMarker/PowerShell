#!/bin/bash
# 全局使用: export PATH="$PATH:~/PowerShell/ffmpeg/cut"
# 视频裁剪工具（重新编码模式，帧级精确）
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

# 校验时间格式
for t in "$START_TIME" "$END_TIME"; do
    if ! [[ "$t" =~ ^[0-9]{2}:[0-9]{2}:[0-9]{2}$ ]]; then
        echo "错误: 时间格式无效（应为 HH:MM:SS）: $t" >&2
        exit 1
    fi
done

to_sec() {
    IFS=: read -r h m s <<< "$1"
    echo $(( 10#$h * 3600 + 10#$m * 60 + 10#$s ))
}

START_SEC=$(to_sec "$START_TIME")
END_SEC=$(to_sec "$END_TIME")

if [ "$END_SEC" -le "$START_SEC" ]; then
    echo "错误: 结束时间必须大于开始时间" >&2
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
echo "模式: 重新编码（帧级精确）"

# 检测原始视频编码，选择合适的编码器
VCODEC=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$INPUT_FILE")
case "$VCODEC" in
    h264|avc)              VENC=libx264; CRF=23 ;;
    hevc|h265)             VENC=libx265; CRF=28 ;;
    vp9)                   VENC=libvpx-vp9; CRF=30;;
    av1)                   VENC=libaom-av1; CRF=30;;
    *)                     VENC=libx264; CRF=23 ;;
esac

echo "检测到视频编码: $VCODEC → 编码器: $VENC"

# -ss 在 -i 前：跳到起始时间前的关键帧，解码后丢弃到精确帧，再重新编码
ffmpeg -y -ss "$START_TIME" -i "$INPUT_FILE" -to "$END_TIME" \
    -c:v "$VENC" -crf "$CRF" -preset fast \
    -c:a copy \
    "$OUTPUT"
