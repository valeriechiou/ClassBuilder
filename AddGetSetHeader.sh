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
# Filename: AddGetSetHeader.sh
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
# Name:		AddGetSetHeader.sh
# Input:	<Param1>: C++ type
# 		<Param2>: class member name
#               <Param3>: filename (source)
# Output:	appends at end of source file the Get/Set methods related to the class member and
#               the type passed in the parameters
# Note:	        ------	
#
#		./AddGetSetSource.sh int Member1 ./MyClass.hh
#		    $0		     $1    $2      $3           
if [ $# -ne 3 ]; then
	echo -e “Usage: $0 \<type\> \<ClassMember\> \<ClassHeaderPath\>”
	exit
fi


echo -e "// Accessor/Mutator of m_"$2 >> $3
echo -e "$1 Get$2() const;" >> $3
echo -e "void Set$2($1& value);" >> $3
