#! /bin/bash
#
# Author: Nik Delgado
#
# Summary: Prints a customized listing of the contents of a given directory.
# The user can select which files from a normal ls -l command are to be included.
# File names are always included.
#
# Options: 
# -d directory-name
# -f output-file
#
#  Fields to include in the customized listing
# -p permissions
# -o owners
# -s size
# -t time of modification
#
# Arguments: None
#
# Usage: hw7.sh -d directory_name -f output_file options..
#
# Example: ./hw7.sh -d hw7_test -f output.txt -p -o -s

# Define parameter variables
permission_set=0
owner_set=0
size_set=0
time_ofmod_set=0

# Read in parameters and set to variables if present
while getopts ":d:f:post" opt; do
	case $opt in
	d ) directory=$OPTARG ;;
	f ) output_file=$OPTARG ;;
	p ) permission_set=1 ;;
	o ) owner_set=1 ;;
	s ) size_set=1 ;;
	t ) time_ofmod_set=1 ;;
	\?) echo "invalid option"; exit 1 ;;
	esac
done

# Prompt user to enter a directory if not present
if [ -z $directory ]; then
	read -p "Please enter a directory: " $directory
fi

# Check if directory is valid
if [ ! -d $directory ]; then
	echo "Error. Directory does not exist."
	exit 1
fi

# Prompt user to enter name of output file if not entered already
if [ -z $output_file ] ; then
	read -p "Please enter an output file: " $output_file
fi

# Create temp file to store data
temp=$(mktemp /tmp/temp.XXXXXXXX)

# Store ls -l data into temp file
ls -l $directory > $temp

# Print Results
echo "===== Homework 7 =========="
echo "---- Custom File List ----"
echo "Directory: " $directory

# While loop to cycle through temp file and print data 
while read permissions hard_links owner group_1 group_2 size month day time file_name; do
	
	echo -ne $file_name "\t"

	if (( owner_set == 1 )); then
		echo -ne $owner "\t"
	fi

	if (( time_ofmod_set == 1 )); then
		echo -ne $month $day $time "\t"
	fi

	if (( size_set == 1 )); then
		echo -ne $size "\t"
	fi

	if (( permission_set == 1 )) && [ $permissions != "total" ]; then
		echo -ne $permissions "\t"
	fi
	
	echo ""
done < $temp | tee $output_file

# write output to $output_file and delete temp file
rm $temp

# Exit with result of last command executed
exit $?
