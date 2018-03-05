#!/bin/bash

seconds=$((RANDOM%60+1))

while IFS='' read -r line || [[ -n "$line" ]]; do
    wget $line
    echo "Dowload $line"
    
    prefix="http://download.geofabrik.de/north-america/us/"
    suffix=".osm.pbf"
    line=${line#$prefix}
    newline=${line%$suffix}
    newline+=".o5m"
    osmconvert $line -o=$newline
    echo "Convert to $newline"
    
    rm $line
    echo "Remove $line"

    suffix=".o5m"
    line=${newline%$suffix}
    line+=".osm"
    osmfilter $newline --keep="all *height=*" -o=$line
    echo "Filter data with height to $line"
    
    rm $newline
    echo "Remove $newline"
    
    echo "------------------------------------------------"
    
    sleep $seconds

done < "$1"
