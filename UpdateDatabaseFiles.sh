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
# @version 1.5
 
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
# @author nexusgroup
# @version 1.4
 "
  exit 0
fi

 
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
	TotProj=22
 elif [ "$ProjType" == "cpu" ]; then
	TotProj=14
	echo "Skipping gpu projects"
 elif [ "$ProjType" == "gpu" ]; then
	TotProj=8
	echo "Skipping cpu projects"
 elif [ "$ProjType" == "-debug" ] || [ "$ProjType" == "debug" ]|| [ $2 == "-v" ]; then
	TotProj=22
	PB='--show-progress'	
	ProjType=all
 else
 	echo 1>&2 "$0: not a valid choice for [Project Type], choices are cpu/gpu/all"
	exit 2
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
rm -f ./HostFiles/tODLK1hosts
rm -f ./HostFiles/tSRBASEhosts
rm -f ./HostFiles/tYAFUhosts
rm -f ./HostFiles/tTNGRIDhosts
rm -f ./HostFiles/tVGTUhosts
rm -f ./HostFiles/tDDhosts			# No Longer on Whitelist
rm -f ./HostFiles/tNFShosts
rm -f ./HostFiles/tNUMFhosts
rm -f ./HostFiles/tPOGShosts		# Project has ended
rm -f ./HostFiles/tUNIVERSEhosts
rm -f ./HostFiles/tCSGhosts
rm -f ./HostFiles/tCOSMOLOGYhosts
rm -f ./HostFiles/tLHChosts
rm -f ./HostFiles/tASTEROIDShosts
rm -f ./HostFiles/tROSETTAhosts
rm -f ./HostFiles/tYOYOhosts
rm -f ./HostFiles/tWCGhosts

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
rm -f ./TeamFiles/ASTEROIDSteam
rm -f ./TeamFiles/ROSETTAteam
rm -f ./TeamFiles/YOYOteam
rm -f ./TeamFiles/WCGteam


# Download New Files
(wget https://boinc.multi-pool.info/latinsquares/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ODLK1team.gz && gunzip -f  ./TeamFiles/ODLK1team.gz )&
sleep 10
(wget https://boinc.multi-pool.info/latinsquares/stats/host.gz -t 4 $PB -q -O ODLK1hosts.gz && gunzip -f  ODLK1hosts.gz && tac ODLK1hosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtODLK1hosts && rm ODLK1hosts ; echo " " >>fin.temp )&


(wget http://srbase.my-firewall.org/sr5/stats/host.gz -t 4 $PB -q -O SRBASEhosts.gz && gunzip -f  SRBASEhosts.gz && tac SRBASEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtSRBASEhosts && rm SRBASEhosts ; echo " " >>fin.temp )&
(wget http://srbase.my-firewall.org/sr5/stats/team.gz -t 4 $PB -q -O ./TeamFiles/SRBASEteam.gz && gunzip -f  ./TeamFiles/SRBASEteam.gz  )&

(wget http://yafu.myfirewall.org/yafu/stats/host.gz -t 4 $PB -q -O YAFUhosts.gz && gunzip -f  YAFUhosts.gz  && tac YAFUhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtYAFUhosts && rm YAFUhosts ; echo " " >>fin.temp )&
(wget http://yafu.myfirewall.org/yafu/stats/team.gz -t 4 $PB -q -O ./TeamFiles/YAFUteam.gz && gunzip -f  ./TeamFiles/YAFUteam.gz )&

(wget http://gene.disi.unitn.it/test/stats/host.gz -t 4 $PB -q -O TNGRIDhosts.gz && gunzip -f  TNGRIDhosts.gz  && tac TNGRIDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtTNGRIDhosts && rm TNGRIDhosts ; echo " " >>fin.temp )&
(wget http://gene.disi.unitn.it/test/stats/team.gz -t 4 $PB -q -O ./TeamFiles/TNGRIDteam.gz && gunzip -f  ./TeamFiles/TNGRIDteam.gz  )&

(wget https://boinc.vgtu.lt/stats/host.gz  -t 4 $PB -q -O VGTUhosts.gz && gunzip -f  VGTUhosts.gz && tac VGTUhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtVGTUhosts && rm VGTUhosts ; echo " " >>fin.temp )&
(wget https://boinc.vgtu.lt/stats/team.gz  -t 4 $PB -q -O ./TeamFiles/VGTUteam.gz && gunzip -f  ./TeamFiles/VGTUteam.gz  )&

# No Longer on Whitelist
#(wget http://boinc.drugdiscoveryathome.com/stats/host.gz -t 4 $PB -q -O DDhosts.gz && gunzip -f  DDhosts.gz  && tac DDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtDDhosts && rm DDhosts ; echo " " >>fin.temp )&
#(wget http://boinc.drugdiscoveryathome.com/stats/team.gz -t 4 $PB -q -O ./TeamFiles/DDteam.gz && gunzip -f  ./TeamFiles/DDteam.gz )& 

(wget https://escatter11.fullerton.edu/nfs/stats/host.gz -t 4 $PB -q -O NFShosts.gz && gunzip -f  NFShosts.gz  && tac NFShosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtNFShosts && rm NFShosts ; echo " " >>fin.temp )&
(wget https://escatter11.fullerton.edu/nfs/stats/team.gz -t 4 $PB -q -O ./TeamFiles/NFSteam.gz && gunzip -f  ./TeamFiles/NFSteam.gz  )&

(wget https://numberfields.asu.edu/NumberFields/stats/host.gz -t 4 $PB -q -O NUMFhosts.gz && gunzip -f  NUMFhosts.gz  && tac NUMFhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtNUMFhosts && rm NUMFhosts ; echo " " >>fin.temp )&
(wget https://numberfields.asu.edu/NumberFields/stats/team.gz -t 4 $PB -q -O ./TeamFiles/NUMFteam.gz && gunzip -f  ./TeamFiles/NUMFteam.gz  )&

(wget https://universeathome.pl/universe/stats/host.gz -t 4 $PB -q -O UNIVERSEhosts.gz && gunzip -f  UNIVERSEhosts.gz  && tac UNIVERSEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtUNIVERSEhosts && rm UNIVERSEhosts ; echo " " >>fin.temp )&
(wget https://universeathome.pl/universe/stats/team.gz -t 4 $PB -q -O ./TeamFiles/UNIVERSEteam.gz && gunzip -f  ./TeamFiles/UNIVERSEteam.gz  )&

(wget https://csgrid.org/csg/stats/host.gz -t 4 $PB -q -O CSGhosts.gz && gunzip -f  CSGhosts.gz  && tac CSGhosts| grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtCSGhosts && rm CSGhosts ; echo " " >>fin.temp )&
(wget https://csgrid.org/csg/stats/team.gz -t 4 $PB -q -O ./TeamFiles/CSGteam.gz && gunzip -f  ./TeamFiles/CSGteam.gz  )&

(wget https://cosmologyathome.org/stats/host.gz -t 4 $PB -q -O COSMOLOGYhosts.gz && gunzip -f  COSMOLOGYhosts.gz   && tac COSMOLOGYhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtCOSMOLOGYhosts && rm COSMOLOGYhosts ; echo " " >>fin.temp )&
(wget https://cosmologyathome.org/stats/team.gz -t 4 $PB -q -O ./TeamFiles/COSMOLOGYteam.gz && gunzip -f  ./TeamFiles/COSMOLOGYteam.gz )&

(wget https://lhcathome.cern.ch/lhcathome/stats/host.gz -t 4 $PB -q -O LHChosts.gz && gunzip -f  LHChosts.gz  && tac LHChosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtLHChosts && rm LHChosts ; echo " " >>fin.temp )&
(wget https://lhcathome.cern.ch/lhcathome/stats/team.gz -t 4 $PB -q -O ./TeamFiles/LHCteam.gz && gunzip -f  ./TeamFiles/LHCteam.gz  )&

(wget http://asteroidsathome.net/boinc/stats/host.gz -t 4 $PB -q -O ASTEROIDShosts.gz && gunzip -f  ASTEROIDShosts.gz   && tac ASTEROIDShosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtASTEROIDShosts && rm ASTEROIDShosts ; echo " " >>fin.temp )&
(wget http://asteroidsathome.net/boinc/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ASTEROIDSteam.gz && gunzip -f  ./TeamFiles/ASTEROIDSteam.gz )& 

(wget http://boinc.bakerlab.org/rosetta/stats/host.gz -t 4 $PB -q -O ROSETTAhosts.gz && gunzip -f  ROSETTAhosts.gz && tac ROSETTAhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtROSETTAhosts && rm ROSETTAhosts ; echo " " >>fin.temp )&
(wget http://boinc.bakerlab.org/rosetta/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ROSETTAteam.gz && gunzip -f  ./TeamFiles/ROSETTAteam.gz  )&

(wget http://www.rechenkraft.net/yoyo/stats/host.gz -t 4 $PB -q -O YOYOhosts.gz && gunzip -f  YOYOhosts.gz && tac YOYOhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtYOYOhosts && rm YOYOhosts ; echo " " >>fin.temp )&
(wget http://www.rechenkraft.net/yoyo/stats/team.gz -t 4 $PB -q -O ./TeamFiles/YOYOteam.gz && gunzip -f  ./TeamFiles/YOYOteam.gz )&

# Temporarily unable to download stats
#(wget https://download.worldcommunitygrid.org/boinc/stats/host.gz -t 4 $PB -q -O WCGhosts.gz && gunzip -f WCGhosts.gz && tac WCGhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/CtWCGhosts && rm WCGhosts ; echo " " >>fin.temp )&
#(wget https://download.worldcommunitygrid.org/boinc/stats/team.gz -t 4 $PB -q -O ./TeamFiles/WCGteam.gz && gunzip -f ./TeamFiles/WCGteam.gz  )&

else
	:
fi

# Download GPU projects
if [ $ProjType == "all" ] || [ $ProjType == "gpu" ]; then

# Clear Old Files 
rm -f ./HostFiles/tAMICABLEhosts
rm -f ./HostFiles/tCOLLATZhosts
rm -f ./HostFiles/tEINSTEINhosts
rm -f ./HostFiles/tENIGMAhosts
rm -f ./HostFiles/tGPUGhosts
rm -f ./HostFiles/tMWhosts
rm -f ./HostFiles/tPGRIDhosts
rm -f ./HostFiles/tSETIhosts


rm -f ./TeamFiles/AMICABLEteam
rm -f ./TeamFiles/COLLATZteam
rm -f ./TeamFiles/EINSTEINteam
rm -f ./TeamFiles/ENIGMAteam
rm -f ./TeamFiles/GPUGteam
rm -f ./TeamFiles/MWteam
rm -f ./TeamFiles/PGRIDteam
rm -f ./TeamFiles/SETIteam


# Download New Files

(wget https://sech.me/boinc/Amicable/stats/host.gz -t 4 $PB -q -O AMICABLEhosts.gz && gunzip -f  AMICABLEhosts.gz && tac AMICABLEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtAMICABLEhosts && rm AMICABLEhosts ; echo " " >>fin.temp )&
(wget https://sech.me/boinc/Amicable/stats/team.gz -t 4 $PB -q -O ./TeamFiles/AMICABLEteam.gz && gunzip -f  ./TeamFiles/AMICABLEteam.gz  )&

(wget http://boinc.thesonntags.com/collatz/stats/host.gz -t 4 $PB -q -O COLLATZhosts.gz && gunzip -f  COLLATZhosts.gz   && tac COLLATZhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtCOLLATZhosts && rm COLLATZhosts ; echo " " >>fin.temp )&
(wget http://boinc.thesonntags.com/collatz/stats/team.gz -t 4 $PB -q -O ./TeamFiles/COLLATZteam.gz && gunzip -f  ./TeamFiles/COLLATZteam.gz )& 

(wget https://einsteinathome.org/stats/host_id.gz -t 4 $PB -q -O EINSTEINhosts.gz && gunzip -f  EINSTEINhosts.gz   && tac EINSTEINhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtEINSTEINhosts && rm EINSTEINhosts ; echo " " >>fin.temp )&
(wget https://einsteinathome.org/stats/team_id.gz -t 4 $PB -q -O ./TeamFiles/EINSTEINteam.gz && gunzip -f  ./TeamFiles/EINSTEINteam.gz  )&

(wget http://www.enigmaathome.net/stats/host.gz -t 4 $PB -q -O ENIGMAhosts.gz && gunzip -f  ENIGMAhosts.gz  && tac ENIGMAhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtENIGMAhosts && rm ENIGMAhosts ; echo " " >>fin.temp )&
(wget http://www.enigmaathome.net/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ENIGMAteam.gz && gunzip -f  ./TeamFiles/ENIGMAteam.gz  )&

(wget https://www.gpugrid.net/stats/host.gz -t 4 $PB -q -O GPUGhosts.gz && gunzip -f  GPUGhosts.gz && tac GPUGhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtGPUGhosts && rm GPUGhosts ; echo " " >>fin.temp )&
(wget https://www.gpugrid.net/stats/team.gz -t 4 $PB -q -O ./TeamFiles/GPUGteam.gz && gunzip -f  ./TeamFiles/GPUGteam.gz  )&

(wget http://milkyway.cs.rpi.edu/milkyway/stats/host.gz -t 4 $PB -q -O MWhosts.gz && gunzip -f  MWhosts.gz  && tac MWhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtMWhosts && rm MWhosts ; echo " " >>fin.temp )&
(wget http://milkyway.cs.rpi.edu/milkyway/stats/team.gz -t 4 $PB -q -O ./TeamFiles/MWteam.gz && gunzip -f  ./TeamFiles/MWteam.gz  )&

(wget http://23.253.170.196/stats/host.gz -t 4 $PB -q -O PGRIDhosts.gz && gunzip -f  PGRIDhosts.gz  && tac PGRIDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtPGRIDhosts && rm PGRIDhosts ; echo " " >>fin.temp )&
(wget http://23.253.170.196/stats/team.gz -t 4 $PB -q -O ./TeamFiles/PGRIDteam.gz && gunzip -f  ./TeamFiles/PGRIDteam.gz )& 

(wget http://setiathome.ssl.berkeley.edu/stats/team.gz -t 4 $PB -q -O ./TeamFiles/SETIteam.gz && gunzip -f  ./TeamFiles/SETIteam.gz  ) &
sleep 10
(wget http://setiathome.ssl.berkeley.edu/stats/host.gz -t 4 $PB -q -O SETIhosts.gz  && gunzip -f  SETIhosts.gz && tac SETIhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/GtSETIhosts && rm SETIhosts ; echo " " >>fin.temp )&


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

