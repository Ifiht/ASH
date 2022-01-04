eval $( dircolors -b $HOME/.ash/submodules/LS_COLORS/LS_COLORS )
## fix umask in WSL https://github.com/microsoft/WSL/issues/352 ##
[[ "$(umask)" != '027' ]] && umask 027;
## X11 DISPLAY PARAMS (WSL) ##
export DISPLAY=localhost:0.0
alias l='ls -a --color=auto'
alias ll='ls -alh --color=auto'
#alias rm='rm -i' ## Ask for confirmation
#alias cp='cp -i' ## Ask for confirmation
#alias mv='mv -i' ## Ask for confirmation
alias ipip='echo "\n### FILTER ###" && sudo iptables -vnxL --line-numbers && echo "\n### NAT ###" && sudo iptables -vnxL --line-numbers -tnat  && echo "\n### MANGLE ###" && sudo iptables -vnxL --line-numbers -tmangle'
alias win='netstat -tulpn'
alias exp='/mnt/c/Windows/explorer.exe'
alias code='/mnt/c/Users/Suzuki\ Gershwin/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe'
alias ubuntu_vers='lsb_release -a'
alias ms='cd ~/dev/ms500/CIS-634_AsrFound'
alias dff='df -h | grep -v "/var/lib/docker"'
