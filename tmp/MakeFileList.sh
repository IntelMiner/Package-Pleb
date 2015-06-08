#This file should be run as a cronjob
#It will automagically take all files
#in the specified directory
#and make them into a list
#which should be wgetted and appended
#by the update.sh
#it should also generate SHA1 sums
#and then pipe them out to a file
#which we also pull down and use now

#!/bin/bash
rm wget.sh
cd files/
rm *.txt
find * -type f -print > temp.txt
nl -s "wget -N intelminer.com/package-pleb/files/" temp.txt | cut -c7- > package-list.txt
mv package-list.txt ../package-list.sh
find . -type f -exec sha1sum {} >> sha1-list.txt \;
mv sha1-list.txt ../sha1-list.txt
rm *.txt
