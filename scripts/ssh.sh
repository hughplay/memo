# Basic jump: local -> middle -> target
Host middle
    User xx
    Hostname x.x.x.x

Host target
    User xx
    Hostname x.x.x.x
    ProxyCommand ssh middle nc %h %p

ssh target

# Basic jump with proxy: local -> middle -> (proxy) -> target
Host middle
    User xx
    Hostname x.x.x.x

Host target
    User xx
    Hostname x.x.x.x
    ProxyCommand ssh middle nc --proxy-type http --proxy <address>:<port> %h %p

ssh target

# Multiple jump: local -> middle_a -> middle_b -> target
Host middle_a
    User xx
    Hostname x.x.x.x

Host middle_b
    User xx
    Hostname x.x.x.x
    ProxyCommand ssh middle_a nc %h %p

Host target
    User xx
    Hostname x.x.x.x
    ProxyCommand ssh middle_b nc %h %p

ssh target
