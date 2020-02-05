#!/bin/bash

# xkbcomp -xkb $DISPLAY outputfile

setxkbmap -layout 'pl(intl)+madcaps+prtscalt'

for ID in `xinput list|grep mini.*keyboard.*keyboard|cut -d= -f 2|awk '{print $1}'`; do
  setxkbmap -layout 'micmuter' -device $ID
done

xkbset -accessx
xset r rate 300 30


#xinput set-button-map 10 1 2 3 4 5 6 7 0 9 10 11 12 13
#xinput set-button-map 10 1 2 3 4 5 6 7 8 9 10 11 12 13
#delux m618
#xinput set-button-map 10 1 2 3 4 5 6 7 9 8 10 11 12 13
#xinput --set-prop 10 289 10 10 10
#xinput --set-prop 11 289 10 10 10
# xdotool key Caps_Lock

