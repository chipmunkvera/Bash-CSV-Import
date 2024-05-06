#!/bin/bash

echo "$(tail +2 $1 | sort | uniq)" > /tmp/sanitized.tmp


# Loop through each line of file
while IFS="," read fName lName dept; do
	echo "Attempting to create user $fName $lName in $dept..."
	groupadd $fName
	groupadd $dept
	loginname="$fName$lName"
	useradd -m -g $fName -G $dept -p "Pl@inT3xt" -c $dept -s /bin/bash $loginname
	passwd --expire $loginname
	echo "  Created $fName $lName (@$loginname) in $dept."
	echo ""
done < /tmp/sanitized.tmp
