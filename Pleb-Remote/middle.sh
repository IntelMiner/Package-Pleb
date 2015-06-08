#We're the middle man here!
#We've got the ever so fun task
#Of rigging ourselves up to
#Wherever Patrician is
#Thankfully we can curl
#http://bot.whatismyipaddress
#And that makes shit easier

#Hopefully the client sent us its IP address...

SERVER=$(<ip.txt)
rsync -avzhe ssh portage.tar.gz patrician@$SERVER:/tmp/
ssh patrician@$SERVER "nohup bash tar zxvf /tmp/portage.tar.gz -C /var/build/plebroot/etc/portage/"
ssh patrician@$SERVER "nohup bash build > ~/var/log/pleb-build.log"
