# https://bash-prompt.net/guides/server-hacked/

# Checking log
journalctl -u sshd

# Security Settings
# /etc/ssh/sshd_config
ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin no

systemctl restart sshd
