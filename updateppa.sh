#---INPUT ARGS
PPA_FOLDER=$1



#---COLOR CONSTANTS
RESET_COLOR=$'\033[0;0m'
FG_ORANGE_COLOR=$'\033[30;38;5;215m'
FG_RED_COLOR=$'\e[30;38;5;9m'


#---PRINT CONSTANTS
ERROR_INVALD_OR_NONEXISTING="***${FG_RED_COLOR}ERROR${RESET_COLOR}: invalid or non-existing ppa-folder" 


#---OTHER CONSTANTS
EMAIL="support@tibbo.com"


#Get current directory
curr_dir=$(pwd)

#check if 1st argument is empty
if [ -z "$PPA_FOLDER" ]; then
    tput cud1

    READDIALOG1="---:${FG_ORANGE_COLOR}INPUT${RESET_COLOR}: ppa-folder (e.g. u0_6_0): "

    if [[ -z "${PPA_FOLDER}" ]]; then
        while true
        do
            read -p "${READDIALOG1}" PPA_FOLDER

            if [[ -n "${PPA_FOLDER}" ]]; then
                ppa_dir="${curr_dir}/${PPA_FOLDER}"
                if [[ -d "${ppa_dir}" ]]; then
                    break
                else
                    errormsg="\n${ERROR_INVALD_OR_NONEXISTING} '${ppa_dir}'\n" 

                    echo -e "${errormsg}"
                fi
            else
                tput cuu1
                tput el
            fi
        done
    fi
    # echo "Usage: $0 <ppa_folder>"
    # exit 1
else
    ppa_dir="${curr_dir}/${PPA_FOLDER}"
fi

echo $ppa_dir
# Navigate to 'ppa_dir'
cd ${ppa_dir}

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease