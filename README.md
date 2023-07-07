## ArpWatch2HTAML (by Fischerman.ch and AI)

### This perl script(s) generate a static, but human readable html page where the results of Arpwatch are presented in a simple (green) table.
Also the IP addresses are sorted and if you click on the IP address, the links brings you to "http://IP.addr"

If you want to use this script, make sure you have installed Aprwatch on your system
aprwatch information can be found here : https://en.wikipedia.org/wiki/Arpwatch


### ArpWatch2HTML usage

- Download ArpWatch2HTML.zip and unpack it somewhere on your system.
- start Aprwatch on your system with a command like this "arpwatch -f /PATH/TO/THE/OUTPUTFILE -i INTERFACE-NAME -d "
-- be sure you note down the path to the output file, you will need it later
- be sure you let Aprwatch run for some time and you have some results in your OUTPUTFILE
- "cd ArpWatch2HTML/"
-- manual change to the directory where you unpacked ArpWatch2HTML
- start the script with the command"perl arpwatch2html.pl"
-- the script will ask's for the output file of your Aprwatch (remeber, I told you before to note it down!) and adds new entry's to file "arpwatch_output.txt"
-- the script will then start the perl script "arpwatch_gen_table.pl" that generates html-output-file
-- the script will tell you when the job's are done and also where to find the html-output-file
- manualy download the html-output-file (arp_watch_result.html) and watch in browser ;-)

The whole code was generated using artificial intelligence !!!
If you think the code is worth further developing, drop me a note or just grab the code and make it better ;-)

### Homepage of ArpWatch2HTML -> https://www.fischerman.ch/?page_id=530202



