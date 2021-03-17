EMAIL="support@tibbo.com"
GITHUB_USERNAME="tibbotech"

expath="*tpp3g2_ppa"
cpath=$(pwd)

if [[ $cpath == $expath ]]
then 
    echo "Starting PPA generation."
else 
    echo  "Unable to generate PPA wrong path."
    exit 1
fi 



if [ -d "ppa" ] 
then
    echo "PPA Directory has been already created."
    echo "Add new .deb files to the ppa folder and run updateppa."
    exit 1
else
    echo "PPA directory does not exist"    
fi

mkdir ppa
cd ppa

echo "Exporting Public Key..."
gpg --armor --export "${EMAIL}" > KEY.gpg

echo "Fetching .deb files"

echo "Creating Packages/Pakcages.gz"
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

echo "Creating Release/Release.gpg/InRelease"
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease


echo "deb https://${GITHUB_USERNAME}.github.io/ltpp3g2_ppa/ppa ./" > my_list_file.list