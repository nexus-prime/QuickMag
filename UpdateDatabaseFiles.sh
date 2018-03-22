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
# @version 1.4
 
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
 
 
 if [ $# -gt 2 ]; then
 
	 if [ $2 == "-debug" ] || [ $2 == "debug" ] || [ $2 == "-v" ]; then
		PB='--show-progress'
	 else
		PB=''
	 fi
	 
 fi	 
 
 mkdir -p TeamFiles
 mkdir -p HostFiles
 
 if [ "$ProjType" == "all" ]; then
	TotProj=25
 elif [ "$ProjType" == "cpu" ]; then
	TotProj=17
	echo "Skipping gpu projects"
 elif [ "$ProjType" == "gpu" ]; then
	TotProj=8
	echo "Skipping cpu projects"
 elif [ "$ProjType" == "-debug" ] || [ "$ProjType" == "debug" ]|| [ $2 == "-v" ]; then
	TotProj=25
	PB='--show-progress'	
	ProjType=all
 else
 	echo 1>&2 "$0: not a valid choice for [Project Type], choices are cpu/gpu/all"
	exit 2
 fi
 
# Clear Old Files 
rm -f ./HostFiles/*hosts
rm -f ./TeamFiles/*team
 
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

(wget https://boinc.multi-pool.info/latinsquares/stats/host.gz -t 4 $PB -q -O ODLK1hosts.gz && gunzip -f  ODLK1hosts.gz && tac ODLK1hosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tODLK1hosts && rm ODLK1hosts ; echo " " >>fin.temp )&
sleep 1
(wget https://boinc.multi-pool.info/latinsquares/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ODLK1team.gz && gunzip -f  ./TeamFiles/ODLK1team.gz )&

(wget http://srbase.my-firewall.org/sr5/stats/host.gz -t 4 $PB -q -O SRBASEhosts.gz && gunzip -f  SRBASEhosts.gz && tac SRBASEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tSRBASEhosts && rm SRBASEhosts ; echo " " >>fin.temp )&
(wget http://srbase.my-firewall.org/sr5/stats/team.gz -t 4 $PB -q -O ./TeamFiles/SRBASEteam.gz && gunzip -f  ./TeamFiles/SRBASEteam.gz  )&

(wget http://yafu.myfirewall.org/yafu/stats/host.gz -t 4 $PB -q -O YAFUhosts.gz && gunzip -f  YAFUhosts.gz  && tac YAFUhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tYAFUhosts && rm YAFUhosts ; echo " " >>fin.temp )&
(wget http://yafu.myfirewall.org/yafu/stats/team.gz -t 4 $PB -q -O ./TeamFiles/YAFUteam.gz && gunzip -f  ./TeamFiles/YAFUteam.gz )&

(wget http://gene.disi.unitn.it/test/stats/host.gz -t 4 $PB -q -O TNGRIDhosts.gz && gunzip -f  TNGRIDhosts.gz  && tac TNGRIDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tTNGRIDhosts && rm TNGRIDhosts ; echo " " >>fin.temp )&
(wget http://gene.disi.unitn.it/test/stats/team.gz -t 4 $PB -q -O ./TeamFiles/TNGRIDteam.gz && gunzip -f  ./TeamFiles/TNGRIDteam.gz  )&

(wget https://boinc.vgtu.lt/stats/host.gz  -t 4 $PB -q -O VGTUhosts.gz && gunzip -f  VGTUhosts.gz && tac VGTUhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tVGTUhosts && rm VGTUhosts ; echo " " >>fin.temp )&
(wget https://boinc.vgtu.lt/stats/team.gz  -t 4 $PB -q -O ./TeamFiles/VGTUteam.gz && gunzip -f  ./TeamFiles/VGTUteam.gz  )&

(wget http://boinc.drugdiscoveryathome.com/stats/host.gz -t 4 $PB -q -O DDhosts.gz && gunzip -f  DDhosts.gz  && tac DDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tDDhosts && rm DDhosts ; echo " " >>fin.temp )&
(wget http://boinc.drugdiscoveryathome.com/stats/team.gz -t 4 $PB -q -O ./TeamFiles/DDteam.gz && gunzip -f  ./TeamFiles/DDteam.gz )& 

(wget https://escatter11.fullerton.edu/nfs/stats/host.gz -t 4 $PB -q -O NFShosts.gz && gunzip -f  NFShosts.gz  && tac NFShosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tNFShosts && rm NFShosts ; echo " " >>fin.temp )&
(wget https://escatter11.fullerton.edu/nfs/stats/team.gz -t 4 $PB -q -O ./TeamFiles/NFSteam.gz && gunzip -f  ./TeamFiles/NFSteam.gz  )&

(wget https://numberfields.asu.edu/NumberFields/stats/host.gz -t 4 $PB -q -O NUMFhosts.gz && gunzip -f  NUMFhosts.gz  && tac NUMFhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tNUMFhosts && rm NUMFhosts ; echo " " >>fin.temp )&
(wget https://numberfields.asu.edu/NumberFields/stats/team.gz -t 4 $PB -q -O ./TeamFiles/NUMFteam.gz && gunzip -f  ./TeamFiles/NUMFteam.gz  )&

(wget http://pogs.theskynet.org/pogs/stats/host.gz -t 4 $PB -q -O POGShosts.gz && gunzip -f  POGShosts.gz  && tac POGShosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tPOGShosts && rm POGShosts ; echo " " >>fin.temp )&
(wget http://pogs.theskynet.org/pogs/stats/team.gz -t 4 $PB -q -O ./TeamFiles/POGSteam.gz && gunzip -f  ./TeamFiles/POGSteam.gz )& 

(wget https://universeathome.pl/universe/stats/host.gz -t 4 $PB -q -O UNIVERSEhosts.gz && gunzip -f  UNIVERSEhosts.gz  && tac UNIVERSEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tUNIVERSEhosts && rm UNIVERSEhosts ; echo " " >>fin.temp )&
(wget https://universeathome.pl/universe/stats/team.gz -t 4 $PB -q -O ./TeamFiles/UNIVERSEteam.gz && gunzip -f  ./TeamFiles/UNIVERSEteam.gz  )&

(wget https://csgrid.org/csg/stats/host.gz -t 4 $PB -q -O CSGhosts.gz && gunzip -f  CSGhosts.gz  && tac CSGhosts| grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tCSGhosts && rm CSGhosts ; echo " " >>fin.temp )&
(wget https://csgrid.org/csg/stats/team.gz -t 4 $PB -q -O ./TeamFiles/CSGteam.gz && gunzip -f  ./TeamFiles/CSGteam.gz  )&

(wget https://cosmologyathome.org/stats/host.gz -t 4 $PB -q -O COSMOLOGYhosts.gz && gunzip -f  COSMOLOGYhosts.gz   && tac COSMOLOGYhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tCOSMOLOGYhosts && rm COSMOLOGYhosts ; echo " " >>fin.temp )&
(wget https://cosmologyathome.org/stats/team.gz -t 4 $PB -q -O ./TeamFiles/COSMOLOGYteam.gz && gunzip -f  ./TeamFiles/COSMOLOGYteam.gz )&

(wget https://lhcathome.cern.ch/lhcathome/stats/host.gz -t 4 $PB -q -O LHChosts.gz && gunzip -f  LHChosts.gz  && tac LHChosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tLHChosts && rm LHChosts ; echo " " >>fin.temp )&
(wget https://lhcathome.cern.ch/lhcathome/stats/team.gz -t 4 $PB -q -O ./TeamFiles/LHCteam.gz && gunzip -f  ./TeamFiles/LHCteam.gz  )&

(wget http://asteroidsathome.net/boinc/stats/host.gz -t 4 $PB -q -O ASTEROIDShosts.gz && gunzip -f  ASTEROIDShosts.gz   && tac ASTEROIDShosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tASTEROIDShosts && rm ASTEROIDShosts ; echo " " >>fin.temp )&
(wget http://asteroidsathome.net/boinc/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ASTEROIDSteam.gz && gunzip -f  ./TeamFiles/ASTEROIDSteam.gz )& 

(wget http://boinc.bakerlab.org/rosetta/stats/host.gz -t 4 $PB -q -O ROSETTAhosts.gz && gunzip -f  ROSETTAhosts.gz && tac ROSETTAhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tROSETTAhosts && rm ROSETTAhosts ; echo " " >>fin.temp )&
(wget http://boinc.bakerlab.org/rosetta/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ROSETTAteam.gz && gunzip -f  ./TeamFiles/ROSETTAteam.gz  )&

(wget http://www.rechenkraft.net/yoyo/stats/host.gz -t 4 $PB -q -O YOYOhosts.gz && gunzip -f  YOYOhosts.gz && tac YOYOhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tYOYOhosts && rm YOYOhosts ; echo " " >>fin.temp )&
(wget http://www.rechenkraft.net/yoyo/stats/team.gz -t 4 $PB -q -O ./TeamFiles/YOYOteam.gz && gunzip -f  ./TeamFiles/YOYOteam.gz )&

(wget https://download.worldcommunitygrid.org/boinc/stats/host.gz -t 4 $PB -q -O WCGhosts.gz && gunzip -f WCGhosts.gz && tac WCGhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tWCGhosts && rm WCGhosts ; echo " " >>fin.temp )&
(wget https://download.worldcommunitygrid.org/boinc/stats/team.gz -t 4 $PB -q -O ./TeamFiles/WCGteam.gz && gunzip -f ./TeamFiles/WCGteam.gz  )&

else
	:
fi

# Download GPU projects
if [ $ProjType == "all" ] || [ $ProjType == "gpu" ]; then

(wget https://sech.me/boinc/Amicable/stats/host.gz -t 4 $PB -q -O AMICABLEhosts.gz && gunzip -f  AMICABLEhosts.gz && tac AMICABLEhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tAMICABLEhosts && rm AMICABLEhosts ; echo " " >>fin.temp )&
(wget https://sech.me/boinc/Amicable/stats/team.gz -t 4 $PB -q -O ./TeamFiles/AMICABLEteam.gz && gunzip -f  ./TeamFiles/AMICABLEteam.gz  )&

(wget http://boinc.thesonntags.com/collatz/stats/host.gz -t 4 $PB -q -O COLLATZhosts.gz && gunzip -f  COLLATZhosts.gz   && tac COLLATZhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tCOLLATZhosts && rm COLLATZhosts ; echo " " >>fin.temp )&
(wget http://boinc.thesonntags.com/collatz/stats/team.gz -t 4 $PB -q -O ./TeamFiles/COLLATZteam.gz && gunzip -f  ./TeamFiles/COLLATZteam.gz )& 

(wget https://einsteinathome.org/stats/host_id.gz -t 4 $PB -q -O EINSTEINhosts.gz && gunzip -f  EINSTEINhosts.gz   && tac EINSTEINhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tEINSTEINhosts && rm EINSTEINhosts ; echo " " >>fin.temp )&
(wget https://einsteinathome.org/stats/team_id.gz -t 4 $PB -q -O ./TeamFiles/EINSTEINteam.gz && gunzip -f  ./TeamFiles/EINSTEINteam.gz  )&

(wget http://www.enigmaathome.net/stats/host.gz -t 4 $PB -q -O ENIGMAhosts.gz && gunzip -f  ENIGMAhosts.gz  && tac ENIGMAhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tENIGMAhosts && rm ENIGMAhosts ; echo " " >>fin.temp )&
(wget http://www.enigmaathome.net/stats/team.gz -t 4 $PB -q -O ./TeamFiles/ENIGMAteam.gz && gunzip -f  ./TeamFiles/ENIGMAteam.gz  )&

(wget https://www.gpugrid.net/stats/host.gz -t 4 $PB -q -O GPUGhosts.gz && gunzip -f  GPUGhosts.gz && tac GPUGhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tGPUGhosts && rm GPUGhosts ; echo " " >>fin.temp )&
(wget https://www.gpugrid.net/stats/team.gz -t 4 $PB -q -O ./TeamFiles/GPUGteam.gz && gunzip -f  ./TeamFiles/GPUGteam.gz  )&

(wget http://milkyway.cs.rpi.edu/milkyway/stats/host.gz -t 4 $PB -q -O MWhosts.gz && gunzip -f  MWhosts.gz  && tac MWhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tMWhosts && rm MWhosts ; echo " " >>fin.temp )&
(wget http://milkyway.cs.rpi.edu/milkyway/stats/team.gz -t 4 $PB -q -O ./TeamFiles/MWteam.gz && gunzip -f  ./TeamFiles/MWteam.gz  )&

(wget http://23.253.170.196/stats/host.gz -t 4 $PB -q -O PGRIDhosts.gz && gunzip -f  PGRIDhosts.gz  && tac PGRIDhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tPGRIDhosts && rm PGRIDhosts ; echo " " >>fin.temp )&
(wget http://23.253.170.196/stats/team.gz -t 4 $PB -q -O ./TeamFiles/PGRIDteam.gz && gunzip -f  ./TeamFiles/PGRIDteam.gz )& 

(wget http://setiathome.ssl.berkeley.edu/stats/host.gz -t 4 $PB -q -O SETIhosts.gz  && gunzip -f  SETIhosts.gz && tac SETIhosts | grep -vE "(n_bwdown|n_bwup|d_free|vbox_version|boinc_version|d_total|m_swap|m_cache|m_nbytes|turnaround|rpc_time|p_vendor|timezone|credit_per_cpu_sec|p_membw|p_iops|p_fpops|expavg_time|os_version|os_name|host_cpid|<host>|total_credit)"> ./HostFiles/tSETIhosts && rm SETIhosts ; echo " " >>fin.temp )&
(wget http://setiathome.ssl.berkeley.edu/stats/team.gz -t 4 $PB -q -O ./TeamFiles/SETIteam.gz && gunzip -f  ./TeamFiles/SETIteam.gz  ) &

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

