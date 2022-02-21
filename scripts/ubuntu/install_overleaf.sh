# arm64 / raspberrypi (mongo does not support 32 bit system)
# https://github.com/overleaf/overleaf/issues/957
# https://tex.stackexchange.com/questions/137428/tlmgr-cannot-setup-tlpdb
apt-get install xzdec

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
docker-compose up -d --no-recreate

# Remove recaptcha
docker exec -it sharelatex bash
vim /var/www/sharelatex/web/app/views/layout.pug
# search recaptcha (93 ~ 104), comment the code block

# Create User
$ docker exec sharelatex /bin/bash -c "cd /var/www/sharelatex; grunt user:create-admin --email=joe@example.com"

# Transfer data
# The most important thing is modify the privilege of files
# Otherwise, you may encounter: Server Error Sorry, something went wrong and your project could not be compiled. Please try again in a few moments
#cd ~ && \
#chown polkitd:root mongo_data && \
#cd mongo_data && \
#chown -R polkitd:input ./* && \
#cd .. && \
#chown root:root sharelatex_data && \
cd sharelatex_data && \
chown -R 33:tape ./* && \
chown -R root:root bin && \
#cd ..

# Issue: when using ieee_fullname bibliographystyle, all citations are showing as question marks
# Solution: reinstall packages (some packages may not installed correctly in the previous installation)
tlmgr install --reinstall scheme-full --repository https://mirror.bjtu.edu.cn/ctan/systems/texlive/tlnet

# Issue: LaTeX3 Error: Mismatched LaTeX support files detected.
# Solution: https://tex.stackexchange.com/questions/576918/mismatched-latex-support-files-detected
fmtutil-user --all

# Issue: ERROR: for sharelatex  Container "0771304d9348" is unhealthy. ERROR: Encountered errors while bringing up the project.
# Observation: mongo is not up
# Solution: set the mongo version as 4.4 to match weiredTiger version
# Useful commands:
docker run -it -v /home/sharelatex/mongo_data:/data/db mongo:4.4 bash
mongod
mongod --repair # not really used
