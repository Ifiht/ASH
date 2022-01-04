alias l='ls -aG'
alias ll='ls -alhG'
alias win="sudo sockstat -l | awk \"NR==1 || /tcp|udp/\""
alias ng="cd /usr/local/etc/nginx/"
alias nslookup="host"
alias pflog="sudo tcpdump -n -e -ttt -i pflog0"
export CC="/usr/bin/clang"
export CXX="/usr/bin/clang++"
export VISUAL=nano
####### RVM ################
if [ -d $HOME/.rvm ]; then
	export PATH="$HOME/.rvm/wrappers/ruby-2.7.0:$HOME/.rvm/gems/ruby-2.7.0/bin:$HOME/.rvm/gems/ruby-2.7.0@global/bin:$PATH"
	export RUBY_VERSION=ruby-2.7.0
	export IRBRC=$HOME/.rvm/rubies/ruby-2.7.0/.irbrc
	export MY_RUBY_HOME=$HOME/.rvm/rubies/ruby-2.7.0
	export GEM_PATH=$HOME/.rvm/gems/ruby-2.7.0:$HOME/.rvm/gems/ruby-2.7.0@global
	export GEM_HOME=$HOME/.rvm/gems/ruby-2.7.0
	[ -s "$HOME/.rvm/scripts/rvm" ] && source $HOME/.rvm/scripts/rvm
fi
if [ -d /usr/local/go ]; then
    export GOROOT="/usr/local/go"
    export GOPATH="$HOME/.go"
    export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
fi
