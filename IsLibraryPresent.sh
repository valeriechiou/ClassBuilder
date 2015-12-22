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
# Filename: IsLibraryPresent.sh
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
# Name:		IsLibraryPresent.sh
# Input:	<Param1>: one-column file w/ 0, 1, names of lib
# 		<Param2>: library name (string/text)
# Output:	returns 1 if lib name is present, -1 otherwise
# Note:		./IsLibraryPresent.sh File LibName

if [ $# -ne 2 ]; then
	echo -e “Usage: $0 \<file\> \<libraryName\>”
	exit
fi


if [ -f $1 ]; then
    while read line
    do
	val=`echo $line | cut -f 1`
	if [ "$val" == "$2" ]; then
	    echo 1
	    exit
	fi
    done < "$1"
else 
    echo -1
    exit
fi
echo -1
