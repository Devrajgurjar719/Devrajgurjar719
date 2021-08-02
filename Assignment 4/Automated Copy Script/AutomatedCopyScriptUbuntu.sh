
#!/bin/bash


##Automated File Transfer Script

source="/home/dev/Documents/source_folder"
destination="/home/dev/Documents/destination_folder"
receip="devrajgurjar719@gmail.com"
mail_subject="Copy File Script"
from="devrajgurjar719@gmail.com"


# To check if manual date argument has been passed or not
if [ -z "$1" ]
then
echo "The argument date has not supplied so script will work on current date"

date +'FORMAT'

### mm/dd/yyyy ###
date +'%Y/%m/%d'

## Time in 12 hr format ###
date +'%r'

## file format ##
file_date=$(date +'%Y%m%d')

# file name if date argument has not been supplied at command line
file_name="AntWak_Daily_Data_${file_date}.txt"
echo "File Name :- $file_name"

else

date_value=$1
echo "The Passed Date Argument is :- {$1} , so script will work for file of date ${date_value:0:4}-${date_value:4:2}-${date_value:6:2}"
# file name if date argument has been supplied at command line
file_name="AntWak_Daily_Data_${1}.txt"
echo "File Name :- $file_name"

fi

echo "start"

# variable to store the file full address
file_path="$(find $source -name $file_name)"

echo "File to be Copied:- $file_path"

# to check if file is present at source location
if [ -z "$file_path" ]
then 
/usr/sbin/sendmail $receip <<EOF
subject:$mail_subject
from:$from

File not present at the source location
EOF
else
echo "file is present at source location"

echo $file_name

#To copy file from source to destination
cp "$source/$file_name" "$destination"

status=$?

# to check if the copy operation was successful or not
if [[ $status != 0 ]];
then
/usr/sbin/sendmail $receip <<EOF
subject:$mail_subject
from:$from

Copy Operation Failed
EOF

else
/usr/sbin/sendmail $receip <<EOF
subject:$mail_subject
from:$from

File Copied successfully from Source to Destination
EOF

fi

fi
