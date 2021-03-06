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
# Filename: getSuffix.sh
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
# Name:		getSuffix.sh
# Input:	<Param1>: Prefix:Suffix
# 		
# Output:	returns Suffix
# Note:		
#

if [ $# -eq 0 ]; then
 echo "error"
fi
if [ $# -gt 1 ]; then
 echo "more than 1 parameter. parameter one will be parsed."
fi
echo $1 | cut -f 2 -d ":"
