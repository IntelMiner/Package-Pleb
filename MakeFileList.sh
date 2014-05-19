#This file should be run as a cronjob
#It will automagically take all files
#in the specified directory
#and make them into a list
#Which should be wgetted and appended
#By the update.sh
#It should also generate SHA1 sums
#And then pipe them out ot a file

#!/bin/bash
rm wget.sh
cd files/
rm *.txt
find * -type f -print > temp.txt
nl -s "wget -N intelminer.com/package-pleb/files/" temp.txt | cut -c7- > updates.txt
mv updates.txt ../wget.sh
mv sha1.txt ../sha1.txt
#
#rm *.txt
#find . -type f -exec sha1sum {} >> sha1.txt \;
