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
# -I = --use-compress-program
tar -cv -I pigz -f <name>.tar.gz <dir>
tar -xv -I pigz -f <name>.tar.gz

# split and join
split -b 4G <xxx>.tar.gz "<xxx>.tar.gz.part-"
cat <xxx>.tar.gz.part-* > <xxx>.tar.gz

# Download Google Drive
# https://stackoverflow.com/a/43816312
# 1. Go to the Google Drive webpage that has the download link
# 2. Open your browser console and go to the "network" tab
# 3. Click the download link
# 4. Wait for it the file to start downloading, and find the corresponding request (should be the last one in the list), then you can cancel the download
# 5. Right click on the request and click "Copy as cURL" (or similar)
