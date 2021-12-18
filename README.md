# Serverslime settings deployment

## Bootable auto-install image

To create a bootable image for automatically installing ubuntu on a server
download the latest ubuntu image from [https://ubuntu.com/download/server](https://ubuntu.com/download/server)
Make any edits necessary in `ubuntu-autoinstaller/user-data`. the `meta-data` file is required
but just an empty file.

The iso can be generated using the following command from the ubuntu_autoinstaller directory:
```
./autoinstall-generator.sh -a -u user-data -d ubuntu-autoinstall.iso
```

This script is the same found in: [https://github.com/covertsh/ubuntu-autoinstall-generator](https://github.com/covertsh/ubuntu-autoinstall-generator)
For the time being this script only suports Ubuntu 20.04. The author is already working
on a fix to allow newer versions of ubuntu to work with this script.
The version in this repository was updated for Ubuntu 21.10.


## Synchronize the settings

Playbook for deploying serverslime settings.
This script uses a local docker container to deploy serverslime settings using ansible
without the requirement of having ansible installed. This should make it easier to
deploy serverslime settings to a new server.

To deploy serverslime settings to a new server run the following command:
```shell
./deploy.sh
```

To update Serverslime settings in the settings server run the following command from
the serverslime user directory:

```shell
rsync -arv --files-from='include-files.txt' ~/ pi@settings-server.local:~/settings
```
Make sure to include the `include-files.txt` file in the rsync command. This file is
included in this repo for reference, but should exist in the user's home directory.

Included in this repository there is also a script called `backup-settings.sh some@remote_server` which
can be copied to serverslime user directory and run to backup serverslime settings.