#my-lib.sh

connection_attempts()
{
LIMIT=$1
COUNTER=0
OUTPUT=''
echo "IP and most connection attempts:"
echo
cat $FILENAME | awk '{print $1}' | sort -nr |  uniq -c | sort -nr | awk '{print$2 "  " $1}' | column -t | while read -r line 
do
echo "$line"
COUNTER=$((COUNTER+1))
if [ $LIMIT -eq $COUNTER ]; then
	break
fi
done
}

common_resultcodes()
{
LIMIT=$1
COUNTER=0
echo 'Most common resultcodes and corresponding IP:'
echo
awk '{print $9 " " $1}' $FILENAME | sort -nr | uniq -c | sort -nr | awk '{print $2 " " $3}' | column -t | while read -r line 
do
	echo "$line"
	COUNTER=$((COUNTER+1))
	if [ $LIMIT -eq $COUNTER ]; then
		break
	fi

done
}

failure_resultcodes()
{
LIMIT=$1
echo "Most common failurecodes and origin:"
echo
COUNTER=0
awk '{print $9 " " $1}' $FILENAME | grep -Eo [4-5][0-9][0-9].* | sort -nr | uniq -c | sort -nr | awk '{print $2 " " $3}' | column -t | while read -r line
do
	echo "$line"
	COUNTER=$((COUNTER+1))
	if [ $LIMIT -eq $COUNTER ]; then
		break
	fi
done
}

successful_attempts()
{
LIMIT=$1
echo "Most successful attempts and corresponding IP:"
echo
awk '$9 == "200" { print $1}' $FILENAME | uniq -c | sort -nr | head -1 | column -t | while read -r line
do
	echo "$line"
	COUNTER=$((COUNTER+1))
	if [ $LIMIT -eq $COUNTER ]; then
		break
	fi
done
}

most_numberofbytes()
{
LIMIT=$1
COUNTER=0
echo "Most number of bytes and corresponding IP:"
echo
#awk '{a[$1] += $10} END {for (i in a) print i,a[i]}' $FILENAME | sort -rk2 | head -1 | column -t | while read -r line
awk '{a[$1] += $10} END {for (i in a) print i,a[i]}' $FILENAME | sort -rk2 -n | column -t | while read -r line
do
	echo "$line"
	COUNTER=$((COUNTER+1))
	if [ $LIMIT -eq $COUNTER ]; then
		break
	fi
done
}
