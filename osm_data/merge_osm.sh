#!/bin/bash
x=$(ls *.osm -1 | tr '\n' ' ')
osmconvert $x -o=merge.osm
