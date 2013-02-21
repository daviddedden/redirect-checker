#!/bin/bash

# Configuration params

#OLDSITE="/mnt/i/web1/david/"

OLDSITE=$1

#NEWSITE="http://www.daviddedden.com"                                                                                                          

NEWSITE=$2

# This is the replace value for the path string replacement.

REPLACE=""

# Use find to recursively grab all files from the root directory forward.

FILES=$(find $OLDSITE \( -name "*.html" -o -name "*.php" \) -print)

# Loop through each file in the directory to see if it loads via browser.

for f in $FILES
do
    TESTFILE=${f:1}
    TESTFILE=${TESTFILE/${OLDSITE:1}/$REPLACE}
    curl -I -sl -w "%{http_code} %{url_effective}\t" $NEWSITE/$TESTFILE -o /dev/null
    curl $NEWSITE/$TESTFILE -I -sL -w " %{url_effective}\\n" -o /dev/null
done

