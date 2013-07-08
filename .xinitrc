xmodmap /home/thomas/.xmodmap
xrdb /home/thomas/.Xdefaults

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
export GNOME_KEYRING_SOCKET

#exec --no-startup-id wicd-client -t
SSH_AUTH_SOCK=`ss -xl | grep -o -e '/run/user/1000/keyring-.*/ssh'`
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK=$SSH_AUTH_SOCK
#exec dbus-launch i3
#exec startxfce4
