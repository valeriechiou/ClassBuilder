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
# Filename: AddMethod.sh
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
# Input:	<Param1>: class name
#			<Param2>: method name
#			<Param3>: "constant" or "non-constant"
#		   (<Param4>: return type)
#		   (<Param5+>: <Param#>:<Type#> )
# Output:	(iii): const/nonconst to indicate whether the method can't change membs of class
# 					*non-const: insert BEFORE definition of class members Class in Class.hh
#								& appends at the end of Class.cc 
#					*const: adds the keyword const at the end of the method declaration
#
#		./AddMethod.sh <ClassName> <MethodName> <"constant"/"non-constant"> <Type>
#		    $0		     $1           $2         	$3						  $4


if [ "$#" -lt 3 ]; then
	echo -e "Usage: $0 \<ClassName\> \<MethodName\> \<\"constant\"/\"non-constant\"\>"
	exit
fi

class=`echo $1`
methodName=`echo $2`

if [ "$#" -eq 3 ]; then
	retType="Valueless"
else
	retType=`echo $4`
fi


hhData=$(<$class.hh)
#echo "$value"

rm $class.hh

##HUGE PRINT HEADER FILE
libraries=""
existing=""
headerWritten=0
includeWritten=0
lineCount=0
Found=0
IFS=$'\n'
for line in $hhData
do
	if [[ $line == *"private:"* ]] || [[ $line == *"protected:"* ]]; then
		break
	fi
	if [[ $line == *"#include"* ]] || [[ $line == *"class "* ]] ; then
		#echo "found"
		if [ "$headerWritten" -eq 0 ]; then
			./AddHeader.sh $class.hh
			echo -e "\n" >> $class.hh
			echo -e '#ifndef '$class'_hh' >> $class.hh
			echo -e '#define '$class'_hh\n' >> $class.hh
			echo -e '//************************************************************' >> $class.hh
			echo -e "// Class Name: $class" >> $class.hh
			echo -e "//" >> $class.hh
			echo -e	"// Design:" >> $class.hh
			echo -e "//" >> $class.hh
			echo -e "// Usage/Limitations:" >> $class.hh
			echo -e "//"  >> $class.hh
			echo -e "//************************************************************" >> $class.hh
			
			headerWritten=1
		fi
		if [[ $line == *"#include"* ]]; then
			temp=`echo $line | cut -f 2 -d ' '`
			libraries="$libraries$temp,"
			if [ "$libraries" != "" ]; then
				echo >> $class.hh
			fi
		fi
		
		Found=1
	fi
	if [ "$Found" -eq 1 ] && [[ $line != *"include"* ]]; then
		#add new includes
		if [ "$includeWritten" -eq 0 ]; then
			#echo $libraries
			
			paramCount=0
			for param in $@
			do
				if [ "$paramCount" -ge 4 ]; then
					suff=`./getSuffix.sh $param`
					libraryName=`./getLibrary.sh ./Types.table $suff`
					foundLib=0
					IFS=$','
					for i in $libraries
					do
						if [ "$libraryName" == "$i" ]; then
							foundLib=1
						fi
					IFS=$' '
					done
					if [ "$foundLib" -eq 0 ]; then
						if [ "$libraryName" != "0" ]; then
							#echo "libraryName $libraryName"
							echo -e "#include $libraryName" >> $class.hh
						fi
					fi
				fi
				(( paramCount+=1 )) 
			done
			
			#add original includes
			IFS=$','
			for i in $libraries
			do
				echo -e "#include $i" >> $class.hh
			done
			
			includeWritten=1
		fi
		IFS=$' '
		if [[ $line == *"// Accessor"* ]]; then
			printf "\n\n%s" "$line" >> $class.hh
		elif [[ $line == *"// Method"* ]]; then
			printf "\n\n%s" "$line" >> $class.hh
		else
			printf "\n%s" "$line" >> $class.hh
		fi
	fi
	IFS=$'\n'
	(( lineCount+=1 ))
done
											#add an if-statement to check if there is more than 3?
##header file: add method definition
echo -e "\n\n\t// Method:\t$methodName" 	>> $class.hh
echo -e "\t// Output:\t$retType," 		>> $class.hh
if [ "$#" -eq 3 ] || [ "$#" -eq 4 ]; then
	echo -e "\t// Input:" >> $class.hh
else
		inputType=`./getSuffix.sh $5` 				#if there's Type(s), it starts at $5
	echo -e "\t// Input:\t$inputType," 	>> $class.hh
	IFS=$' '
	for i in ${@:6} 
	do
		inputType=`./getSuffix.sh $i`
		echo -e "\t//\t\t\t$inputType," 		>> $class.hh
	done
fi

##CREATE SOURCE FILE
ccData=$(<$class.cc)
#echo "$value"

rm $class.cc
##HUGE PRINT SOURCE FILE
libraries=""
existing=""
headerWritten=0
includeWritten=0
cclineCount=0
Found=0
IFS=$'\n'
for line in $ccData
do
	if [[ $line == *"private:"* ]] || [[ $line == *"protected:"* ]]; then
		break
	fi
	if [[ $line == *"#include"* ]] ; then
		#echo "found"
		if [ "$headerWritten" -eq 0 ]; then
			./AddHeader.sh $class.cc
			echo -e "\n" >> $class.cc
			echo -e "//************************************************************" >> $class.cc
			echo -e "// MyClass Implementation" >> $class.cc
			echo -e "//************************************************************\n" >> $class.cc

			headerWritten=1
		fi
		if [[ $line == *"#include"* ]]; then
			temp=`echo $line | cut -f 2 -d ' '`
			libraries="$libraries$temp,"
		fi
		
		Found=1
	fi
	if [ "$Found" -eq 1 ] && [[ $line != *"include"* ]]; then
		#add new includes
		if [ "$includeWritten" -eq 0 ]; then
			paramCount=0
			for param in $@
			do
				if [ "$paramCount" -ge 4 ]; then
					suff=`./getSuffix.sh $param`
					libraryName=`./getLibrary.sh ./Types.table $suff`
					foundLib=0
					IFS=$','
					for i in $libraries
					do
						if [ "$libraryName" == "$i" ]; then
							foundLib=1
						fi
					done
					IFS=$' '
					if [ "$foundLib" -eq 0 ]; then
						if [ "$libraryName" != "0" ]; then
							echo -e "#include $libraryName" >> $class.cc
						fi
					fi
				fi
				(( paramCount+=1 )) 
			done
			
			#add original includes
			IFS=$','
			for i in $libraries
			do
				echo -e "#include $i" >> $class.cc
			done
			
			
			includeWritten=1
		fi
		IFS=$' '
		if [[ $line == *"{}"* ]]; then
			printf "\n%s\n" "$line" >> $class.cc
			#echo -e "\n$line\n" >> $class.cc
		elif [[ $line == *"}"* ]]; then 
			printf "\n%s\n" "$line" >> $class.cc
			#echo -e "\n$line\n" >> $class.cc
		else
			printf "\n%s" "$line" >> $class.cc
			#echo -e "\n$line" >> $class.cc
		fi
	fi
	(( cclineCount+=1 ))
	
	IFS=$'\n'
done


##source file: add method definition
#set -o verbose
#set -f
#echo -e "\r*\n" >> $class.cc
echo -e "\n// Method: $methodName\c" >> $class.cc
echo -e "\r//************************************************************" >> $class.cc
echo -e "// Purpose:" >> $class.cc
echo -e "//" >> $class.cc
echo -e "// Implementation Notes:" >> $class.cc
echo -e "//\c" >> $class.cc
echo -e "\r//************************************************************" >> $class.cc

##header&source file: add declaration (ie void Method1(double& Param1.....) )
#find return type (ie void)
IFS=$'\n'
table=`cat ./Types.table`
CType="void"
for line in $table 				
do
	associatedVal=`echo $line | cut -f 1 -d ' '`
	if [ "$retType" == "$associatedVal" ]; then
		CType=`echo $line | cut -f 2 -d ' '`
	#else
		#CType="void"
	fi
done

echo -e "\t$CType $methodName(\c" >> $class.hh 		#'\c' means no newline
echo -e "$CType $class::$methodName(\c" >> $class.cc

#no param#s in method
if [ "$#" -eq 3 ] || [ "$#" -eq 4 ]; then
	if [ "$3" == "non-constant" ]; then
		echo -e ");\n" >> $class.hh
		echo -e ")\n{}" >> $class.cc
	else
		echo -e ") const;\n" >> $class.hh
		echo -e ") const\n{}" >> $class.cc
	fi
else
	count=0
	IFS=$' '
	for i in $@
	do
		if [ "$count" -ge 4 ];then
			#if current parameter is the last
			temp=$(( $#-1 ))
			if [ "$count" -eq "$temp" ]; then 
				Param=`./getPrefix.sh $i`
				suff=`./getSuffix.sh $i`
				Type=`./getValue.sh Types.table $suff`
				if [ "$3" == "non-constant" ]; then
					echo -e "$Type& $Param);\n" >> $class.hh
					echo -e "$Type& $Param)\n{}" >> $class.cc
				elif [ "$3" == "constant" ]; then
					echo -e "$Type& $Param) const;\n" >> $class.hh
					echo -e "$Type& $Param) const\n{}" >> $class.cc
				fi	
			else
				Param=`./getPrefix.sh $i`
				suff=`./getSuffix.sh $i`
				Type=`./getValue.sh Types.table $suff`
				echo -e "$Type& $Param, \c" >> $class.hh
				echo -e "$Type& $Param, \c" >> $class.cc
			fi
		fi
		(( count+=1 )) 
	done
fi

#continue header file
contLine=0
IFS=$'\n'
for line in $hhData
do
	if [ "$contLine" -ge "$lineCount" ]; then
		if [[ $line == *"#endif"* ]]; then
			echo -e "\n$line" >> $class.hh
		else
			echo "$line" >> $class.hh
		fi
	fi
	(( contLine+=1 ))
done
