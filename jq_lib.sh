#!/bin/bash

#url >$1, "1" > $2 to change char "{}.:,=-" to _
home="./"
pfn=$home"2.txt"
ch=$2
curl -s "http://"$1"/metrics" > $home"1.txt"
cat $home"1.txt" | sed 's/"/\-/g' > $pfn
str_col=$(grep -c -E ".*" $pfn)
#echo "str_col="$str_col
pp=","
grep -v "\#" $home"3.txt" > $home"4.txt"
for (( i=1;i<=$str_col;i++)); do
test=$(sed -n $i"p" $pfn | tr -d '\r')
#echo "test="$test
if ! [ "$(echo $test | grep "\#")" ]; then
echo "    {" >> $home"4.txt"
x1=`echo $test | awk '{print $1}'`
if ! [ -z "$ch" ]; then
x1=`echo $x1 | sed 's/{/\_/g' | sed 's/}/\_/g' | sed 's/\./\_/g' | sed 's/\,/\_/g' | sed 's/\:/\_/g' | sed 's/=/\_/g' | sed 's/-/\_/g'`
fi
#echo "x1="$x1
x2=`echo $test | awk '{print $2}'`
#echo "x2="$x2
x3="\""$x1"\": \""$x2"\""
#echo "x3="$x3
echo "      "$x3 >> $home"4.txt"
[ "$i" -eq "$str_col" ] && pp=""
echo "    }"$pp >> $home"4.txt"
fi
done
grep -v "\#" $home"5.txt" >> $home"4.txt"
cat $home"4.txt" | jq '.'
