[<< Back to Main](../README.md)


## Prerequisites:

As am administrator, install [git for windows]("https://git-scm.com/download/win").  Ensure that the Git file exists under C > Program Files > Git.

## WSL Root User
From WSL, point to the windows credential 

```git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe"```

## Clone the github respoitories

```git clone https://github.boozallencsn.com/mcconnell-jaclyn/is-usage-data.git```
```git clone https://github.boozallencsn.com/mcconnell-jaclyn/uad-queries.git```
```git clone https://github.boozallencsn.com/mcconnell-jaclyn/Playground.git```