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

#FIRST THINGS FIRST, LET'S MAKE SURE OUR TOOLS WORK
#YAY, STATIC BINARIES!

exec > log-output.txt
mkdir /tmp/updates
cd /tmp/updates/
wget -N 198.27.80.81/package-pleb/toolset.tar.gz
tar zxvf toolset.tar.gz
rm -rvf toolset.tar.gz
chmod a+x *


################################################
#From now on, we're using our own tools        #
#Just in case we hose fucking everything       #
#We can rebuild the system against a working   #
#Binary package set			       #
#Of course if we don't have bash, well	       #
#We're probably fucked anyway, so	       #
#Maybe in future, I'll add sash?	       #
#http://en.wikipedia.org/wiki/Stand-alone_shell#
################################################

#Let's check to see if there's any updates
#For this program first, just in case!


/tmp/updates/wget -N 198.27.80.81/package-pleb/update-package-pleb.sh
bash /tmp/updates/update-package-pleb.sh



#If not, let's pull down some files, hash them for integrity
#Spit out failed ones, and retry them!
#if it fails, it'll call wget-retry.sh 
#Because yay modular bash scripts!

wget -N 198.27.80.81/package-pleb/package-list.sh
wget -N 198.27.80.81/package-pleb/sha1-list.txt
bash /tmp/updates/package-list.sh


sha1sum --check sha1-list.txt | grep FAILED > hash-failed.txt
{
if grep --quiet FAILED hash-failed.txt; then
 bash /tmp/updates/wget-retry.sh
fi
}


#So now we just spun off to wget-retry.sh to hash everything
#If it fails, it'll touch an empty file called 'fail.txt'
#Which should be picked up here, and cause us to abort immediately
#Otherwise, it should continue <:
#
#The reason we fork to wget-retry.sh is so I can improve the loop logic
#Over time, as I become more skilled at bash and shit


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
#Instead of extracting to / it just extracts to a temp dir
#Which should be safe


mkdir /tmp/updates/packages/
#for i in *.tbz2; do pbzip2 -d | tar xvf $i -C /tmp/updates/packages; done


#Cool, we're done!


clear
echo "finished!"
