#!/bin/bash
#cd /home/pradeep/code/applications/gmxscrap/bigbasket/bigbasket/spiders
#echo "pwd: `pwd`"
#echo "\$0: $0"
#echo "basename: `basename $0`"
#echo "dirname: `dirname $0`"
scriptPath="$(dirname $(readlink -f $0))"
#echo $scriptPath
cd $scriptPath
PATH=$PATH:/usr/local/bin
export PATH
scrapy crawl bigbasket
