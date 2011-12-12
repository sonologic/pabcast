#!/bin/bash

source="alsa_input.pci-0000_00_14.2.analog-stereo"

dumpdir="/home/gmc/streamdump"

ezstreamcfg="/home/gmc/stream/test.xml"

title="Live broadcast"
artist="http://signal.hackerspaces.org/"
album="Signal"

record(){
  while [ 1 ]; do
    file="${dumpdir}/raw-`date +%Y-%m-%d-%H%M%S`.wav"
    echo "Recording to $file"
    parec -d "${source}" --file-format=wav ${file}
    sleep 1
  done
}

stream() {
  while [ 1 ]; do
    echo "Starting stream from ${ezstreamcfg}"
    parec -d "${source}" --raw | oggenc -r -q 3 -t "${title}" -a "${artist}" -l "${album}" -o - - | ezstream -c ${ezstreamcfg}
    sleep 1
  done
}

record &
stream &

read x
