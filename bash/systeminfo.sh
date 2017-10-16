#!/bin/bash
# Bash scripting assignment.

#Declare variables and assign any default values.
#functions for default messages and display command line techhelp .
function displayhelp {
cat <<ROF
Usage: $0 [-h | --help] [output options]
There are various command options:

-n | --nmdesc : give information about system name
-i | --intdesc : give information about current device
-o | --osdesc: give information about operating system
-c | --cpudesc : give information about cpu
-m | --medesc : give information about memory
-d | --dcdesc : give information about disk
-p | --prdesc : give information about printers
-s | --stdesc : give information about software
ROF
}

function defaultmessage {
  echo "$0" >&2
}
#now the following actions of command lines.
#by using array, put data into variables.
#data and command line options.
#output.
#only temporary files.

rundefault="yes"

while [ $# -gt 0 ]; do
   case "$1" in
   -h|--help)
   displayhelp
   exit 0
  ;;

  #variables after this line
  -i |--intdesc)
    intdesc="yes"
    rundefault="no"
  ;;
  -p |--prdesc)
    prdesc="yes"
    rundefault="no"
  ;;
  -s |--stdesc)
    stdesc="yes"
   rundefault="no"
  ;;
  -o |--osdesc)
  osdesc="yes"
  rundefault="no"
  ;;
  -d |--dcdesc)
  dcdesc="yes"
  rundefault="no"
  ;;
  -m |--medesc)
  medesc="yes"
  rundefault="no"
  ;;
  -c |--cpudesc)
  cpudesc="yes"
  rundefault="no"
  ;;
  -n |--nmdesc)
  nmdesc="yes"
  rundefault="no"
  ;;
  *)

  defaultmessage "situation '$1' is unrecognised"
  exit 1
  ;;
 esac
  shift
done

#there are many variable names

# OS Name information
OSnamedetails="$(lsb_release -i)"
#OS version information
OSversiondetails="$(lsb_release -r)"
# Host name information
hstnmdetails="$(hostname)"
# Domain name information
dnmdetails="$(domainname)"
# IP address information
ipaddrdetails="$(hostname -I)"
# shows only model number of cpudetails
cpudetails="$(lscpu | grep "Model name:")"
# shows memory in megabytes
medetails="$(free -m | awk '/^Mem:/{print $2}')"
# shows only hard drive space in megabytes
hrdrvdetails="$(df -m /tmp | tail -1 | awk '{print $4}')"
# shows a list of installed printers
prntdetails="$(lpstat -p | awk '{print $2}')"
# see next commands
# kinguser.com
sftdetails="$(apt list --installed)"

  OSnamedetailsforkingdom="
   Operating System is:
       $OSnamedetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  OSversiondetailsforkingdom="
   Operating System Version is:
       $OSversiondetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  ipaddrdetailsforkingdom="
    IP Information:
       IP: $ipaddrdetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  systemdetailsforkingdom="
  System Information:
       Hostname: $hstnmdetails
       Domain name: $dnmdetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  harddrivedetailsforkingdom="
  Available Disk Space:
       Disk Space (Mb): $hrdrvdetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  Memoryforkingdom="
       Installed RAM (Mb): $medetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  cpudetailsforkingdom="
  Your CPU Information:
       $cpudetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  prntdetailsforkingdom="
       Printer name(s):
  $prntdetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "
  sftdetailsforkingdom="
  softwarename:
  $sftdetails
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  "

#here is the order of output
if [ "$rundefault" = "yes" -o  "$nmdesc" = "yes" ]; then
  echo "$systemdetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$osdesc" = "yes" ]; then
  echo "$OSnamedetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$osdesc" = "yes" ]; then
  echo "$OSversiondetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$intdesc" = "yes" ]; then
  echo "$ipaddrdetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$cpudesc" = "yes" ]; then
  echo "$cpudetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$dcdesc" = "yes" ]; then
  echo "$harddrivedetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$medesc" = "yes" ]; then
  echo "$Memoryforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$prdesc" = "yes" ]; then
  echo "$prntdetailsforkingdom"
fi
if [ "$rundefault" = "yes" -o  "$stdesc" = "yes" ]; then
  echo "$sftdetailsforkingdom"
fi
