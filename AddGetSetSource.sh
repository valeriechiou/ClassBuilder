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
# Filename: AddGetSetSource.sh
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
#               <Param3>: a class name
#		<Param4>: a filename (C++ source file)
# Output:	appends at end of source file the Get/Set methods related to the class
#
# Note:		./AddGetSetSource.sh int Member1 MyClass ./MyClass.hh
#			$0	      $1  $2	    $3		$4

if [ $# -ne 4 ]; then
	echo -e “Usage: $0 \<type\> \<ClassMember\> \<ClassName\> \<ClassHeaderPath\>”
	exit
fi
  
echo -e '// Accessor of '$2 >> $4
echo -e "$1 $3::Get$2() const" >> $4
echo -e '{' >> $4
echo -e "\treturn m_$2;" >> $4
echo -e "}\n" >> $4
echo -e "// Mutator of $2" >> $4
echo -e "void $3::Set$2($1& value)" >> $4
echo -e "{" >> $4
echo -e "\tm_$2 = value;" >> $4
echo -e "}" >> $4
