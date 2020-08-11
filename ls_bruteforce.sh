#!/bin/bash
echo '''
■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■
■   Lightshot Brute Force Tool by Pumburo   ■
■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■
'''
echo '''
Select language(1/2)
1- English
2- Türkçe
'''
read langreq 
if [[ $langreq == 1 ]]; then
	afad="head -n 9"
elif [[ $langreq == 2 ]]; then
	afad="tail -n 11"
fi		
lang=$( cat ./progfiles/language | $afad | base64 --decode )
echo "$lang" | head -n 1
read hmphoto
echo "$lang" | head -n 2 | tail -1
echo "$lang" | head -n 3 | tail -1
echo "$lang" | head -n 4 | tail -1 
read savereq
if [[ $savereq == 1 ]]; then
	echo "$lang" | head -n 5 | tail -1 
elif [[ $savereq == 2 ]]; then
	echo "$lang" | head -n 6 | tail -1
fi	
echo "$lang" | head -n 9 | tail -1
echo "$lang" | head -n 3 | tail -1
echo "$lang" | head -n 4 | tail -1 
read asave
if [[ $asave == 1 ]]; then
	echo "$lang" | head -n 10 | tail -1
elif [[ $asave == 2 ]]; then
	echo "$lang" | head -n 11 | tail -1
fi		
prelink="https://prnt.sc/"
zaman=$( date "+%s" )
for (( i=0; i<$hmphoto; i++ )); do
	randomnumber=$RANDOM
	kalan=$( expr $randomnumber % 2 )
	if [[ $kalan != 0 ]]; then
		digit=5
	elif [[ $kalan == 0 ]]; then
		digit=6
	fi		
	dlonk=$( head /dev/urandom | tr -dc 0-9a-z | head -c $digit )
	cat ./progfiles/searched | grep $dlonk > /dev/null
	dlonks=$( echo $? )
	if [[ $dlonks != 0 ]]; then
		lonk="$dlonk"
		link="$prelink$lonk"
		lenk=$( wget -qO- $link | grep -Eo '\"image\-container.*\<img\sclass\=\".*\"\ssrc\=[^>]+\"' | grep -Eo '(http|https)://[^"]+' )
		if [[ $lenk != '' ]]; then		
			curl -s $lenk > /dev/null
			result=$( echo $? )		
				if [[ $result == 0 ]]; then
					if [[ $i == 0 ]]; then
						echo "$( echo "$lang" | head -n 7 | tail -1 )$lenk" 
						touch ./photos/photo$zaman.html
						cat ./progfiles/taslak.html | head -n 35 >> ./photos/photo$zaman.html
						echo $( echo "$lang" | head -n 8 | tail -1 | sed -e "s|isim|photo$zaman|g" )
						cat ./progfiles/taslak.html | tail -n 32 | sed -e "s|link|$link|g" -e "s|lenk|$lenk|g" -e "s|lonk|$lonk|g" >> ./photos/photo$zaman.html
						echo $lonk >> ./progfiles/searched
					elif [[ $i != 0 ]]; then
						echo "$( echo "$lang" | head -n 7 | tail -1 ) $lenk"
						cat ./progfiles/taslak.html | tail -n 32 | sed -e "s|link|$link|g" -e "s|lenk|$lenk|g" -e "s|lonk|$lonk|g" >> ./photos/photo$zaman.html		
						if [[ $asave == 1 ]]; then
							cat ./progfiles/taslak.html | tail -n 32 | sed -e "s|link|$link|g" -e "s|lenk|$lenk|g" -e "s|lonk|$lonk|g" >> ./photos/allfoundphotos.html
						fi
						echo $lonk >> ./progfiles/searched	
					fi	
				else
					let i--		
				fi		
		elif [[ $lenk == '' ]]; then
			let i--
		fi	
	elif [[ $dlonks == 0 ]]; then
		let i--
	fi		
done	