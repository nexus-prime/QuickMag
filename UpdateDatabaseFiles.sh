#! /bin/bash

 # Download host and team data from BOINC projects on the Gridcoin whitelist (and greylist)
#
# bash UpdateDatabaseFiles.sh [Project Type]
#
# [Project Type]	:	Choose which project types to get data for (cpu/gpu/all)
#						[Project Type]=all is default
#
# [debug]			:	Can specify debug to enable progress bars
#
# @author nexus-prime
# @version 2.0.2

# Respond to help flag
 if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0`

# Download host and team data from BOINC projects on the Gridcoin whitelist (and greylist)
#
# bash UpdateDatabaseFiles.sh [Project Type] [debug]
#
# [Project Type]	:	Choose which project types to get (cpu/gpu/all)
#							Default is all
#
# [debug]			:	Can specify debug to enable progress bars
#
 "
  exit 0
fi

set -o pipefail

 # Handle bad inputs
 if [ $# -lt 1 ]; then
	ProjType=all
 else
	ProjType=$1
 fi


 if [ $# -eq 2 ]; then

	 if [ $2 == "-debug" ] || [ $2 == "debug" ] || [ $2 == "-v" ]; then
		PB='--show-progress'
	 else
		PB=''
	 fi

 fi

 mkdir -p TeamFiles
 mkdir -p HostFiles

 if [ "$ProjType" == "all" ]; then
	TotProj=18
 elif [ "$ProjType" == "cpu" ]; then
	TotProj=12
	echo "Skipping gpu projects"
 elif [ "$ProjType" == "gpu" ]; then
	TotProj=6
	echo "Skipping cpu projects"
 elif [ "$ProjType" == "-debug" ] || [ "$ProjType" == "debug" ]|| [ $2 == "-v" ]; then
	TotProj=18
	PB='--show-progress'
	ProjType=all
 else
 	echo 1>&2 "$0: not a valid choice for [Project Type], choices are cpu/gpu/all"
	exit 2
 fi

 # Use ripgrep if it is on the system
 if which rg 2>&1 > /dev/null ; then
   grepcmd=rg
   grepcmde=rg
 else
   grepcmd=grep
   grepcmde="grep -E"
 fi

# Setup for downloading
rm -f fin.temp
touch fin.temp
echo "Starting $TotProj downloads..."
echo ' '

if [ -z "$PB" ];then
	printf "\rProgress: 0%%"
fi
# Download CPU projects
if [ $ProjType == "all" ] || [ $ProjType == "cpu" ]; then

# Clear Old Files
rm -f ./HostFiles/CtODLK1hosts
rm -f ./HostFiles/CtSRBASEhosts
rm -f ./HostFiles/CtYAFUhosts
rm -f ./HostFiles/CtTNGRIDhosts
rm -f ./HostFiles/CtVGTUhosts
rm -f ./HostFiles/CtDDhosts			# No Longer on Whitelist
rm -f ./HostFiles/CtNFShosts
rm -f ./HostFiles/CtNUMFhosts
rm -f ./HostFiles/CtPOGShosts		# Project has ended
rm -f ./HostFiles/CtUNIVERSEhosts
rm -f ./HostFiles/CtCSGhosts
rm -f ./HostFiles/CtCOSMOLOGYhosts
rm -f ./HostFiles/CtLHChosts
rm -f ./HostFiles/CtROSETTAhosts
rm -f ./HostFiles/CtYOYOhosts
rm -f ./HostFiles/CtWCGhosts
rm -f ./HostFiles/CtDHEPhosts		#Project shutdown due to lack of funding

rm -f ./TeamFiles/ODLK1team
rm -f ./TeamFiles/SRBASEteam
rm -f ./TeamFiles/YAFUteam
rm -f ./TeamFiles/TNGRIDteam
rm -f ./TeamFiles/VGTUteam
rm -f ./TeamFiles/DDteam			# No Longer on Whitelist
rm -f ./TeamFiles/NFSteam
rm -f ./TeamFiles/POGSteam			# Project has ended
rm -f ./TeamFiles/UNIVERSEteam
rm -f ./TeamFiles/CSGteam
rm -f ./TeamFiles/COSMOLOGYteam
rm -f ./TeamFiles/LHCteam
rm -f ./TeamFiles/ROSETTAteam
rm -f ./TeamFiles/YOYOteam
rm -f ./TeamFiles/WCGteam
rm -f ./TeamFiles/DHEPteam

# Download New Files
(wget https://boinc.multi-pool.info/latinsquares/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/ODLK1team || echo "Could not download odlk1 teams" >&2 ) &
wait #ODLK doesn't like simultaneous downloads
sleep 1
(wget https://boinc.multi-pool.info/latinsquares/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtODLK1hosts || echo "Could not download odlk1 hosts" >&2 ; echo " " >>fin.temp ) &


(wget http://srbase.my-firewall.org/sr5/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtSRBASEhosts || echo "Could not download srbase hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://srbase.my-firewall.org/sr5/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/SRBASEteam || echo "Could not download srbase teams" >&2 ) &

(wget http://yafu.myfirewall.org/yafu/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtYAFUhosts || echo "Could not download yafu hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://yafu.myfirewall.org/yafu/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/YAFUteam || echo "Could not download yafu teams" >&2 ) &

(wget http://gene.disi.unitn.it/test/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtTNGRIDhosts || echo "Could not download tngrid hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://gene.disi.unitn.it/test/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/TNGRIDteam || echo "Could not download tngrid teams" >&2 ) &

#(wget https://boinc.vgtu.lt/stats/host.gz  -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtVGTUhosts || echo "Could not download vgtu hosts" >&2 ; echo " " >>fin.temp ) &
#(wget https://boinc.vgtu.lt/stats/team.gz  -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/VGTUteam || echo "Could not download vgtu teams" >&2 ) &

# DrugDiscovery@home Blacklisted
#(wget http://boinc.drugdiscoveryathome.com/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtDDhosts || echo "Could not download dd hosts" >&2 ; echo " " >>fin.temp ) &
#(wget http://boinc.drugdiscoveryathome.com/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/DDteam.gz || echo "Could not download dd teams" >&2 ) &

(wget https://escatter11.fullerton.edu/nfs/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtNFShosts || echo "Could not download nfs hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://escatter11.fullerton.edu/nfs/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/NFSteam || echo "Could not download nfs teams" >&2 ) &

(wget https://numberfields.asu.edu/NumberFields/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtNUMFhosts || echo "Could not download numf hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://numberfields.asu.edu/NumberFields/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/NUMFteam || echo "Could not download numf teams" >&2 ) &

(wget https://universeathome.pl/universe/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtUNIVERSEhosts || echo "Could not download universe hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://universeathome.pl/universe/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/UNIVERSEteam || echo "Could not download universe teams" >&2 ) &

#(wget https://csgrid.org/csg/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtCSGhosts || echo "Could not download csg hosts" >&2 ; echo " " >>fin.temp ) &
#(wget https://csgrid.org/csg/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/CSGteam || echo "Could not download csg teams" >&2 ) &

(wget https://cosmologyathome.org/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtCOSMOLOGYhosts || echo "Could not download cosmology hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://cosmologyathome.org/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/COSMOLOGYteam || echo "Could not download cosmology teams" >&2 ) &

(wget https://lhcathome.cern.ch/lhcathome/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtLHChosts || echo "Could not download lhc hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://lhcathome.cern.ch/lhcathome/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/LHCteam || echo "Could not download lhc teams" >&2 ) &

(wget http://boinc.bakerlab.org/rosetta/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtROSETTAhosts || echo "Could not download rosetta hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://boinc.bakerlab.org/rosetta/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/ROSETTAteam || echo "Could not download rosetta teams" >&2 ) &

(wget http://www.rechenkraft.net/yoyo/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtYOYOhosts || echo "Could not download yoyo hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://www.rechenkraft.net/yoyo/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/YOYOteam || echo "Could not download yoyo" >&2 ) &


(wget https://download.worldcommunitygrid.org/boinc/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtWCGhosts || echo "Could not download wcg hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://download.worldcommunitygrid.org/boinc/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/WCGteam || echo "Could not download wcg teams" >&2 ) &

#Project shutdown due to lack of funding (24-8-2019)
#(wget https://www.dhep.ga/boinc/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/DHEPteam || echo "Could not download dhep teams" >&2 ) &
#(wget https://www.dhep.ga/boinc/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<p_model>|<expavg_credit>)" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/CtDHEPhosts || echo "Could not download dhep hosts" >&2 ; echo " " >>fin.temp ) &

else
	:
fi

# Download GPU projects
if [ $ProjType == "all" ] || [ $ProjType == "gpu" ]; then

# Clear Old Files
rm -f ./HostFiles/GtAMICABLEhosts
rm -f ./HostFiles/GtCOLLATZhosts
rm -f ./HostFiles/GtEINSTEINhosts
rm -f ./HostFiles/GtENIGMAhosts
rm -f ./HostFiles/GtGPUGhosts
rm -f ./HostFiles/GtMWhosts
rm -f ./HostFiles/GtPGRIDhosts
rm -f ./HostFiles/GtSETIhosts
rm -f ./HostFiles/GtASTEROIDShosts

rm -f ./TeamFiles/AMICABLEteam
rm -f ./TeamFiles/COLLATZteam
rm -f ./TeamFiles/EINSTEINteam
rm -f ./TeamFiles/ENIGMAteam
rm -f ./TeamFiles/GPUGteam
rm -f ./TeamFiles/MWteam
rm -f ./TeamFiles/PGRIDteam
rm -f ./TeamFiles/SETIteam
rm -f ./TeamFiles/ASTEROIDSteam

# Download New Files

(wget https://sech.me/boinc/Amicable/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtAMICABLEhosts || echo "Could not download amicable hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://sech.me/boinc/Amicable/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/AMICABLEteam || echo "Could not download Amicable teams" >&2 ) &

(wget http://boinc.thesonntags.com/collatz/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtCOLLATZhosts || echo "Could not download collatz hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://boinc.thesonntags.com/collatz/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/COLLATZteam || echo "Could not download Collatz teams" >&2 ) &

#(wget https://einsteinathome.org/stats/host_id.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtEINSTEINhosts || echo "Could not download einstein hosts" >&2 ; echo " " >>fin.temp ) &
#(wget https://einsteinathome.org/stats/team_id.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/EINSTEINteam || echo "Could not download Einstein teams" >&2 ) &

#(wget http://www.enigmaathome.net/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtENIGMAhosts || echo "Could not download enigma hosts" >&2 ; echo " " >>fin.temp ) &
#(wget http://www.enigmaathome.net/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/ENIGMAteam || echo "Could not download enigma teams" >&2 ) &

(wget https://www.gpugrid.net/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtGPUGhosts || echo "Could not download gpug hosts" >&2 ; echo " " >>fin.temp ) &
(wget https://www.gpugrid.net/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/GPUGteam || echo "Could not download gpug teams" >&2 ) &

(wget http://milkyway.cs.rpi.edu/milkyway/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtMWhosts || echo "Could not download milkyway hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://milkyway.cs.rpi.edu/milkyway/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/MWteam || echo "Could not download milkyway teams" >&2 ) &

# PrimeGrid Blacklisted (04-11-2018)
#(wget http://23.253.170.196/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtPGRIDhosts || echo "Could not download pgrid hosts" >&2 ; echo " " >>fin.temp ) &
#(wget http://23.253.170.196/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/PGRIDteam || echo "Could not download pgrid teams" >&2 ) &

(wget http://setiathome.ssl.berkeley.edu/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/SETIteam || echo "Could not download seti teams" >&2 ) &
sleep 10
(wget http://setiathome.ssl.berkeley.edu/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtSETIhosts || echo "Could not download seti hosts" >&2 ; echo " " >>fin.temp ) &

(wget http://asteroidsathome.net/boinc/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(<coprocs>|<expavg_credit>)" | $grepcmd -B 1 "<coprocs>" | $grepcmd -v "^--$" | sed 'N;s/\n/ /' | awk '{print toupper($0)}' > ./HostFiles/GtASTEROIDShosts || echo "Could not download asteroids hosts" >&2 ; echo " " >>fin.temp ) &
(wget http://asteroidsathome.net/boinc/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/ASTEROIDSteam || echo "Could not download asteroids teams" >&2 ) &

else
	:
fi

# Wait for download and decompress to finish
count=0

if [ -z "$PB" ];then

 while [  $count -lt $TotProj ]; do
	count=$(wc -l < fin.temp)

	 percent=$( awk "BEGIN { pc=100*${count}/${TotProj}; i=int(pc); print (pc-i<0.5)?i:i+1 }" )

	 printf "\rProgress: $percent%%"

	 sleep 1

 done

 fi

 wait
echo " "

# Cleanup
rm fin.temp
rm -f *.gz
rm -f ./HostFiles/*.gz
rm -f ./TeamFiles/*.gz
