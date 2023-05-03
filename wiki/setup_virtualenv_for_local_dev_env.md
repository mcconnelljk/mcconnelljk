[<< Back to Main](../README.md)


# Leveraging 'virtualenv' package in Linux
I run WSL on my PC, and use 'apt' as my package manager.  I generally keep my local-dev virtual environments in my GitHub folder on the Windows side, and open the GitHub folder in VS Code.  These commands support managing these virtual environments and their respective packages from the WSL terminal.

## Setting up virtualenv
First, navigate in bash to desired home directory.  Then, run the following commands to create the virtual environment using the virtualenv package.

```pip3 install virtualenv```

```virtualenv .venv_[NAME]```

Next, activate the virtualenv and read in the requirements.txt file

```source .venv_[NAME]/bin/activate```

```pip3 install -r requirements.txt```

# Other helpful Linux commands:

Update Linux subsystem packages
```sudo apt upgrade```

Print out packages into requirements.txt document
```pip freeze > requirements.txt```
