#!/bin/bash

seconds=$((RANDOM%60+1))

tags=("*height" "building" "ele" "building:levels" "highway" "building:height"
"min_height" "maxheight" "office" "man_made" "barrier" "shop" "roof:height")

tags=( "${tags[@]/#/--keep=}" )

mkdir o5m_files

while IFS='' read -r line || [[ -n "$line" ]]; do
    wget $line
    echo "Dowload $line"
    
    prefix="http://download.geofabrik.de/north-america/us/"
    suffix=".osm.pbf"
    line=${line#$prefix}
    midline=${line%$suffix}
    midline="$midline.o5m"
    osmconvert $line -o=$midline
    echo "Convert to $midline"
    
    rm $line
    echo "Remove $line"

    finalline="o5m_files/$midline"
    osmfilter $midline ${tags[@]} -o=$finalline
    echo "Filter data with target tags and save to $finalline"
    
    rm $midline
    echo "Remove $midline"
    
    echo "------------------------------------------------"
    
    sleep $seconds

done < "$1"
