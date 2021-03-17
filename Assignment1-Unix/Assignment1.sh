#!/bin/bash 

#Notice that it's called /bash instead of /sh.
#That is so a advanced for loop and array[i+1] can work (which our program needs)
#and it's okay that you use some bash :) So bash can run sh scripts but sh is (maybe) unable to run  #sh scripts

. ./my-lib.sh

if [ $# -eq 0 ];
then
	echo "Usage: $0 [-n N] (-c|-2|-r|-F|-t|-f) <filename>"
	exit
fi

#Checks if theres any input in standard input (this is where piped content resides in a file)
if [ -p /dev/stdin ]; then
	FILENAME='/dev/stdin'
else
	FILENAME='thttpd.log' #Else the hardcoded file is used
fi
LIST_LIMIT=-1

args=("$@")
for (( i=0; i<$#; i++)); do
	if [ ${args[i]} = '-f' ]; then
		FILENAME=${args[i+1]}	#If another file is specified using -f <filename> this is assigned as variable FILENAME
fi
done

while getopts n:c2rFtf option
do
	case $option in
	n)
		LIST_LIMIT=$OPTARG
		;;

	c)
		connection_attempts $LIST_LIMIT $FILENAME
		;;
	2)
		successful_attempts $LIST_LIMIT $FILENAME
		;;
	r)	
		common_resultcodes $LIST_LIMIT $FILENAME
		;;
	F) 
		failure_resultcodes $LIST_LIMIT $FILENAME
		;;
	t)
		most_numberofbytes $LIST_LIMIT $FILENAME
		;;
	f)
		#Since the -f has already been processed we dont need to do anything, but we don't want the getopts to reject the -f
		;;
	
	*) 	echo "Error! Unknown Command. Write '$0' for proper usage."
		;;
	esac
done
