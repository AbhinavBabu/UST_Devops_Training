#!/bin/bash

threshold = 90
usage = $(df -h / | awk ‘NR==2’ {print $5} | sed ‘s/%/ /’)
If [  “$usage” -ge “$threshold” ] 
 	Then
	du -a /home | sort -n -r | head -n 5 | tar -czvf compressed_files.tar.gz | mv -t 
fi
