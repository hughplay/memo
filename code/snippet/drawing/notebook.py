# update your fonts in jupyter
# -------
# https://scentellegher.github.io/visualization/2018/05/02/custom-fonts-matplotlib.html
# copy you fronts to /usr/share/fonts/truetype (ubuntu)
sudo fc-cache -fv
rm -fr ~/.cache/matplotlib
# restart jupyter
# list all available fonts
import matplotlib.font_manager
print(sorted([f.name for f in matplotlib.font_manager.fontManager.ttflist]))
