cd $GOPATH/src/$1
echo "pwd: `pwd`"
echo "buidling..."
buffalo build $2 $3 $4 $5 $6
echo "done."
