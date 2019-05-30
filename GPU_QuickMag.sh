#! /bin/bash


## GPU_QuickMag
#
# You must run $bash UpdateDatabaseFiles.sh before running this program to download the necessary data.
#
#
# bash GPU_QuickMag.sh [GPUid] [#hosts] [output]
#
# [GPUid]	:	GPU id string e.g. 'GTX 1080 Ti|1|' (check GPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python
#
# @author nexus-prime
# @version 1.1.1

# Check for help flag
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0`

# You must run 'bash UpdateDatabaseFiles.sh' before running this program to download the necessary data.
#
# bash GPU_QuickMag.sh [GPUid] [#hosts] [output]
#
# [GPUid]	:	GPU id string e.g. 'GTX 1080 Ti|1|' (check GPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python
 "
  exit 0
fi



# Check improper input
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments, check --help"
  exit 2
elif [ $# -gt 3 ]; then
  echo 1>&2 "$0: too many arguments, check --help"
  exit 2
fi

# Rename Inputs
GPUid=$1
iters=$2

# Make GPUid uppercase to match the case of the host files
GPUid=$(echo -n "$GPUid" | awk '{ print toupper($0)}')

mypath="$( cd "$(dirname "$0")" ; pwd -P)"

# Use ripgrep if it is on the system
if which rg 2>&1 > /dev/null ; then
  grepcmd=rg
else
  grepcmd=grep
fi

# Print to terminal?
if [ $# -eq 2 ]; then
	StatsOut=$mypath/return.temp
else
	StatsOut=$3
fi
touch $StatsOut
#Get number of projects on current whitelist
NumWL=$(wget -q -O- https://www.gridcoinstats.eu/project/ | grep 'Included Projects:' | grep -Eo "[0-9]+")

#Declare projects and indexing
declare -a iterationSF=( "0 1 2 3 4 5" )
ProjWithStandForm=( amicable collatz milkyway seti gpug asteroids )

## Get Top Rac for GPU model

nVidSearch=$( echo $GPUid | grep -iE "(GT|Quadro|NVS|TITAN|GeForce|Tesla|RTX)" )

if [ -n "$nVidSearch" ]; then

	amicable=$(cat $mypath/HostFiles/GtAMICABLEhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	collatz=$(cat $mypath/HostFiles/GtCOLLATZhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	#enigma=$(cat $mypath/HostFiles/GtENIGMAhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	#einstein=$(cat $mypath/HostFiles/GtEINSTEINhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	milkyway=$(cat $mypath/HostFiles/GtMWhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n  $iters)
	seti=$(cat $mypath/HostFiles/GtSETIhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	gpug=$(cat $mypath/HostFiles/GtGPUGhosts | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	asteroids=$(cat $mypath/HostFiles/GtASTEROIDShosts 2>/dev/null | $grepcmd -F "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
else

	amicable=$(cat $mypath/HostFiles/GtAMICABLEhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	collatz=$(cat $mypath/HostFiles/GtCOLLATZhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	#enigma=$(cat $mypath/HostFiles/GtENIGMAhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	#einstein=$(cat $mypath/HostFiles/GtEINSTEINhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	milkyway=$(cat $mypath/HostFiles/GtMWhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n  $iters)
	seti=$(cat $mypath/HostFiles/GtSETIhosts | $grepcmd -F "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters)
	eval gpug='$(for i in {1..'$iters'}; do echo -n '"'"'0 '"'"'; done)'
fi

#Check for missing data
for project in $iterationSF
do
	eval CurrentProj='${'${ProjWithStandForm[$project]}'[@]}'

	if [ -z "$CurrentProj" ]; then

		eval "${ProjWithStandForm[$project]}"='$(for i in {1..'$iters'}; do echo -n '"'"'0 '"'"'; done)'
		echo "Missing Host Data: ${ProjWithStandForm[$project]}"
	fi

done
unset CurrentProj
unset project

# Parse string to bash list
amicable=($amicable)
collatz=($collatz)
#enigma=($enigma)
#einstein=($einstein)
milkyway=($milkyway)
seti=($seti)
gpug=($gpug)
asteroids=($asteroids)


# Find gridcoin team RAC
TMamicable="$(cat $mypath/TeamFiles/AMICABLEteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMcollatz="$(cat $mypath/TeamFiles/COLLATZteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
#TMenigma="$(cat $mypath/TeamFiles/ENIGMAteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
#TMeinstein="$(cat $mypath/TeamFiles/EINSTEINteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMmilkyway="$(cat $mypath/TeamFiles/MWteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMseti="$(cat $mypath/TeamFiles/SETIteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMgpug="$(cat $mypath/TeamFiles/GPUGteam | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMasteroids="$(cat $mypath/TeamFiles/ASTEROIDSteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"

# Check for missing data
for project in $iterationSF
do
	eval CurrentProj='${'TM${ProjWithStandForm[$project]}'[@]}'

	if [ -z "$CurrentProj" ]; then
		eval "TM${ProjWithStandForm[$project]}"=9999999999999999 #Set unknown TeamRac to large number
		echo "Missing Team Data: ${ProjWithStandForm[$project]}"
	fi

done
unset CurrentProj
unset project


# Convert team RAC into a list
TeamRac=( "$TMamicable $TMcollatz $TMmilkyway $TMseti $TMgpug $TMasteroids" )
TeamRac=($TeamRac)



# Insert table header
if [ -n "$nVidSearch" ]; then
	echo "Project  |  Top $iters magnitude(s) for Nvidia $1" > $StatsOut
else
	echo "Project  |  Top $iters magnitude(s) for AMD $1" > $StatsOut
fi


# Loop through projects
for project in $iterationSF
do
	#echo ${ProjWithStandForm[$project]}

	MagMult=$(python -c "print (1 * 115000 / $NumWL / float(${TeamRac[$project]}))") # Calculate magnitude multiplier for the project
	eval ProjData='${'${ProjWithStandForm[$project]}'[@]}'

	ProjData=(${ProjData[@]})

	locMag=''
		for jnd in `seq 0 $(($iters-1))`;
		do
			locMag[$jnd]=0.00

			if [[ ${ProjData[$jnd]+abc} ]]; then
				locMag[$jnd]=$(python -c "print(${ProjData[$jnd]}*$MagMult)") 		# Set local magnitude if host RAC data is present
			fi

		done

	printf "${ProjWithStandForm[$project]}" >> $StatsOut 							# Add project name to table
	LC_NUMERIC="en_US.UTF-8" printf " %0.2f" "${locMag[@]}" >> $StatsOut  			# Print host Mag with 2 decimals
	printf "\n"  >> $StatsOut

	unset ProjData
	unset locMag
done

# Print out table if no save location given
if [ $# -eq 2 ]; then
	head -n 1 $mypath/return.temp
	tail -n +2 $mypath/return.temp | column -t -s' '
	rm $mypath/return.temp
fi
