## ImageMagick
# Merge pictures
montage -geometry +2+4 *.png merge.jpg

# Resize pictures
mogrify -resize 50% *.png
mogrify -resize 256x256 *.png

# PDF pages to a thumbnail picture
convert "xxx.pdf[0-7]" -thumbnail x156 thumb.png
montage -mode concatenate -quality 80 -tile x1 "thumb-*.png" xxx.png

## FFmpeg
# save life and use: https://github.com/mifi/lossless-cut

# cut videos
# http://trac.ffmpeg.org/wiki/Seeking
ffmpeg -i {video_path} -ss {start} -to {end} {save_path} -hide_banner -loglevel error

# cut frame
ffmpeg -ss {time} -i {video_path} -frames:v 1 -q:v 2 {save_path.jpg}
