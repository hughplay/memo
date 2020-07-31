# Pull sharelatex and compose file
docker pull sharelatex/sharelatex
wget https://raw.githubusercontent.com/overleaf/overleaf/master/docker-compose.yml

# Install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# First time
docker-compose up -d
docker exec sharelatex tlmgr update --self --repository https://mirror.bjtu.edu.cn/ctan/systems/texlive/tlnet
docker exec sharelatex tlmgr install scheme-full --repository https://mirror.bjtu.edu.cn/ctan/systems/texlive/tlnet
# TUNA: https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet

# Second time
docker-compose up --no-recreate

# Remove recaptcha
docker exec -it sharelatex bash
vim /var/www/sharelatex/web/app/views/layout.pug
# search recaptcha (93 ~ 104), comment the code block
