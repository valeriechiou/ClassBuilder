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
# Filename: AddConsDes.sh
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
# Input:	<Param1>: two-column files, InheritanceTree.txt
# 		<Param2>: class name <Name>
#
# Output:	generate code for constructor/destructor of class <Name> 
#
# Note:		./AddConsDes.sh InheritanceTree.txt <ClassName>
#			$0	      $1  		$2

if [ $# -ne 2 ]; then
	echo -e “Usage: $0 \<InheritanceTree.txt\> \<className\>”
	exit
fi


class=`echo $2`

##check if ClassName is ParentClass
isParentClass=0
IFS=$'\n'
for line in `cat ./InheritanceTree.txt`
do
	parClass=`echo $line | cut -f 2 -d ' '` #take 2nd column
	if [ "$class" == "$parClass" ]; then
		isParentClass=1
	fi
done
echo $isParentClass

#...............................................................#

##search for ParentClass (if ClassName isn't already ParentClass)
ParentClassExists=0
IFS=$'\n'
for line in `cat ./InheritanceTree.txt`
do
    key=`echo $line | cut -f 1 -d ' '`
    if [ "$key" == "$class" ]; then
		ParentClass=`echo $line | cut -f 2 -d ' '`
		ParentClassExists=1
    fi
done

##CONTENT
#if ParentClass exists
if [ "$ParentClassExists" -eq 1 ]; then
    echo -e "#include \"./$ParentClass.hh\"\n" >> $class.hh
    echo -e "class $class: public $ParentClass" >> $class.hh
    echo -e "{" >> $class.hh
    echo -e "\tpublic:" >> $class.hh
    echo -e "\t$class();" >> $class.hh
    echo -e "\t~$class();\n" >> $class.hh
	#####
	echo -e "#include \"./$ParentClass.hh\"" >> $class.cc
    echo -e "#include \"./$class.hh\"\n" >> $class.cc
    
    echo -e "// $class Constructor" >> $class.cc
    echo -e "$class::$class():$ParentClass()" >> $class.cc
    echo -e "{}\n" >> $class.cc

    echo -e "// $class Destructor" >> $class.cc
    echo -e "$class::~$class()" >> $class.cc
    echo -e "{}\n" >> $class.cc
#if ParentClass doesn't exist
elif [ "$ParentClassExists" -eq 0 ]; then
    echo -e "class $class" >> $class.hh
    echo -e "{" >> $class.hh
    echo -e "\tpublic:" >> $class.hh
    echo -e "\t$class();" >> $class.hh
    echo -e "\t~$class();\n" >> $class.hh
	#####
    echo -e "#include \"./$class.hh\"\n" >> $class.cc
    echo -e "// $class Constructor" >> $class.cc
    echo -e "$class::$class()" >> $class.cc
    echo -e "{}\n" >> $class.cc

    echo -e "// $class Destructor" >> $class.cc
    echo -e "$class::~$class()" >> $class.cc
    echo -e "{}\n" >> $class.cc
else
    echo "Error: something went wrong in AddConsDes.sh"
fi
