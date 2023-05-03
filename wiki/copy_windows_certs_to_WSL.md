[<< Back to Main](../README.md)


# Adding Certs to WSL
After setting up WSL, I am still running into the problem where it doesn't work on the BAH network.  Connection via F5 seems to be working just fine.  I already have my SSL set up on the WSL, and now am working to set up access to the BAH network.

## Prerequisites:

```sudo apt-get install -y ca-certificates```
```sudo apt-get install -y openssl```

## Link to SSP repo containing 'certificates' folder
Fork and clone the following repo into a local directory.  I am using the default GitHub folder within the Documents folder, "C:\Users\625374\Documents\GitHub>".

[SSP Cert Repo](https://github.boozallencsn.com/SelfServicePortal/ssp-root-certs/tree/master/certificates)


## Clean up .pem files
From the Ubuntu bash terminal or VS Code WSL bash terminal, navigate to the repo's cert folder:
```cd ~/mnt/c/Users/625374/Documents/GitHub/ssp-root-certs/certificates/```

Create a working directory (so that we don't work against the original certificates)
```sudo mkdir no_space_pem```

Copy all certs into a working folder
```rsync *pem ./ no_space_pem```

For each file in the working folder, replace all of the spaces in each filename with an underscore
```for FILE in no_space_pem/*; do mv "$FILE" $(echo $FILE | tr ' ' '_'); done```

## Convert all .pem files to .crt files (UBUNTU)
(We are still in our repo's certificate folder)

For each .pem file in the working directory, convert to .crt file
```for FILE in no_space_pem/*.pem; do NAME=`echo "$FILE" | cut -d'.' -f1`; openssl x509 -outform der -in $FILE -out $NAME.crt; done```

## Copy each cert into WSL:
(From anywhere within the bash terminal)

Copy the converted .crt files into the linux filesystem
```sudo cp /mnt/c/Users/625374/Documents/GitHub/ssp-root-certs/certificates/no_space_pem/*.crt /usr/local/share/ca-certificates```

Next, run the update-ca-certificates command
```sudo update-ca-certificates```
