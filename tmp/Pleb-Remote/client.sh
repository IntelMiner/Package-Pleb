#This is the Package-Pleb client
#We make sure that everything is synced up
#in /etc/portage/
#And all its subdirectories
#We also pull the kernel config with us
#Just in case!

MIDDLEMAN=au.intelminer.com

cd /etc/portage
zcat /proc/config.gz >> kernel-config
tar cvpzf * portage.tar.gz
rsync -avzhe ssh portage.tar.gz packagepleb@$MIDDLEMAN:/tmp/pleb/
ssh packagepleb@$MIDDLEMAN "nohup bash middleman > ~/middle-pleb.log"
