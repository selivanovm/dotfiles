xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XTERM_LOCALE=en_US.UTF-8
export LANG=$XTERM_LOCALE 

export PATH=/home/thomas/bin:$PATH

#dropboxd &

#parcellite &

#while true;
#do
#  awsetbg -r /home/thomas/pictures/wallpapers/
#  sleep 10m
#done &

exec awesome -c /home/thomas/.config/awesome/rc.lua
