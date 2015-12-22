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
# Filename: InitClassFiles.sh
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
# Name:		InitClassFiles.sh
# Input:	<Param1>: a class name, <Name>
# 		<Param2>: the first class member name concatenated with its type with ":"
#                           <MemberName1>:<Type1> (Type1 is a key from the table
#               <Param3>: etc
# Output:	appends at end of source file the Get/Set methods related to the class member and
#               the type passed in the parameters
# Note:	        use scripts from B and C: create source and header files for class <Name>	
#
#		./InitClassFiles.sh MyClass Member1:Integer Member2:Boolean Member3:Text
#		    $0		     $1           $2         $i....

if [ $# -lt 2 ]; then
	echo -e “Usage: $0 \<ClassName\> \<MemberName1\>:\<Type1\> \<class definition..\>”
	exit
fi

if [ ! -f "classList.txt" ]; then
    echo "main" >> classList.txt
    echo $1 >> classList.txt
else
    echo $1 >> classList.txt
fi

class=`echo $1`
##create header file and source file
./AddHeader.sh $class.hh
./AddHeader.sh $class.cc

##top content of header file
echo -e '\n\n#ifndef '$class'_hh' >> $class.hh
echo -e '#define '$class'_hh\n' >> $class.hh
echo -e "//************************************************************" >> $class.hh
echo -e "// Class Name: $class" >> $class.hh
echo -e "//" >> $class.hh
echo -e "// Design:" >> $class.hh
echo -e "//" >> $class.hh
echo -e "// Usage/Limitations:" >> $class.hh
echo -e "//************************************************************\n" >> $class.hh

########################################################################################

classHH=`echo -e \"./$class.hh\"`
#incase of previous existing
if [ -f "./listLibraries.txt" ]; then
    rm ./listLibraries.txt 
fi
> ./listLibraries.txt 

##libraries for header file
count=0

for i in $@
do
    if [ "$count" -ge 1 ]; then #not $0
		Type=`echo $i | cut -f 2 -d ':'`
		if [ "$Type" != "$1" ]; then
			libName=`./getLibrary.sh ./Types.table $Type` #./getLibrary.sh Types.table Integer||Text
			libPresent=`./InsertLibrary.sh ./listLibraries.txt $libName`
			if [ "$libPresent" -eq -1 ]; then 
				echo -e "#include $libName" >> $class.hh
			fi
		fi
    fi
    (( count+=1 ))
done

##top content of source file
echo >> $class.cc
echo -e "\n//************************************************************" >> $class.cc
echo -e  "// $class Implementation" >> $class.cc
echo -e "//************************************************************\n" >> $class.cc

##libraries for source file
rm ./listLibraries.txt #possible problem?
> ./listLibraries.txt
count=0
for i in $@
do
    if [ "$count" -ge 1 ]; then #not $0
	Type=`echo $i | cut -f 2 -d ':'`	#Integer || Text
	if [ "$Type" != "$1" ]; then
	    libName=`./getLibrary.sh Types.table $Type`
	    libPresent=`./InsertLibrary.sh ./listLibraries.txt $libName`
	    #nothing is inserted bc 0 || <cstring> appended
	    if [ "$libPresent" -eq -1 ]; then 
		echo -e "#include $libName" >> $class.cc
	    fi
	fi
    fi
    (( count+=1 ))
done
#echo -e "#include \"./$class.hh\"\n" >> $class.cc
libPresent=`./InsertLibrary.sh ./listLibraries.txt $classHH`

##CALL ADDCONSDES.SH HERE: creates ie #include <Shape>, #include <Circle>
isParentClass=`./AddConsDes.sh InheritanceTree.txt $class`
#echo "isParentClass $isParentClass"

##accessor/mutator declarations in header file
paramCount=0
for i in $@
do
    if [ "$paramCount" -ge 1 ]; then
	MemberName=`echo $i | cut -f 1 -d ':'`
	Type=`echo $i | cut -f 2 -d ':'`
	if [ "$Type" != "$1" ]; then
	    IFS=$'\n'
	    for line in `cat ./Types.table`
	    do
		value=`echo $line | cut -f 1 -d ' '`
		abrv=`echo $line | cut -f 2 -d ' '`
		if [ "$value" == "$Type" ]; then
		    echo -e "\t// Accessor/Mutator of $MemberName" >> $class.hh
		    echo -e "\t$abrv Get$MemberName() const;" >> $class.hh
		    echo -e "\tvoid Set$MemberName($abrv& value);\n" >> $class.hh
		fi 
	    done
	fi
    fi
    (( paramCount+=1))
done

##header file private:
if [ "$isParentClass" -eq 1 ]; then
	count=0
	echo -e '\tprotected:' >> $class.hh
	for i in $@
	do
		if [ "$count" -ge 1 ]; then
			MemberName=`echo $i | cut -f 1 -d ':'`
			Type=`echo $i | cut -f 2 -d ':'`
			if [ "$Type" != "$1" ]; then
				IFS=$'\n'
				for line in `cat ./Types.table`
				do 
				value=`echo $line | cut -f 1 -d ' '`
				abrv=`echo $line | cut -f 2 -d ' '`
				if [ "$value" == "$Type" ]; then
					echo -e "\t$abrv m_$MemberName;" >> $class.hh
				fi
				done
			fi
		fi
		(( count+=1 ))
	done
elif [ "$isParentClass" -eq 0 ]; then
	count=0
	echo -e '\tprivate:' >> $class.hh
	for i in $@
	do
		if [ "$count" -ge 1 ]; then
		MemberName=`echo $i | cut -f 1 -d ':'`
		Type=`echo $i | cut -f 2 -d ':'`
			if [ "$Type" != "$1" ]; then
				IFS=$'\n'
				for line in `cat ./Types.table`
				#while read line
				do 
				value=`echo $line | cut -f 1 -d ' '`
				abrv=`echo $line | cut -f 2 -d ' '`
				if [ "$value" == "$Type" ]; then
					echo -e "\t$abrv m_$MemberName;" >> $class.hh
				fi
				done
			fi
		fi
		(( count+=1 ))
	done
fi

echo -e "};" >> $class.hh
echo -e "\n#endif" >> $class.hh


##accessor/mutators source file
countMember=0
for i in $@
do
    if [ "$countMember" -ge 1 ]; then
	MemberName=`echo $i | cut -f 1 -d ':'` 
	Type=`echo $i | cut -f 2 -d ':'`
		if [ "$Type" != "$1" ]; then
			#while read line
			IFS=$'\n'
			for line in `cat ./Types.table`
			do 
				value=`echo $line | cut -f 1 -d ' '`
				abrv=`echo $line | cut -f 2 -d ' '`
			if [ "$value" == "$Type" ]; then
				echo -e "// Accessor of $MemberName" >> $class.cc
				echo -e "$abrv $class::Get$MemberName() const" >> $class.cc 
				echo -e "{\n\treturn m_$MemberName;\n}\n" >> $class.cc
				echo -e "// Mutator of $MemberName" >> $class.cc
				echo -e "void $class::Set$MemberName($abrv& value)" >> $class.cc
				echo -e "{\n\tm_$MemberName = value;\n}\n" >> $class.cc
			fi
			done
		fi
    fi
    (( countMember+=1 ))
done
