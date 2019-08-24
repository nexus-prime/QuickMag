#! /bin/bash


## CPU_QuickMag
#
# You must run $bash UpdateDatabaseFiles.sh before running this program to download the necessary data.
#
#
# bash CPU_QuickMag.sh [CPUid] [#hosts] [output]
#
# [CPUid]	:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python and math package
#
# @author nexus-prime
# @version 1.1.2

# Check for help flag
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0`

# You must run 'bash UpdateDatabaseFiles.sh' before running this program to download the necessary data.
#
# bash CPU_QuickMag.sh [CPUid] [#hosts] [output]
#
# [CPUid]	:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
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
CPUid=$1
iters=$2

# Make CPUid uppercase to match the case of the host files
CPUid=$(echo -n "$CPUid" | awk '{ print toupper($0)}')

# Use ripgrep if it is on the system
if which rg 2>&1 > /dev/null ; then
  grepcmd=rg
else
  grepcmd=grep
fi

mypath="$( cd "$(dirname "$0")" ; pwd -P)"

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
declare -a iterationSF=( "0 1 2 3 4 5 6 7 8 9 10 11" ) #( "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17" )
#ProjWithStandForm=( odlk1 srbase yafu tngrid vgtu DD numf nfs pogs universe csg cosmology lhc asteroids rosetta  yoyo wcg dhep)
ProjWithStandForm=( odlk1 srbase yafu tngrid numf nfs universe cosmology lhc rosetta  yoyo wcg )

## Get Top Rac for CPU model
odlk1=$(cat $mypath/HostFiles/CtODLK1hosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
srbase=$(cat $mypath/HostFiles/CtSRBASEhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
yafu=$(cat $mypath/HostFiles/CtYAFUhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
tngrid=$(cat $mypath/HostFiles/CtTNGRIDhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
#vgtu=$(cat $mypath/HostFiles/CtVGTUhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
#DD=$(cat $mypath/HostFiles/CtDDhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters ) # Removed from Whitelist
numf=$(cat $mypath/HostFiles/CtNUMFhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
nfs=$(cat $mypath/HostFiles/CtNFShosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
universe=$(cat $mypath/HostFiles/CtUNIVERSEhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
#csg=$(cat $mypath/HostFiles/CtCSGhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
cosmology=$(cat $mypath/HostFiles/CtCOSMOLOGYhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
lhc=$(cat $mypath/HostFiles/CtLHChosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
rosetta=$(cat $mypath/HostFiles/CtROSETTAhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
yoyo=$(cat $mypath/HostFiles/CtYOYOhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )
wcg=$(cat $mypath/HostFiles/CtWCGhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters ) # 
#dhep=$(cat $mypath/HostFiles/CtDHEPhosts 2>/dev/null | $grepcmd -F "$CPUid" | awk '{print $1}' | grep -Eo "[0-9]+\.[0-9]+" | sort -rn | head -n $iters )  #Project shutdown due to lack of funding


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
odlk1=($odlk1)
srbase=($srbase)
yafu=($yafu)
tngrid=($tngrid)
#vgtu=($vgtu)
#DD=($DD) # Removed from Whitelist
numf=($numf)
nfs=($nfs)
pogs=($pogs)
universe=($universe)
#csg=($csg)
cosmology=($cosmology)
lhc=($lhc)
rosetta=($rosetta)
yoyo=($yoyo)
wcg=($wcg)
#dhep=($dhep)

# Find gridcoin team RAC
TModlk1="$(cat $mypath/TeamFiles/ODLK1team 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMsrbase="$(cat $mypath/TeamFiles/SRBASEteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMyafu="$(cat $mypath/TeamFiles/YAFUteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMtngrid="$(cat $mypath/TeamFiles/TNGRIDteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
#TMvgtu="$(cat $mypath/TeamFiles/VGTUteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
#TMDD="$(cat $mypath/TeamFiles/DDteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")" # Removed from Whitelist
TMnumf="$(cat $mypath/TeamFiles/NUMFteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMnfs="$(cat $mypath/TeamFiles/NFSteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMuniverse="$(cat $mypath/TeamFiles/UNIVERSEteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
#TMcsg="$(cat $mypath/TeamFiles/CSGteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMcosmology="$(cat $mypath/TeamFiles/COSMOLOGYteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMlhc="$(cat $mypath/TeamFiles/LHCteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMrosetta="$(cat $mypath/TeamFiles/ROSETTAteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMyoyo="$(cat $mypath/TeamFiles/YOYOteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"
TMwcg="$(cat $mypath/TeamFiles/WCGteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"  
#TMdhep="$(cat $mypath/TeamFiles/DHEPteam 2>/dev/null | grep -A 3 "<name>Gridcoin</name>" | grep "<expavg_credit>"|grep -Eo "[0-9]+\.[0-9]+")"

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
#TeamRac=( "$TModlk1  $TMsrbase $TMyafu $TMtngrid $TMvgtu $TMDD $TMnumf $TMnfs $TMpogs $TMuniverse $TMcsg $TMcosmology $TMlhc $TMasteroids $TMrosetta $TMyoyo $TMwcg" )
TeamRac=( "$TModlk1  $TMsrbase $TMyafu $TMtngrid $TMDD $TMnumf $TMnfs $TMuniverse $TMcosmology $TMlhc $TMrosetta $TMyoyo $TMwcg" )
TeamRac=($TeamRac)



# Insert table header
echo "Project  |  Top $iters magnitude(s) for $1" > $StatsOut



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
