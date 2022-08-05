# Replace `brew update` mirror with TUNA
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

brew update

# Replace `brew update` mirror with TUNA
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc

# Install OpenCV
# https://www.pyimagesearch.com/2018/08/17/install-opencv-4-on-macos/
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0.zip
unzip opencv.zip
unzip opencv_contrib.zip
cd opencv-4.0.0
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D PYTHON_EXECUTABLE=`which python` \
    -D BUILD_opencv_text=OFF \
    -D BUILD_EXAMPLES=ON ..
sudo ln -nfs /usr/local/python/cv2/python-3.6/cv2.cpython-36m-darwin.so /usr/local/lib/python3.6/site-packages/cv2.so

#    -D OPENCV_ENABLE_NONFREE=ON \
# Update 2018-11-30: I added a CMake compile flag to enable nonfree algorithms ( OPENCV_ENABLE_NONFREE=ON ).
# This is required for OpenCV 4 if you want access to patented algorithms for educational purposes.
# How to find out where the Python include directory is?
from sysconfig import get_paths
from pprint import pprint
info = get_paths()  # a dictionary of key-paths
pprint(info)

# Better install opencv with Anaconda
conda install -c conda-forge opencv=3.4.4

# Mac iTerm2 alt
# https://www.clairecodes.com/blog/2018-10-15-making-the-alt-key-work-in-iterm2/
⌥←
Send Escape Sequence
“Esc +” “b”
⌥→
Send Escape Sequence
“Esc +” “f”
# https://github.com/fish-shell/fish-shell/issues/2124#issuecomment-109204491
let option key Esc+

# xxx.app is damaged
sudo xattr -d com.apple.quarantine /Applications/xxx.app
