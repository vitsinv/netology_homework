for ((count = 0 ; count < 5; count++))
do
	declare -a addr=(192.168.62.50 192.168.62.56 192.168.62.45)
	for i in ${addr[@]}
	do
		curl http://$i:80 > /dev/null
		if (($? == 0))
		then
			echo $i Available>>curl.log
		else
			echo $i Unavailable>>curl.log 
		fi
		
	done
done
