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
# @version 1.0.1

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

# Print to terminal?
if [ $# -eq 2 ]; then
	StatsOut=return.temp
else
	StatsOut=$3
fi

#Get number of projects on current whitelist
NumWL=$(wget -q -O- https://www.gridcoinstats.eu/project/ | grep 'Included Projects:' | grep -Eo "[0-9]+")

#Declare projects and indexing
declare -a iterationSF=( "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16" ) #( "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16" )
ProjWithStandForm=( odlk1 srbase yafu tngrid vgtu DD numf nfs pogs universe csg cosmology lhc asteroids rosetta  yoyo wcg )



## Get Top Rac for CPU model
odlk1=$(cat ./HostFiles/tODLK1hosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
srbase=$(cat ./HostFiles/tSRBASEhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
yafu=$(cat ./HostFiles/tYAFUhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
tngrid=$(cat ./HostFiles/tTNGRIDhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
vgtu=$(cat ./HostFiles/tVGTUhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
DD=$(cat ./HostFiles/tDDhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
numf=$(cat ./HostFiles/tNUMFhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
nfs=$(cat ./HostFiles/tNFShosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
pogs=$(cat ./HostFiles/tPOGShosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
universe=$(cat ./HostFiles/tUNIVERSEhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
csg=$(cat ./HostFiles/tCSGhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
cosmology=$(cat ./HostFiles/tCOSMOLOGYhosts 2>/dev/null |grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
lhc=$(cat ./HostFiles/tLHChosts 2>/dev/null |grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
asteroids=$(cat ./HostFiles/tASTEROIDShosts 2>/dev/null |grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
rosetta=$(cat ./HostFiles/tROSETTAhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
yoyo=$(cat ./HostFiles/tYOYOhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
wcg=$(cat ./HostFiles/tWCGhosts 2>/dev/null | grep -A 4 "$CPUid"|  grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 


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
vgtu=($vgtu)
DD=($DD)
numf=($numf)
nfs=($nfs)
pogs=($pogs)
universe=($universe)
csg=($csg)
cosmology=($cosmology)
lhc=($lhc)
asteroids=($asteroids)
rosetta=($rosetta)
yoyo=($yoyo)
wcg=($wcg) 


# Find gridcoin team RAC
TModlk1="$(cat ./TeamFiles/ODLK1team 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMsrbase="$(cat ./TeamFiles/SRBASEteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMyafu="$(cat ./TeamFiles/YAFUteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMtngrid="$(cat ./TeamFiles/TNGRIDteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMvgtu="$(cat ./TeamFiles/VGTUteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMDD="$(cat ./TeamFiles/DDteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMnumf="$(cat ./TeamFiles/NUMFteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMnfs="$(cat ./TeamFiles/NFSteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMpogs="$(cat ./TeamFiles/POGSteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMuniverse="$(cat ./TeamFiles/UNIVERSEteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMcsg="$(cat ./TeamFiles/CSGteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMcosmology="$(cat ./TeamFiles/COSMOLOGYteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMlhc="$(cat ./TeamFiles/LHCteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMasteroids="$(cat ./TeamFiles/ASTEROIDSteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMrosetta="$(cat ./TeamFiles/ROSETTAteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMyoyo="$(cat ./TeamFiles/YOYOteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"
TMwcg="$(cat ./TeamFiles/WCGteam 2>/dev/null | grep -B 4 -A 3 ">Gridcoin<" | grep "expavg_credit"|grep -Eo "[0-9]+\.[0-9]+")"


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
TeamRac=( "$TModlk1  $TMsrbase $TMyafu $TMtngrid $TMvgtu $TMDD $TMnumf $TMnfs $TMpogs $TMuniverse $TMcsg $TMcosmology $TMlhc $TMasteroids $TMrosetta $TMyoyo $TMwcg" )
TeamRac=($TeamRac)



# Insert table header
echo "Project  |  Top $iters magnitude(s) for $CPUid" > $StatsOut



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
	head -n 1 return.temp
	tail -n +2 return.temp | column -t -s' ' 
	rm return.temp
fi
