# LTPP3(G2) PPA

## Updating the PPA
This repository contains the Personal Package Archive (PPA) for Tibbo's [Ubuntu-based distribution](https://tibbo.com/store/tps/ltpp3g2/ubuntu.html) running on the [Size 3 Linux Tibbo Project PCB, Gen. 2](https://tibbo.com/store/tps/ltpp3g2.html) — a.k.a. the LTPP3(G2).
The PPA is automatically included in base builds of Tibbo's distro.

To update the PPA on a running system, enter the following at the command prompt:
``` shell
sudo apt-get update && sudo apt-get upgrade
```

Don't forget to reboot after performing an update and upgrade:
``` shell
sudo reboot
```

## Creating your own PPA
Tibbo has created two handy scripts to help automate the process of making your own PPA for our distribution.

You'll first need to create and/or import a GPG key, for example:
``` shell
gpg --import public.gpg
gpg --import private.asc  
```

Next, you'll want to generate the PPA. Edit the file to "makeppa.sh" replace the variables at the top with your own information. Then, run it with the FOLDER_PATH as a parameter:
``` shell
./makeppa.sh FOLDER_PATH
```

You'll need to add your debian packages to the **ppa** folder, which is what is actually included in the archive.
After adding or updating files, run opy **updateppa.sh** with the FOLDER_PATH to your PPA and update your PPA by running:
``` shell
./updateppa.sh FOLDER_PATH
```

## Add the ppa to the device. 
To add your PPA (or re-add the Tibbo PPA), you can run the following commands after replacing the URLs with those of your archive:
```shell
curl -s --compressed "https://tibbotech.github.io/ltpp3g2_ppa/ppa/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/my_list_file.list "https://tibbotech.github.io/ltpp3g2_ppa/ppa/my_list_file.list"
sudo apt update
```
