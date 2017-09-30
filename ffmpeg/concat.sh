
#!/bin/bash

folder=$1

rm -r "$folder"/*.ts
rm "$folder"/output.mp4

a=0
s="concat"
for entry in "$folder"/*
do
	intermediateEntry="${entry/.mp4/.ts}"
	echo "********************************************************"
	echo "********* create intermediate file $intermediateEntry"
	echo "********************************************************"
	ffmpeg -i $entry -c copy -bsf:v h264_mp4toannexb -f mpegts $intermediateEntry
	
	if [ "$a" -eq "0" ]
	then
		s="$s:$intermediateEntry"
	else
		s="$s|$intermediateEntry"
	fi

	let "a += 1"
done

echo "********************************************************"
echo "*************** concatenate $a files: $s"
echo "********************************************************"
ffmpeg -i "$s" -c copy -bsf:a aac_adtstoasc "$folder"/output.mp4