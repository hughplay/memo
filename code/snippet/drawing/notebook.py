# update your fonts in jupyter
# -------
# download fonts: https://boldfonts.com/
# https://scentellegher.github.io/visualization/2018/05/02/custom-fonts-matplotlib.html
# copy you fronts to /usr/share/fonts/truetype (ubuntu)
wget https://github.com/hughplay/memo/raw/master/code/snippet/drawing/plot_fonts.tar.gz
tar zxvf plot_fonts.tar.gz
sudo cp plot_fonts/* /usr/share/fonts/truetype/

sudo apt install -y fontconfig
sudo fc-cache -fv

rm -fr ~/.cache/matplotlib
# restart jupyter
# list all available fonts
import matplotlib.font_manager
print(sorted([f.name for f in matplotlib.font_manager.fontManager.ttflist]))


# change style of matplotlib
# -------
# https://matplotlib.org/stable/tutorials/introductory/customizing.html#using-style-sheets
# https://matplotlib.org/stable/gallery/style_sheets/style_sheets_reference.html
plt.style.use('seaborn-muted')

# General settings: http://www.futurile.net/2016/02/27/matplotlib-beautiful-plots-with-style/
import matplotlib.pyplot as plt
import matplotlib.font_manager
print(f"available fonts: {sorted([f.name for f in matplotlib.font_manager.fontManager.ttflist])}")

plt.style.use('seaborn-muted')

plt.rcParams["figure.dpi"] = 300
plt.rcParams["savefig.dpi"] = 300
plt.rcParams["savefig.format"] = "pdf"
plt.rcParams["savefig.bbox"] = "tight"
plt.rcParams["savefig.pad_inches"] = 0.1

plt.rcParams['figure.titlesize'] = 18
plt.rcParams['axes.titlesize'] = 18
plt.rcParams['font.family'] = 'Helvetica'
plt.rcParams['font.size'] = 18

plt.rcParams["lines.linewidth"] = 2
plt.rcParams['axes.labelsize'] = 16
plt.rcParams['axes.labelweight'] = 'bold'
plt.rcParams['xtick.labelsize'] = 16
plt.rcParams['ytick.labelsize'] = 16
plt.rcParams['legend.fontsize'] = 16
plt.rcParams['axes.linewidth'] = 2
plt.rcParams['axes.titlepad'] = 6

plt.rcParams['mathtext.fontset'] = 'dejavuserif'
plt.rcParams['mathtext.it'] = 'serif:italic'
plt.rcParams['lines.marker'] = ""
plt.rcParams['legend.frameon'] = False


# subplots
width, height = plt.figaspect(0.3)
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(width, height))

ax1.plot(x, y, "-", label="xxx")
ax1.set_title("xxx",  fontstyle='italic')
ax1.set_xlabel("xxx")
ax1.set_ylabel("xxx")
ax1.legend()
plt.subplots_adjust(top=0.8, hspace=None, wspace=None) 
fig.suptitle("Statistics of VTT dataset")
