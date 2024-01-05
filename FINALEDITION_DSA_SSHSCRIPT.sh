
printf "#################################################################################################################\n#\t\t\t\t\t\t\t\t\t\t\t\t\t\t#\n#\t\t\tSSH KEY COPY SCRIPT FOR EVERYONE WORKING IN LINUX BASH SHELL\t\t\t\t#\n#\t\t\t\t\t\t\t\t\t\t\t\t\t\t#\n#################################################################################################################\n\n"
echo -e "\033[0;32m*** [ PLEASE TYPE 0 FOR OPTIONS ] ***\033[0m\n"
while true
do
read -p "Enter the option:" option
case "$option" in
0)
echo "Please select the below option to proceed with the script"
echo "1. Introduction"
echo "2. Usage of the script"
echo "3. Enter the answers to the script"
echo "4. Execute"
echo "5. LOOKUP logfiles"
echo -e "6. EXIT SCRIPT"
;;
1)
echo -e "\t#################################################################################################################################\n\t#\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t#\n\t#\tThis Script is intended to add/create ssh keys and also it will create authorization file whenever if applicable\t#\n\t#\t\tThis Automation can complete its task with less manual intervention unless rarely required\t\t\t#\n\t#\t****************************************************************************************************************\t#\n\t#\t\t[ONLY AUTHORIZED SYSTEM ADMINISTRATOR SHOULD USE THIS SCRIPT WHICH IS UNLESS PROHIBITED]\t\t\t#\n\t#\t****************************************************************************************************************\t#\n\t#\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t#\n\t#################################################################################################################################\n"
echo -e "\033[0;32m*** [ PLEASE TYPE 0 FOR OPTIONS ] ***\033[0m\n"
;;
2)
echo -e "*************************************************** [ IMPORTANT NOTE TO GIVE INPUT TO THE SCRIPT AS BELOW ] *******************************************************\n"
echo -e "[1] Enter the Source user ID(s): user1;user2;user3;user4;user5\n"
echo -e "\033[0;31m\t\t{ USER IDs ARE CASE SENSITIVE AND NEEDS TO BE SEPERATED WITH ';' SEMICOLON }\n\033[0m"
echo -e "[2] Enter the Source Server name(s): server1;server2;server3;server4;server5\n"
echo -e "\033[0;31m\t\t{ SERVER NAMEs ARE CASE SENSITIVE AND GIVE THE INPUT WITH 'uname -n' OUTPUT OF SERVERS AND SEPERATED ';' SEMICOLON }\n\033[0m"
echo -e "[3] Enter the Target user ID(s): user6;user7;user8;user9;user10\n"
echo -e "\033[0;31m\t\t{ USER IDs ARE CASE SENSITIVE AND NEEDS TO BE SEPERATED WITH ';' SEMICOLON }\n\033[0m"
echo -e "[4] Enter the Target Server name(s): server6;server7;server8;server9;server10\n"
echo -e "\033[0;31m\t\t{ SERVER NAMEs ARE CASE SENSITIVE AND GIVE THE INPUT WITH 'uname -n' OUTPUT OF SERVERS AND SEPERATED ';' SEMICOLON }\033[0m\n"
echo -e "*************************************************** [ UNDERSTANDING THE WAY OF GIVING INPUT TO SCRIPT ] ***********************************************************\n"
echo -e "Based on the above Input to the script and execution proceeds as below look like:\n"
echo -e "\t\tuser1 @ server1 =======> user6 @ server6\n\t\tuser2 @ server2 =======> user7 @ server7\n\t\tuser3 @ server3 =======> user8 @ server8\n\t\tuser4 @ server4 =======> user9 @ server9\n\t\tuser5 @ server5 =======> user10 @ server10\n"
echo -e "\033[1;33m[NOTE]:\033[0m\033[0;31m COUNT OF OTHER INPUTS SHOULD BE SAME AS EQUAL TO COUNT OF SOURCE IDs\033[0m\n"
echo -e "\033[0;32m*** [ PLEASE TYPE 0 FOR OPTIONS ] ***\033[0m\n"
;;
3)
read -p "Enter the Source user id:" Suser
read -p "Enter the Source Server:" Sserver
read -p "Enter the Targer user id:" Tuser
read -p "Enter the Target Server:" Tserver
echo -e "\033[0;31mPLEASE VERIFY THAT THE GIVEN INPUTS ARE COMPROMISED, IF YES PLEASE TYPE \033[0;32m4\033[0m TO PROCEED WITH EXECUTION, \033[0;31mIF NOT PLEASE TYPE\033[0m \033[1;33m3\033[0m \033[0;31mTO RE-INPUT\033[0m\n"
echo -e "\033[0;32m*** [ PLEASE TYPE 0 FOR OPTIONS ] ***\033[0m\n"
;;
4)
Source() {
printf -v SID %q "${Suser[x]}";
ssh -T "${Sserver[x]}" "bash -s $SID" >> /tmp/sshscript.log  << 'EOF'
echo -e "\t\t\t[* * * * * VERIFYING SOURCE KEY * * * * *]\t\t\t\n"
echo -e "`uname -n`\t\t\t\t\t\t\t\t\t\t\t\t`date`\n"
Suser[x]=$1
if [[ $(id "${Suser[x]}") ]] > /dev/null 2>&1; then
                echo -e "GIVEN SOURCE ID IS ${Suser[x]}\n"
                cd `getent passwd "${Suser[x]}" | cut -d":" -f6` > /dev/null 2>&1
if [ "$?" = 0 ]; then
                echo "HOME DIRECTORY = `pwd`"
                echo "==============================="
                cd `getent passwd "${Suser[x]}" | cut -d":" -f6`/.ssh > /dev/null 2>&1

        if [ "$?" = 0 ]; then
        echo "PUBKEY DIRECTORY=`pwd`"
        echo "==============================="
        ls -lrt id_dsa.pub
        echo "The above is the key file"
        echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''"
                if grep -w ""${Suser[x]}"@`uname -n`" id_dsa.pub; then
        echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''"
                echo "KEY MATCHED WITH GIVEN PATTERN"
                if [[ $(cp -ip id_dsa.pub /tmp/"${Suser[x]}"_`uname -n`_id_dsa.pub) ]] > /dev/null 2>&1; then
                echo "File has  been backed up"; fi
                else
                echo "Key not matching please proceed with key consistency and come back to us"
                fi

        else
        echo "Pub file and .ssh directory doesnt exist"
        su - "${Suser[x]}" -c "echo |ssh-keygen -t dsa"
        cd `getent passwd "${Suser[x]}" | cut -d":" -f6`/.ssh
        echo "PUBKEY DIRECTORY=`pwd`"
        echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''"
                if grep -w ""${Suser[x]}"@`uname -n`" id_dsa.pub; then
        echo "'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''"
                echo "KEY MATCHED WITH GIVEN PATTERN"
                echo "==============================="
                if [[ $(cp -ip id_dsa.pub /tmp/"${Suser[x]}"_`uname -n`_id_dsa.pub) ]] > /dev/null 2>&1; then
                echo "File has  been backed up"; fi
                else
                echo "Key not matching please proceed with key consistency and come back to us"
                fi
        fi

else
echo "Please create home directory and come back to us, this script wont work with home directory creation"
fi
fi
echo -e "\t\t\t[* * * * * COMPLETED SOURCE * * * * *]\t\t\t\n"
EOF
}
#=====================================================================================================================================================================#
Target() {
printf -v TID %q "${Tuser[x]}"
printf -v SSID %q "${Suser[x]}"
printf -v SSS %q "${Sserver[x]}"

ssh -T "${Tserver[x]}" "bash -s $TID $SSID $SSS" >> /tmp/sshscript.log << 'EOF'
echo -e "\t\t\t[* * * * * APPENDING AUTH FILE * * * * *]\t\t\t\n"
echo -e "`uname -n`\t\t\t\t\t\t\t\t\t\t\t\t\t`date`\n"
Tuser[x]=$1
Suser[x]=$2
Sserver[x]=$3

if [[ $(id "${Tuser[x]}") ]] > /dev/null 2>&1; then
echo -e "GIVEN TARGET ID IS ${Tuser[x]}\n"
count=`cat /etc/ssh/sshd_config| grep AuthorizedKeysFile |awk -F" " '{print NF}'`
for a in `seq 2 $count`; do
array[a]=`cat /etc/ssh/sshd_config| grep AuthorizedKeysFile |awk -F" " '{print $'$a'}'`
printf "Checking for the Auth file location available in Configuration file and found as %s\n" ${array[a]}
while [[ ".ssh/authorized_keys" == "${array[a]}" ]]; do
    ls -lrt `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh/authorized_keys > /dev/null 2>&1
    if [[ "$?" = "0" ]]; then
        printf "Found location of the file\n"
        cd `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh
        if [[ $(grep ""${Suser[x]}"@"${Sserver[x]}"" authorized_keys) ]] > /dev/null 2>&1;then
        echo -e "ALREADY KEY(S) ARE THERE IN THE AUTH FILE, PLEASE CHECK THE SSH CONNECTION AND COME BACK\n"
           else
                printf "Backing up auth file\n"
                cp -ip authorized_keys authorized_keys_backup_$(date +"%F_%R")
                printf "File listing after backup of auth\n"
                ls -lrt authorized_keys*
                if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub  >> authorized_keys) ]]; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
                tail -1 authorized_keys;
                ls -lrt authorized_keys
        fi
     else
     return=2
     exit $return
     fi
break
done

while [[ ".ssh/authorized_keys2" == "${array[a]}" ]]; do
    ls -lrt `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh/authorized_keys2 > /dev/null 2>&1
    if [[ "$?" = "0" ]]; then
        printf "Found location of the file\n"
        cd `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh
        if [[ $(grep ""${Suser[x]}"@"${Sserver[x]}"" authorized_keys2) ]] > /dev/null 2>&1;then
        echo -e "ALREADY KEY(S) ARE THERE IN THE AUTH FILE, PLEASE CHECK THE SSH CONNECTION AND COME BACK\n"
           else
                printf "Backing up auth file\n"
                cp -ip authorized_keys2 authorized_keys2_backup_$(date +"%F_%R")
                printf "File listing after backup of auth\n"
                ls -lrt authorized_keys2*
                if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub  >> authorized_keys2) ]]; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
                tail -1 authorized_keys2;
                ls -lrt authorized_keys2
        fi
    else
    return=2
    exit $return
    fi
break
done

while [[ ".ssh/authorized_keys" != "${array[a]}" && ".ssh/authorized_keys2" != "${array[a]}" ]]; do
    pattern=`echo "${array[a]}"|sed 's/%u/'${Tuser[x]}'/g'`
    if [[ $(ls -lrt $pattern) ]] > /dev/null 2>&1; then
         printf "Found auth file location as %s\n" $pattern
         if [[ $(grep ""${Suser[x]}"@"${Sserver[x]}"" $pattern) ]] > /dev/null 2>&1;then
         echo -e "ALREADY KEY(S) ARE THERE IN THE AUTH FILE, PLEASE CHECK THE SSH CONNECTION AND COME BACK\n"
           else
                 cp -ip $pattern $pattern_backup_$(date +"%F_%R")
                 printf "File listing after backup of auth\n"
                 ls -lrt $pattern*
                 if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub >> "$pattern") ]]; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
                 tail -1 "$pattern";
                 ls -lrt "$pattern"
         fi
    else
    return=2
    exit $return
    fi
break
done
done
else
echo -e "[ERROR] GIVEN TARGET ID NOT THERE IN THE TARGET SERVER, PLEASE CREATE ID AND COME BACK\n"
fi
echo -e "\t\t\t[* * * * * COMPLETED TARGET * * * * *]\t\t\t\n"
EOF
}
#========================================================================================================================================================================#
Target_createfile() {
printf -v RTID %q "${Tuser[x]}"
printf -v RSID %q "${Suser[x]}"
printf -v RSS %q "${Sserver[x]}"
ssh -T "${Tserver[x]}" "bash -s $RTID $RSID $RSS" >> /tmp/sshscript.log << 'EOF'
echo -e "\v\t\t\t[* * * * * CREATING AUTH FILE * * * * *]\t\t\t\n"
echo -e "`uname -n`\t\t\t\t\t\t\t\t\t\t\t\t\t`date`\n"
Tuser[x]=$1
Suser[x]=$2
Sserver[x]=$3

count=`cat /etc/ssh/sshd_config| grep AuthorizedKeysFile |awk -F" " '{print NF}'`
for a in `seq 2 $count`; do
array[a]=`cat /etc/ssh/sshd_config| grep AuthorizedKeysFile |awk -F" " '{print $'$a'}'`
printf "Checking for the Auth file location available in Configuration file and found as %s\n" ${array[a]}

while [[ ".ssh/authorized_keys" == "${array[a]}" ]]; do
        cd `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh
        if [ "$?" = 0 ]; then
        if [ ! -f authorized_keys ]; then
        printf "CREATING AUTHORIZED_KEYS FILE FOR YOU\n"
        touch authorized_keys; chown `getent passwd "${Tuser[x]}" |cut -d":" -f3`:`getent passwd "${Tuser[x]}" |cut -d":" -f4` authorized_keys;
        cp -ip authorized_keys authorized_keys_backup_$(date +"%F_%R")
        printf "File listing after backup of auth\n"
        ls -lrt authorized_keys*
        if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub  >> authorized_keys) ]] ; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
        tail -1 authorized_keys;
        ls -lrt authorized_keys
        else
        echo -e "File already found no need to worry\n"
        fi
        else
        echo -e "Directory not there please try to create and come back\n"
        fi
break
done

while [[ ".ssh/authorized_keys2" == "${array[a]}" ]]; do
        cd `getent passwd "${Tuser[x]}" |cut -d":" -f6`/.ssh
        if [ "$?" = 0 ]; then
        if [ ! -f authorized_keys2 ]; then
        printf "CREATING AUTHORIZED_KEYS2 FILE FOR YOU\n"
        touch authorized_keys2; chown `getent passwd "${Tuser[x]}" |cut -d":" -f3`:`getent passwd "${Tuser[x]}" |cut -d":" -f4` authorized_keys2;
        cp -ip authorized_keys2 authorized_keys2_backup_$(date +"%F_%R")
        printf "File listing after backup of auth\n"
        ls -lrt authorized_keys2*
        if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub  >> authorized_keys2) ]]; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
        tail -1 authorized_keys2
        ls -lrt authorized_keys2
        else
        echo -e "File already found no need to worry\n"
        fi
        else
        echo -e "Directory not there please try to create and come back\n"
        fi
break
done

while [[ ".ssh/authorized_keys" != "${array[a]}" && ".ssh/authorized_keys2" != "${array[a]}" ]]; do
         k=`echo "${array[a]}"| awk -F/ '{print $NF}'`
         pattern=`echo "${array[a]}"|sed 's/%u/'${Tuser[x]}'/g'`
         d=`echo $pattern|sed 's/'$k'//g'`
         if [[ $(ls -ld `echo $pattern|sed 's/'$k'//g'`) ]] > /dev/null 2>&1; then
                printf "Found auth file location as %s\n" $pattern
                printf "CREATING AUTHORIZED FILE FOR YOU\n"
                touch "$pattern"; chown `getent passwd "${Tuser[x]}" |cut -d":" -f3`:`getent passwd "${Tuser[x]}" |cut -d":" -f4` "$pattern"
                cp -ip "$pattern" "$pattern"_backup_$(date +"%F_%R")
                printf "File listing after backup of auth\n"
                ls -lrt "$pattern"*
                if [[ $(cat /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub  >> "$pattern") ]] ; then printf "[CHECKOUT KEY ADDED AS BELOW]\n"; fi
                tail -1 "$pattern";
                ls -lrt "$pattern"
          else
                echo -e "$d DIRECTORY NOT THERE IN THE SERVER, PLEASE CREATE AND COME BACK\n"
          fi
     break
done
done
echo -e "\v\t\t\t[* * * * * COMPLETED TARGET * * * * *]\t\t\t\n"
EOF
}
#===================================================================================================================================================================#
KeysFiledelete() {
printf -v DTID %q "${Tuser[x]}"
printf -v DSID %q "${Suser[x]}"
printf -v DSS %q "${Sserver[x]}"
printf -v DTS %q "${Tserver[x]}"
ssh -T "${Sserver[x]}" "bash -s $DSID $DSS" >> /tmp/sshscript.log << 'EOF'
echo -e "\t\t\t[* * * * * WIPING KEY FOOTPRINTS * * * * *]\t\t\t\n"
Suser[x]=$1
Sserver[x]=$2
rm -f /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub
while [[ "$?" = 0  ]]; do
echo -e "Temprory ${Suser[x]} Key's file has been deleted from ${Sserver[x]} SERVER\n";
break
done
EOF

ssh -T "${Tserver[x]}" "bash -s $DSID $DSS $DTS" >> /tmp/sshscript.log << 'EOF'
Suser[x]=$1
Sserver[x]=$2
Tserver[x]=$3
rm -f /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub
while [[ "$?" = 0 ]]; do
echo -e "Temprory ${Suser[x]} Key's file has been deleted from ${Tserver[x]} SERVER\n";
break
done
EOF

rm -f /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub
while [[ "$?" = 0 ]]; do
echo -e "Temprory ${Suser[x]} Key file has been deleted from JUMP SERVER\n";
echo -e "\t\t\t[* * * * * END OF LOGS * * * * *]\t\t\t\n"
break
done >> /tmp/sshscript.log
}
#===========================================================END OF ALL MODULES=====================================================================================#

i=`echo "$Suser"|awk -F";" '{print NF}'`
> /tmp/sshscript.log
for x in `seq 1 $i`
do
Tuser[x]=`echo "$Tuser"| cut -d";" -f$x`
Sserver[x]=`echo "$Sserver"|cut -d";" -f$x`
Suser[x]=`echo "$Suser"|cut -d";" -f$x`
Tserver[x]=`echo "$Tserver"|cut -d";" -f$x`
Source
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
echo -e "Source server ${Sserver[x]} completed, please check the logs\n"
scp "${Sserver[x]}":/tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub /tmp
if [[ "$?" = 0 ]]; then
echo -e "FETCHED FILE from source server to jump server\n"
scp /tmp/"${Suser[x]}"_"${Sserver[x]}"_id_dsa.pub "${Tserver[x]}":/tmp/
echo -e "SENT FILE from jump server to target server\n"
Target
while [[ "$?" = 2 ]]; do
read -p "[ERROR] AUTHORIZED KEYS FILE NOT FOUND, DO YOU WANT US TO CREATE ? PLEASE TYPE [y] or [n]:" yn
case "$yn" in
y|Y|YES|Yes|yes)
Target_createfile
break
;;
n|N|NO|No|no)
echo "Thanks for the compromise, PLEASE CREATE MANUALLY AND COME BACK TO US"
break
;;
*)
echo "Please type yes or no"
;;
esac
break
done
else
echo -e "[ERROR] EXITING CODE COMPLETE DUE TO FOLLOWING REASONS\n1. SOURCE ID DOESNT AVAILABLE IN GIVEN SOURCE SERVER\n2. SOURCE KEY NO MATCH\n3. HOME DIR NOT AVAILABLE\nFOR MORE DETAILS PLEASE CHECKOUT THE LOGS\n"
fi
#===============================FINAL PART REMOVING FOOT PRINTS OF THE KEYS EVERYWHERE AND HERE TOO======================================#
echo -e "Target server ${Tserver[x]} completed, please check the logs\n"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"
KeysFiledelete
done
;;
5)
echo -e "Please find the log file /tmp/sshscript.log\n#######################################################\n"
cat /tmp/sshscript.log
echo -e "\033[0;32m*** [ PLEASE TYPE 0 FOR OPTIONS ] ***\033[0m\n"
;;
6)
echo -e "THANKS FOR USING THE SCRIPT, !!!!!!!!!!!!!! BUBYE !!!!!!!!!!!!!!\n"
break
;;
*)
echo "Please type option 1 to 6"
;;
esac
done
