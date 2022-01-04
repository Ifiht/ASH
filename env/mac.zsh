export PATH=~/Library/Android/sdk/platform-tools:$PATH
export PATH=/usr/local/Cellar/icu4c/bin:/usr/local/Cellar/icu4c/sbin:$PATH
export PATH=/usr/local/Cellar/i2p/0.9.35/bin:$PATH
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
function mountAndroid() { hdiutil attach ~/aosp_env.dmg -mountpoint /Volumes/aosp; }
function umountAndroid() { hdiutil detach /Volumes/aosp; }
alias l='ls -a'
alias ll='ls -alh'
alias ggc='git commit -am '
alias ggu='git pull'
alias ggp='git push'
alias xinu='cd ~/VirtualBox\ VMs/develop-end/rsc/xinu-src/'
alias win="sudo lsof -i -n -P | awk \"NR==1 || /LISTEN/\""
alias pflog="sudo tcpdump -n -e -ttt -i pflog0"
