#!/bin/sh
hub clone ${VICTIM}/${REPO}
cd ${REPO}
hub fork
astyle --recursive \*.c \*.h
astyle --recursive \*.cpp \*.h
find . -name "*.orig" -delete
git add \*
git commit -m "Improved coding style"
git push ssh://git@github.com/${USER}/${REPO}.git
hub pull-request -h master -f -F ~/prfile
