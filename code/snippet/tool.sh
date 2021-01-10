#!/usr/bin/env bash

# Device information
uname -m && cat /etc/*release

# For loop
start=0
end=5
for num in `seq -f "%04g" $start $end`
do
    echo "$num"
done

# bibtex2html
bibtex2html -nofooter -nolinks -nokeys -o - -s apa -nodoc -q reference.bib

# with full relative path
ls -d folder/*.jpg

# put this into ~/.zshrc or ~/.bash_profile to prevent $PATH get chaos when entering tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# Batch change files permission
find ./* -type d -exec chmod 755 {} \;
find ./* -type f -exec chmod 644 {} \;

# !Sync! files from a remote server
rsync --delete --ignore-existing -avP user@host:"/target/dir/*.tar.gz" ~/local/dir

# Upload large file to Zenodo
# https://github.com/jhpoelen/zenodo-upload
# https://developers.zenodo.org/#quickstart-upload
DEPOSITION=$1
FILEPATH=$2
FILENAME=$(echo $FILEPATH | sed 's+.*/++g')
BUCKET=$(curl -H "Accept: application/json" -H "Authorization: Bearer $ZENODO_TOKEN" "https://www.zenodo.org/api/deposit/depositions/$DEPOSITION" | jq --raw-output .links.bucket)
curl --progress-bar -o /dev/null --upload-file $FILEPATH $BUCKET/$FILENAME?access_token=$ZENODO_TOKEN

# tar - very fast (pigz: multiple cores)
tar -cv --use-compress-program=pigz -f <dir>.tar.gz <dir>
