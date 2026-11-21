###---------- ALIASES ----------###

#update
alias grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#navigate files and directories
alias tree="exa --tree --icons"
alias ls="exa -a --icons"
alias cd="z"

#media
alias view="nsxiv -f"

#Gnu Coreutilities
alias rml="trash-list"
alias rmr="trash-restore"
alias rmc="trash-empty"
alias rm="trash"
alias cp="cp -r"

#to lazy to tyze usb command
alias mountusb="sudo mount /dev/sdb1 /media/usb-drive"
alias umountusb="sudo umount /dev/sdb1"
alias ejectusb="sudo eject /dev/sdb"
