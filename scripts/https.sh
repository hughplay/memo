# ref: https://github.com/acmesh-official/acme.sh/wiki/%E8%AF%B4%E6%98%8E
# run in aliyun: https://github.com/acmesh-official/acme.sh/wiki/Install-in-China
# ref: https://xtls.github.io/document/level-0/ch06-certificates.html#_6-3-%E6%B5%8B%E8%AF%95%E8%AF%81%E4%B9%A6%E7%94%B3%E8%AF%B7

# 1. install acme
apt install -y git socat
git clone https://gitee.com/neilpang/acme.sh.git
cd acme.sh
./acme.sh --install -m email=my@example.com
. ~/.bashrc

# 2. generate CA
## test
acme.sh --issue --server letsencrypt --test -d <domain>.com -w /var/<website>/<dir> --keylength ec-256
## formal
acme.sh --set-default-ca --server letsencrypt
acme.sh --issue -d <domain>.com -w  /var/<website>/<dir> --keylength ec-256 --force
## install
acme.sh --installcert -d <domain>.com --cert-file /etc/ssl/<domain>/cert.crt --key-file /etc/ssl/<domain>/cert.key --fullchain-file /etc/ssl/<domain>/fullchain.crt --ecc

# 3. nginx
## modify configuration
server {
...
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        ssl_certificate /etc/ssl/<domain>/fullchain.crt;
        ssl_certificate_key /etc/ssl/<domain>/cert.key;
...
}
## test
nginx -t
## reload nginx
service nginx force-reload
## visit https://<domain>.com to check

# 4. update
# acme.sh will update CA automatically every 60 days
# check `crontab -l` to see the cron job, it will be like:
0 1 1 * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" --force > /dev/null && systemctl restart nginx
# you can run it manually to see if it works
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" --force
