[<< Back to Main](../README.md)


## Prerequisites:
[install azure cli](./setup_azure_cli_WSL)

Within a new project folder as your working directory, create and activate a virtual environment

## WSL Root User
From within virtual environment, install databricks-cli
```pip install databricks-cli```

If already installed, ensure installation is the most current verion:

```pip install databricks-cli --upgrade```

## Configure the connection to your Databricks workspace

Open the workspace in an internet browser, and create a "cli" token for local-dev use:

[Generate a token]("https://adb-6424592931037379.19.azuredatabricks.net/?o=6424592931037379#setting/account") under user-settings

Then, in your local dev environment, enter this command:

```databricks configure --token```

Enter the workspace URL
Enter the "cli" token

Double check the configuration file by navigating to your user partition and opening the .databrickscfg file


