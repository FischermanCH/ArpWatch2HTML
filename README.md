This perl script(s) generate a static, but human readable html page where the results of Arpwatch are presented in a simple (green) table.
Also the IP addresses are sorted and if you click on the IP address, the links brings you to "http://IP.addr"

If you want to use this script, make sure you have installed Aprwatch on your system
aprwatch information can be found here : https://en.wikipedia.org/wiki/Arpwatch

ArpWatch2HTML usage :

0.      Download ArpWatch2HTML.zip and unpack it somewhere on your system.

0.1.    start arpwatch on your system with a command like this "arpwatch -f /PATH/TO/THE/OUTPUTFILE -i INTERFACE-NAME -d "
0.2     be sure you let arpwatch run for some time and you have some results in your OUTPUTFILE
1.      "cd ArpWatch2HTML/"
            manual change to the directory where you unpacked ArpWatch2HTML
2.      "perl arpwatch2html.pl"
            ask's for the output file of your Aprwatch and adds new entry's to file "arpwatch_output.txt"
            starts the perl script "arpwatch_gen_table.pl" that generates the html output file
            shows where to find the html output file
3.      manualy download the html file an watch in browser ;-)

The whole code was generated using artificial intelligence !!!
If you think the code is worth further developing, drop me a note or just grab the code and make it better ;-)
