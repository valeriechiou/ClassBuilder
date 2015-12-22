#!/bin/sh
#
# Course: CS 100 Summer Session II 2015
# First Name: Valerie
# Last Name: Chiou
# Username: vchio001
# Email Address: vchio001@ucr.edu
# SID: 861102819
#
# AssignmentID: hw1
# Filename: InsertLibrary.sh 
#
# I hereby certify that the contents of this file represent
# my own original individual work. Nowhere herein is there
# code from any outside resources such as another individual,
# a website, or publishings unless specifically designated as 
# permissible by the instructor or TA.
# I also understand that by cheating, stealing, plagiarism or 
# any other form of academic misconduct defined at
# http://conduct.ucr.edu/policies/academicintegrity.html,
# the consequences will be an F in the class, and additional
# disciplinary sanctions, such as the dismissal from UCR.
#
#
# Name:		InsertLibrary.sh
# Input:	<Param1>: one-column file (zero,1 to several libraries)
# 		<Param2>: library name
# Output:	InsertLibrary.sh will append library name at end of $1
# Note:		If library name is 0, terminate w/o doing anything
#
#		./InsertLibrary.sh listlibraries.txt libraryName
#		$0		    $1	               $2

if [ $# -ne 2 ]; then
	echo -e “Usage: $0 \<listLibraries.txt\> \<libraryName\>”
	exit
fi


libPresent=`./IsLibraryPresent.sh $1 $2`

if [ "$2" == "0" ]; then    #no library  
    echo 0
    exit
elif [ "$libPresent" -eq 1 ]; then  #library is present
    echo 1	   
    exit
elif [ "$libPresent" -eq -1 ]; then #library not present
    echo -1
	#>&2 echo “2: $2”
    echo $2 >> $1
fi
