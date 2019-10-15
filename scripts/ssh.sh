# local --> middle -> target
Host middle
    User xx
    Hostname x.x.x.x

Host target
    User xx
    Hostname x.x.x.x
    ProxyCommand ssh middle nc %h %p

ssh target
