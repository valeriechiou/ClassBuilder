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
# Filename: AddHeader.sh 
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
# Name:		AddHeader.sh
# Input:	<Param1>: filename, file
# Output:       erases content of file, and copies header to file	
# Note:		...
#
#		./AddHeader.sh file 
#		$0		$1	

if [ $# -ne 1 ]; then
	echo -e “Usage: $0 \<HeaderFile\>”
	exit
fi

> $1 #clears file
cat Valerie_861102819.txt > $1
