#!/bin/bash

#url >$1, "1" > $2 to change char "{}.:,=-" to _
home="./"
pfn=$home"2.txt"
ch=$2
[ -z "$ch" ] && ch=0
re='^[0-9]+$'
if ! [[ $ch =~ $re ]] ; then
   echo "error: 2 arg not a number" >&2; exit 1
fi


check_expo()
{

var=$1

if [ -n "$var" ] && [ "$var" -eq "$var" ] 2>/dev/null; then
  echo "====================is number"
else
  echo "====================not a number"
fi


}

expo() 
{

ttest=`echo $x2 | sed 's/e/\ /g' | sed 's/+/\ /g' | sed 's/\./\ /g' | sed 's/\-/\ /g' | sed 's/\ /1/g'`
echo "===================="$ttest

if [ -n "$ttest" ] && [ "$ttest" -eq "$ttest" ] 2>/dev/null; then
  echo "====================is number"
  lenin=${#x2}
	pexpo "e-";
	if [ "$prefix1" == "$x2" ]; then
	pexpo "e+";
	flexpo "+";
	else
	[ "$prefix1" == "$x2" ] && breack;
	flexpo "-";
	fi
else
  echo "====================not a number"
fi

}
pexpo()
{
prefix1=${x2%%$1*}
echo "prefix1="$prefix1
}
flexpo()
{
fire=0
ss0=${x2:$((lenin-2)):2}
ss1=${ss0:0:1}
ss2=${ss0:1:1}
fire=$(((ss1*10)+ss2))
tmpn="0000000000000000000000000000000000000"

prefix3=$(echo $prefix1 | awk -F"." '{print $1}' )
prefix4=$(echo $prefix1 | awk -F"." '{print $2}' )


if [ "$1" == "+" ]; then
leninp4=${#prefix4}

if [ "$leninp4" -gt "$fire" ]; then
ss3=${prefix4:0:$fire}
ss4=${prefix4:$fire:$((leninp4-fire))}
fire2=$prefix3$ss3"."$ss4
fi
if [ "$fire" -gt "$leninp4" ]; then
ss3=${tmpn:0:$((fire-leninp4))}
fire2=$prefix3$ss3
fi
if [ "$fire" -eq "$leninp4" ]; then
fire2=$prefix3$prefix4
fi

else
leninm=${#prefix3}
if [ "$leninm" -gt "$fire" ]; then
ss3=${prefix3:0:$((leninm-fire))}
ss4=${prefix3:$((leninm-fire)):$leninm}
fire2=$ss3"."$ss4$prefix4
fi
if [ "$fire" -gt "$leninm" ]; then
ss3=${tmpn:0:$((fire-leninm))}
fire2="0."$ss3$prefix3$prefix4
fi
if [ "$fire" -eq "$leninm" ]; then
fire2="0."$prefix3$prefix4
fi


fi
x2=$fire2

echo "ss0="$ss0",ss1="$ss1",ss2="$ss2",fire="$fire",fire2="$fire2
echo "prefix3="$prefix3
echo "prefix4="$prefix4
echo "ss3="$ss3
echo "ss4="$ss4
echo
}




curl -s "http://"$1"/metrics" > $home"1.txt"
cat $home"1.txt" | sed 's/"/\-/g' > $pfn
str_col=$(grep -c -E ".*" $pfn)
#echo "str_col="$str_col
[ "$ch" -lt "2" ] && grep -v "\#" $home"3.txt" > $home"4.txt"
[ "$ch" -gt "1" ] && echo "{" > $home"4.txt"

for (( i=1;i<=$str_col;i++)); do
pp=","
nn=0
test=$(sed -n $i"p" $pfn | tr -d '\r')
#echo "test="$test
if ! [ "$(echo $test | grep "\#")" ]; then
[ "$ch" -lt "2" ] && echo "    {" >> $home"4.txt"
x1=`echo $test | awk '{print $1}'`
[ "$ch" -gt "0" ] && x1=`echo $x1 | sed 's/{/\_/g' | sed 's/}/\_/g' | sed 's/\./\_/g' | sed 's/\,/\_/g' | sed 's/\:/\_/g' | sed 's/=/\_/g' | sed 's/-/\_/g' | sed 's/\//\_/g'`
#echo "x1="$x1
x2=`echo $test | awk '{print $2}'`
re='^[+-]?[0-9]+([.][0-9]+)?$'
[[ $x2 =~ $re ]] && [ "$ch" -gt "2" ] && nn=1
echo "x2="$x2",nn="$nn

[ "$ch" -gt "3" -a "$nn" -eq "0" ] && expo;

x3="\""$x1"\": \""$x2"\""
[ "$ch" -gt "2" ] && [ "$nn" -eq "1" ] && x3="\""$x1"\": "$x2""
#echo "x3="$x3
echo "      "$x3 >> $home"4.txt"
pref="    }"
[ "$i" -eq "$str_col" ] && pp=""
[ "$ch" -gt "1" ] && pref=""
echo $pref$pp >> $home"4.txt"
fi
done

[ "$ch" -lt "2" ] && grep -v "\#" $home"5.txt" >> $home"4.txt" && cat $home"4.txt" | jq '.'
[ "$ch" -gt "1" ] && echo "}" >> $home"4.txt" && cat $home"4.txt" | tr -s '\r\n' ' ' | tr -d ' ' > $home"jsonp.txt"

