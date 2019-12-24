# https://bash-prompt.net/guides/server-hacked/

# /etc/ssh/sshd_config
ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin no

systemctl restart sshd
