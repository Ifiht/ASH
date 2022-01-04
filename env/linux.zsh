eval $( dircolors -b $HOME/.ash/submodules/LS_COLORS/LS_COLORS )
alias l='ls -a --color=auto'
alias ll='ls -alh --color=auto'
alias ipip='echo "\n### FILTER ###" && sudo iptables -vnxL --line-numbers && echo "\n### NAT ###" && sudo iptables -vnxL --line-numbers -tnat  && echo "\n### MANGLE ###" && sudo iptables -vnxL --line-numbers -tmangle'
alias dff='df -h | grep -v "/var/lib/docker"'
alias win='sudo netstat -tulpn'
alias ubuntu_vers='lsb_release -a'
