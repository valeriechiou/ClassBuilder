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
# Filename: getLibrary.sh 
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
# Name:		getLibrary.sh
# Input:	<Param1>: Types.table (three-column file)
# 			<Param2>: a key
# Output:	returns library associated to key; other wise nothing
# Note:		Types.table: 1-key, 2-unique value
#
#		./getLibrary.sh Types.table key (ie Address)
#		$0		$1	   $2

if [ $# -ne 2 ]; then
	echo -e “Usage: $0 \<Types.table\> \<key\>”
	exit
fi

IFS=$'\n'       # make newlines the only separator
for line in `cat $1`
do	
	#>&2 echo $line
	val=`echo "$line" | cut -f 1 -d " "`
		if [ "$val" == "$2" ]; then 	
 			echo $line | cut -f 3 -d " "
		fi 
done

