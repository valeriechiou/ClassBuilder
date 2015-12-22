#!/bin/sh
#
# Course: CS 100 Summer Session II 2015
# First Name: Valerie
# Last Name: Chiou
# Username: vchio001
# Email Address: vchio001@ucr.edu
# SID: 861102819
#
# AssignmentID: hw3
# Filename: test.sh
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
# Name:		test.sh
# Output: 	returns 0 or 1


#listed .cc files
echo `ls *.cc` > temp.txt
IFS=$" "
for file in `cat ./temp.txt`
do
    echo $file | rev | cut -c 4- | rev >> fileList.txt
done
rm temp.txt
#compare classList to fileList
found=0
IFS=$'\n'
for file in `cat ./fileList.txt`
    do
		IFS=$'\n'
		for class in `cat ./classList.txt`
		do
			#echo "file: $file"
			#echo "class: $class"
			
			if [ "$file" == "$class" ]; then
				found=1
			fi
			
			#echo "found after: $found"
			#echo
		done
		if [ $found -eq 0 ]; then
			>&2 echo -e "Attention: Files that do not belong to the program are present.\n\t   Please check your files, and move/delete them accordingly."
			rm fileList.txt
			echo 1
			exit
		fi
	found=0
done
rm fileList.txt

#listed .hh
echo `ls *.hh` > temp.txt
IFS=$" "
for file in `cat ./temp.txt`
do
    echo $file | rev | cut -c 4- | rev >> fileList.txt
done
rm temp.txt
#compare classList to fileList
found=0
IFS=$'\n'
for file in `cat ./fileList.txt`
    do
		IFS=$'\n'
		for class in `cat ./classList.txt`
		do
			#echo "file: $file"
			#echo "class: $class"
			
			if [ "$file" == "$class" ]; then
				found=1
			fi
			
			#echo "found after: $found"
			#echo
		done
		if [ $found -eq 0 ]; then
			>&2 echo -e "Attention: Files that do not belong to the program are present.\n\t   Please check your files, and move/delete them accordingly."
			rm fileList.txt
			echo 1
			exit
		fi
	found=0
done
rm fileList.txt
echo 0
