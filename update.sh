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
exec > log-output.txt
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

#If not, let's pull down some files, hash them for integrity
#Spit out failed ones, and retry them!
#if it fails, it'll call wget-retry.sh 
#Because yay modular bash scripts!

wget -N intelminer.com/package-pleb/wget.sh
wget -N intelminer.com/package-pleb/sha1.txt
wget -N intelminer.com/package-pleb/wget-retry.sh
bash /tmp/updates/wget.sh

sha1sum --check sha1.txt | grep FAILED > failed.txt
{
if grep --quiet FAILED failed.txt; then
 bash /tmp/updates/wget-retry.sh
fi
}

#So now we just spun off to wget-retry.sh to hash everything
#If it fails, it'll touch an empty file called 'fail.txt'
#Which should be picked up here, and cause us to abort immediately
#Otherwise, it should continue <:

{
if [ -f fail.txt ]; then
   echo "HASH CHECKING FAILED, ABORTING, CHECK THE LOG IN /var/log/package-pleb.log"
   exit 0
fi
}

#Okay, now we've got a shitton of tarballs!
#Let's just blindly extract them ALL
#It probably wont break anything, right?
#
#Yeah actually it does break some things, so
#For now, this function is like, totally de-fanged
#It /works/ but it seems to make the system unhappy 
#Mostly because of things like file modification differences
#I'll plug in some sort of NTP-sync-before-extract
#Just in case, but until then you'll have to uncomment the
#Below function

mkdir /tmp/updates/packages/
#for i in *.tbz2; do tar xvf $i -C /tmp/updates/packages; done

clear
echo "finished!"
