
#!/bin/bash

folder=$1
if [ -d "$folder-tmp" ]
then
	rm -r "$folder-tmp"
fi
mkdir -p "$folder-tmp"


a=0
s="concat"
for entry in "$folder"/*
do
	intermediateEntry="${entry/.mp4/.ts}"
	echo "create intermediate file $intermediateEntry"
	ffmpeg -i $entry -c copy -bsf:v h264_mp4toannexb -f mpegts $intermediateEntry
	if [ "$a" -eq "0" ]
	then
		s="$s:$intermediateEntry"
	else
		s="$s|$intermediateEntry"
	fi

	let "a += 1"
done

echo "concatenate $a files: $s"
ffmpeg -i "$s" -c copy -bsf:a aac_adtstoasc "output-$folder.mp4"