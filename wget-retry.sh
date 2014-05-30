#This is my first attempt at writing some "logic"
#Into package-pleb. As such, for my own sanity
#I've split it off into its own file. Like
#I'm some sort of hoity-toity programmer
#Using a real language like C, with code reuse
#And shit. Also so I can rapidly evolve it
#When I like, learn what I'm actually doing
#
#So, for this, we want to basically cat retry.txt
#mangle it so it becomes a wget script
#Execute it, loop once or twice then succeed/fail

cat failed.txt |  sed 's/.*\///' | sed "s/\FAILED.*//" | sed s/://g > retry.txt
rm failed.txt
nl -s "wget -N intelminer.com/package-pleb/" retry.txt | cut -c7- > retry.txt
sha1sum --check sha1.txt | grep FAILED > failed.txt

#Now, if THIS one fails, well, we can just...repeat!
#Because bash is awesome and lets us just execute
#Commands in a linear order, it's way easier than
#Trying to work out how to actually loop-back the script

cat failed.txt |  sed 's/.*\///' | sed "s/\FAILED.*//" | sed s/://g > retry.txt
rm failed.txt
nl -s "wget -N intelminer.com/package-pleb/" retry.txt | cut -c7- > retry.txt
sha1sum --check sha1.txt | grep FAILED > fail.txt

#If we create fail.txt update.sh should pick it up
#Then abort itself, instead of trying to continue
#So that should hopefully keepo us from hosing the
#System if we're on a really shitty internet connection
