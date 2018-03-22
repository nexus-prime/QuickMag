CPU_QuickMag is a method for determining the approximate performance of a given CPU on all Gridcoin whitelisted projects.
Requires: python

Steps for running code:

    bash UpdateDatabaseFiles.sh cpu
    
    bash CPU_QuickMag.sh [CPUid] [#hosts] [output]
 
Script details:

__________________________________________________________________________________________________________________
bash UpdateDatabaseFiles.sh [Project Type] [debug]
    
    [Project Type]	:	Choose which project types to get data for (cpu/gpu/all)
    [debug]		:	Can specify debug to enable progress bars
    
UpdateDatabaseFiles.sh downloads host and team data from the various BOINC projects on the Gridcoin whitlist
and saves the needed data to the local computer. 

__________________________________________________________________________________________________________________


bash CPU_QuickMag.sh [CPUid] [#hosts] [output]

    [CPUid]		:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
    
    [#hosts]	: 	number of hosts to return data for
    
    [output]	:	save output to file name (optional)
    
CPU_QuickMag.sh reads the host and team data files to find the magnitude of the top [#hosts] hosts using the specified CPU model.
The data can be saved to a specified output file or printed to the terminal if [output] is not specified.
__________________________________________________________________________________________________________________

CPUlist.data
File contains the names of common CPU models formatted to work with CPU_QuickMag.sh
Note that spaces need to be preserved, for example 'i7-6700' will return a mix of 'i7-6700 ' and 'i7-6700K'

Project name abbreviations:

		odlk1 		Odlk1

		srbase 		Srbase

		yafu 		Yafu

		tngrid 		Tn-grid

		vgtu 		Vgtu Project@home

		DD 		Drugdiscovery@home

		numf 		Numberfields@home
		
		nfs 		Nfs@home

		pogs 		Theskynet Pogs

		universe 	Universe@home

		csg 		Citizen Science Grid

		cosmology 	Cosmology@home

		lhc		Lhc@home Classic
		
		asteroids 	Asteroids@home

		rosetta  	Rosetta@home

		yoyo 		Yoyo@home

		wcg		World Community Grid
