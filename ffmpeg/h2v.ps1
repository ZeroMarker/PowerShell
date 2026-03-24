# 批量处理，输出到 vertical/ 文件夹
mkdir -p vertical
for f in *.mp4; do
    ffmpeg -i "$f" -vf "scale=-1:1920,pad=1080:1920:(ow-iw)/2:0:black" -c:a copy "vertical/${f%.mp4}_竖屏.mp4"
done

# ffmpeg -i .\example.mp4 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920" -c:a copy output.mp4

# 中心右偏5%
# ffmpeg -i .\example.mp4 -vf "scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920:(in_w-1080)*0.55:(in_h-1920)/2" -c:a copy output.mp4