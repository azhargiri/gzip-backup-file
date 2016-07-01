#!/bin/sh

set -e 

srcdir="/tmp"
tempdir="$srcdir/tempdir"
srcfile="errors.log"
gzipsrcfile="$srcfile.$(date +%F_%H%M%S).gz"

# prevent execution when the $tempdir is root dir
test "x$tempdir" = "x/" && exit 1

# FILE exists and write permission is granted
! test -w "$tempdir" && mkdir "$tempdir"

# Steps :
# 1. backup current log file to "tempdir" directory
# 2. gzip the log file and save in tmp directory (original directory of error log file)
# 3. remove file from tocron directory
# # 4. remove "tempdir" directory
(mv "$srcdir/$srcfile" "$tempdir/$srcfile" && gzip -c "$tempdir/$srcfile" > "$srcdir/$gzipsrcfile") 

test -f "$tempdir/$srcfile" && rm "$tempdir/$srcfile"
# test -d $tempdir && rmdir "$tempdir"