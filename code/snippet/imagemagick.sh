# Merge pictures
montage -geometry +2+4 *.png merge.jpg

# Resize pictures
mogrify -resize 50% *.png
mogrify -resize 256x256 *.png

# PDF pages to a thumbnail picture
convert "xxx.pdf[0-7]" -thumbnail x156 thumb.png
montage -mode concatenate -quality 80 -tile x1 "thumb-*.png" xxx.png
