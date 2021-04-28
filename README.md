# ltpp3g2_ppa
## Tibbo PPA for the LTPP3G2 


```shell
curl -s --compressed "https://tibbotech.github.io/ltpp3g2_ppa/ppa/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/my_list_file.list "https://tibbotech.github.io/ltpp3g2_ppa/ppa/my_list_file.list"
sudo apt update
```




## Generating a PPA
```
./makeppa.sh
```

## Updating a PPA

Add the debian package to the ppa folder. 
```
./updateppa.sh
```

##importing keys 
```
gpg --import public.gpg
gpg --import private.asc  
```