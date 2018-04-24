#!/bin/bash
x=$(ls o5m_files | tr '\n' ' ')
cd o5m_files
osmconvert $x -o=merge.o5m
osmconvert merge.o5m -o=merge.osm.pbf
