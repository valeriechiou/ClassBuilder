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
# Filename: CreateMakefile.sh
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
# Usage: ./CreateMakefile.sh <ExecutableName> <cflags.txt>
#	    $0			$1		  $2

if [ $# -lt 1 ]; then
    echo -e "Usage: $0 [ExecutableName] ( [cflags.txt] )"
    exit
fi

# > Makefile #clears file
cat headerMakefile.txt > Makefile

if [ ! -f "main.cc" ]; then
   # echo "#include <iostream>" >> main.cc
    echo -e "int main(){" >> main.cc
    echo -e "\treturn 0;\n}" >> main.cc
fi




echo -e "PGRM = $1" >> Makefile
echo -e "OBJS = \c" >> Makefile
IFS=$'\n'
for line in `cat ./classList.txt`
do
    echo -e "$line.o \c" >> Makefile
done
echo >> Makefile

echo -e "CC = g++" >> Makefile

if [ "$2" == "cflags.txt" ] && [ -f $2 ] ; then #if $2 valid & correct file
	echo -e "CFLAGS = \c" >> Makefile
	IFS=$'\n'
	for line in `cat ./cflags.txt`
	do
	echo -e "$line \c" >> Makefile
	done
	echo >> Makefile
elif [ "$2" == "" ]; then #if $2 is not passedin/empty
	echo -e "CFLAGS = \c" >> Makefile
	echo >> Makefile
else
	echo "Error: $2 does not exist. Makefile will be generated with no cflags."
	echo -e "CFLAGS = " >> Makefile
fi

echo >> Makefile

#MAKE ALL
echo -e "all: \$(PGRM)\n" >> Makefile

#MAKE PGRM
echo -e "\$(PGRM): \$(OBJS)" >> Makefile
echo -e "\t\$(CC) \$(OBJS) -o \$(PGRM)\n" >> Makefile

#MAKE SEPARATE .O FILES
IFS=$'\n'
for line in `cat ./classList.txt`
do 
    echo -e "$line.o: $line.cc" >> Makefile
    echo -e "\t\$(CC) \$(CFLAGS) -c $line.cc" >> Makefile
    echo >> Makefile
done


#MAKE CLEAN AND TAR
extra=`./test.sh`

if [ $extra -eq 0 ]; then
	echo -e "clean:" >> Makefile
	echo -e "\trm *.o \$(PGRM) \$(PGRM).tar.gz" >> Makefile
	echo >> Makefile
	echo -e "tar:" >> Makefile
	echo -e "\ttar -czvf \$(PGRM).tar.gz *.cc *.hh" >> Makefile
elif [ $extra -eq 1 ]; then
	echo -e "clean:" >> Makefile
	echo -e "\trm \c" >> Makefile
	
	IFS=$'\n'
	for line in `cat ./classList.txt`
	do
		echo -e "$line.o \c" >> Makefile
	done
	echo -e "\$(PGRM) \$(PGRM).tar.gz" >> Makefile
	
	
	echo >> Makefile
	
	echo -e "tar:" >> Makefile
	echo -e "\ttar -czvf \$(PGRM).tar.gz \c" >> Makefile
	count=0
	IFS=$'\n'
	for line in `cat ./classList.txt`
	do
		count=$((count+1))
		if [ $count -ne 0 ]; then
			echo -e "$line.hh $line.cc \c" >> Makefile
		fi
	done
fi



if [ -f "cflags.txt" ]; then
#    echo -e  "DEBUG cflags.txt removed."
    rm cflags.txt
fi
exit
