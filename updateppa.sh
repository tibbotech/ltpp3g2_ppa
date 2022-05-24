EMAIL="support@tibbo.com"

PPA_FOLDER=$1

#check if 1st argument is empty
if [ -z "$PPA_FOLDER" ]; then
    echo "Usage: $0 <ppa_folder>"
    exit 1
fi

cd ${PPA_FOLDER}

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease