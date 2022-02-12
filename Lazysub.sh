#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
GOOOD=`tput setaf 9`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`






# ----------------------------------------------User input ----------------------------------------


read -p "Enter the program name : " DDR

mkdir -p  ~/hunt/$DDR/subs
mkdir ~/hunt/$DDR/vuln
mkdir ~/hunt/$DDR/nuclei
mkdir ~/hunt/$DDR/out

read -p "Enter the your wildcard-file name : " WLD1

cp $WLD1 ~/hunt/$DDR/subs/$WLD1
cd ~/hunt/$DDR/subs


# ----------------------------------------------Subdomain Enumeration ----------------------------------------

  message="Starting KamashR <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
  echo "${red} [-] All the output will be stored at  ~/hunt/$DDR/${reset}"
echo " "
echo "${blue} [+] Started Subdomain Enumeration ${reset}"
echo " "


#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
	cat $WLD1 | assetfinder --subs-only  | anew ~/hunt/$DDR/subs/subdomains.txt
  echo $GOOOD "findings : "
  wc -l subdomains.txt
  
  echo $GOOOD"----------------------------------------------------------------------"
  message="Finished Assetfinder <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url

echo " "
echo "${blue} [+] Succesfully saved as subdomains.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
	subfinder -dL $WLD1 -all -silent  | anew ~/hunt/$DDR/subs/subdomains.txt
  echo $GOOOD "findings : " 
  wc -l subdomains.txt
  echo $GOOOD"----------------------------------------------------------------------"
  message="Finished subfinder <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully saved as subdomains.txt  ${reset}"
echo " "





#amass
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -df $WLD1 > ~/hunt/$DDR/subs/amass.txt
  cat ~/hunt/$DDR/subs/amass.txt | anew ~/hunt/$DDR/subs/subdomains.txt
echo $GOOOD "findings : "
  wc -l subdomains.txt
  echo $GOOOD"----------------------------------------------------------------------"  
  rm amass.txt
    message="Finished Amass <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully saved as amass.txt  ${reset}"
echo " "

# ----------------------------------------------Network and ips stuff ----------------------------------------

#pull ip and filer it 
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
  echo "${magenta} [+] Running pull ip and filer it ${reset}"
  httpx -l subdomains.txt -pa -o urls_ips.txt
  cat urls_ips.txt | grep -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' | tee -a ips.txt
  cat ips.txt | anew subdomains.txt
  rm ips.txt
# else
  message="Finished Pulling Ip and filtering <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully anewed in subdomains.txt  ${reset}"
echo " "







#httpx
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
  echo "${magenta} [+] Running Httpx ${reset}"
  cat subdomains.txt | httpx -o livesubs.txt
echo $GOOOD "findings : "
  wc -l livesubs.txt
  echo $GOOOD"----------------------------------------------------------------------"# else
    message="Finished HTTPX <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully saved livesubs.txt  ${reset}"
echo " "



#more detail httpx
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
  echo "${magenta} [+] Running more detail httpx ${reset}"
  cat subdomains.txt | httpx  -sc -td -cl -server -title -location -method -ip -o infosubs.txt
    message="Finished Detail HTTPX <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully saved as infosubs.txt  ${reset}"
echo " "


# ----------------------------------------------Directory Discovring and scanning stuff ----------------------------------------



#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
  echo "${magenta} [+] Running nuclei ${reset}"
   nuclei -l livesubs.txt -o ../nuclei/out1.txt
     message="Finished Nuclei <@378583599592505344>"
  msg_content=\"$message\"
  url='https://discord.com/api/webhooks/942161829604503602/owSazFmPinc5PUzAb_dj8xkEJccrm4yFrKbRtJ9oBFB6U6dXOz9QswT-4Rhoo8Kn69J6'
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
echo " "
echo "${blue} [+] Succesfully saved as out1.txt  ${reset}"
echo " "
