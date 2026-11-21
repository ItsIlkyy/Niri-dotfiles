#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i+1))
done

# write cava config
config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 22
sensitivity = 150

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 5 
" > $config_file

# Wait until PipeWire/PulseAudio is ready
while ! pactl info >/dev/null 2>&1; do
    sleep 1
done

# Keep restarting cava if it exits or audio server restarts
while true; do
    cava -p $config_file | while read -r line; do
        echo "$line" | sed "$dict"
    done
    sleep 1
done
