# Customized-Directory-Listing-Script

This script was written for a class assignment in my Unix scripting class

Summary: Prints a customized listing of the contents of a given directory.
The user can select which files from a normal ls -l command are to be included.
File names are always included.

Options: 
-d directory-name
-f output-file

Fields to include in the customized listing
-p permissions
-o owners
-s size
-t time of modification

Arguments: None

Usage: hw7.sh -d directory_name -f output_file options..

Example: ./hw7.sh -d hw7_test -f output.txt -p -o -s
