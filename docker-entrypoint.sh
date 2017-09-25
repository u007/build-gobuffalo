#!/bin/bash
echo "GOPATH $GOPATH"
# cd $GOPATH/src/github.com/markbates/pop
# git pull
cd $GOPATH/src/$1
npm rebuild node-sass
echo "pwd: `pwd`"
echo "buidling..."
buffalo $2 $3 $4 $5 $6 $7
echo "done."
