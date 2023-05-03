[<< Back to Main](../README.md)


## Prerequisites:

```sudo apt-get install resolvconf```

## WSL Root User
From cmd, open WSL as root user
```wsl -u root```

From WSL bash terminal, switch to root user:
```sudo -s```

### From cmd or bash:

Look up DNS server of the VPN:
```ipconfig.exe /all```

### From WSL bash terminal:

Move into /etc directory
```cd /etc```

Read resolv.conf file to check DNS settings
```cat resolv.conf```

add DNS nameservers
```sudo echo "nameserver 10.8.8.8" >> resolv.conf```
```sudo echo "nameserver 10.8.8.4" >> resolv.conf```


### from cmd:

shutdown wsl
```wsl --shutdown```

ensure vpn is off

startup wsl
