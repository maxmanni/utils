#!/bin/sh

input1="$1"
input2="$2"
output="$3"

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$output" "$input1" "$input2"