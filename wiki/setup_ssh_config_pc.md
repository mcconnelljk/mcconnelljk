[<< Back to Main](../README.md)

## Configure SSH - PC
The key lives in my user folder: "C:\Users\[username]\.ssh\"

The config file should include the following text:

```
    Host Isusagedb
        HostName []
        User []
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa
        IdentitiesOnly yes

    Host * 
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_rsa
```

## Configure SSH - WSL
T

## Start SSH Session
Connect to F5 VPN, then disable BAH VPN.

Then, run the following command from either bash or cmd:
```ssh Isusagedb -L localhost:45432:localhost:5432```