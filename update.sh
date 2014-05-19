#This program should pull down a bunch of tarballs
#Then blindly extract them to the rootfs
#This is /really awful/
#Please don't ever follow my example, please
#Oh, one more thing
#In the interests of safety (hurr hurr)
#This'll also pull down its own toolset
#Just in case it hoses the built-in ones
#Oh, I should probably build a static toolset
#Someone remind me to do that in a future release
#So for now that's disabled :(

#FIRST THINGS FIRST, LET'S GET A TOOLSET
#YAY, STATIC LIBS!

mkdir /tmp/updates
cd /tmp/updates/
#wget -N intelminer.com/package-pleb/toolset.tar.gz
#tar zxvf toolset.tar.gz
#rm -rvf toolset.tar.gz
#chmod a+x *

#Let's check to see if there's any updates
#For this program first, just in case!

wget -N intelminer.com/package-pleb/updater.sh
bash /tmp/updates/updater.sh

#If not, let's pull down some files
#Hash them for integrity
#Spitting out failed ones
#And retrying them
#for now it only does it once
#I'll maybe add some sort of 
#retry -> loop -> fail logic
#But for now let's just assume
#That it works (because of course we do)


wget -N intelminer.com/package-pleb/wget.sh
wget -N intelminer.com/package-pleb/sha1.txt
bash /tmp/updates/wget.sh

sha1sum --check sha1.txt | grep FAILED > failed.txt
cat failed.txt |  sed 's/.*\///' | sed "s/\FAILED.*//" | sed s/://g > retry.txt
#rm failed.txt
nl -s "wget -N intelminer.com/package-pleb/" retry.txt | cut -c7- > wget-retry.sh
#rm retry.txt
bash /tmp/updates/wget-retry.sh

#Okay, now we've got a shitton of tarballs!
#Let's just blindly extract them ALL
#It probably wont break anything, right?
#
#Yeah actually it does break some things, so
#Let's make it safe unless we want to use
#And just send them to some safe directory

mkdir /tmp/updates/packages/
#for i in *.tbz2; do tar xvf $i -C /tmp/updates/packages; done

#clear
echo "finished!"
