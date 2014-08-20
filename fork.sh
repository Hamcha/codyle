#!/bin/sh

# Get repo
URL="https://api.github.com/search/repositories?q=language:c&sort=updated&order=desc&per_page=1"
PAIR=`curl ${URL} | jq -r '.items[0].full_name'`
#PAIR="hamcha/OlegDB"
VICTIM=`echo ${PAIR} | cut -d / -f 1`
REPO=`echo ${PAIR} | cut -d / -f 2`

# Check if dir already exists (and quit if so)
if [ -d $REPO ]; then
	echo "Repository already exists"
	exit
fi

# Clone repo and be a bad guy
hub clone ${VICTIM}/${REPO}
cd ${REPO}
hub fork
find . -regex ".*\.[c|cpp|h]" -exec astyle {} \;
find . -name "*.orig" -delete
git add *
git commit -m "Improved coding style"
git push ssh://git@github.com/${USER}/${REPO}.git
hub pull-request -h master -f -F ~/prfile
