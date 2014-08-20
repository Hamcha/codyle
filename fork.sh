#!/bin/sh
hub clone ${VICTIM}/${REPO}
cd ${REPO}
hub fork
find . -regex ".*\.[c|cpp|h]" -exec astyle {} \;
find . -name "*.orig" -delete
git add *
git commit -m "Improved coding style"
git push ssh://git@github.com/${USER}/${REPO}.git
hub pull-request -h master -f -F ~/prfile
