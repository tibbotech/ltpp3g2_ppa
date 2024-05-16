EMAIL="support@tibbo.com"
GITHUB_USERNAME="tibbotech"

expath="*tpp3g2_ppa"
cpath=$(pwd)
PPA_FOLDER=$1

#check if 1st argument is empty
if [ -z "$PPA_FOLDER" ]; then
    echo "Usage: $0 <ppa_folder>"
    exit 1
fi

if [[ $cpath == $expath ]]
then 
    echo "Starting PPA generation."
else 
    echo  "Unable to generate PPA wrong path."
    exit 1
fi 



if [ -d ${PPA_FOLDER} ] 
then
    echo "${PPA_FOLDER} Directory has been already created."
    echo "Add new .deb files to the ${PPA_FOLDER} folder and run updateppa."
    exit 1
else
    echo "${PPA_FOLDER} directory does not exist"    
fi

mkdir ${PPA_FOLDER}
cd ${PPA_FOLDER}

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


echo "deb https://${GITHUB_USERNAME}.github.io/ltpp3g2_ppa/${PPA_FOLDER} ./" > my_list_file.list
