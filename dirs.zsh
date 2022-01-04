[ -d "/usr/local/texlive/2020/bin/x86_64-linux" ] && export PATH="/usr/local/texlive/2020/bin/x86_64-linux:$PATH"
[ -d "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"
[ -d "$HOME/Library/Android/sdk/ndk-bundle$STY" ] && export PATH="$HOME/Library/Android/sdk/ndk-bundle:$PATH"
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.hol/bin:$PATH"
[ -d "$HOME/.local/bin" ] && export PATH=":$PATH"
####### NVM ################
if [ -d $HOME/.nvm ]; then # Lazy loading of all nvm globals/commands
	declare -a NODE_GLOBALS=(`find $HOME/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
	NODE_GLOBALS+=("node")
	NODE_GLOBALS+=("nvm")
	load_nvm () {
	    export NVM_DIR=~/.nvm
	    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	}
	for cmd in "${NODE_GLOBALS[@]}"; do
	    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
    done 
fi
####### RVM ################
if [ -d "$HOME/.rvm" ]; then
	export PATH="$HOME/.rvm/wrappers/ruby-2.7.2:$HOME/.rvm/gems/ruby-2.7.2/bin:$HOME/.rvm/gems/ruby-2.7.2@global/bin:/usr/share/rvm/gems/ruby-2.7.2/bin:$PATH"
	export RUBY_VERSION="ruby-2.7.2"
	export IRBRC="$HOME/.rvm/rubies/ruby-2.7.2/.irbrc"
	export MY_RUBY_HOME="$HOME/.rvm/rubies/ruby-2.7.2"
	export GEM_PATH="$HOME/.rvm/gems/ruby-2.7.2:$HOME/.rvm/gems/ruby-2.7.2@global"
	export GEM_HOME="$HOME/.rvm/gems/ruby-2.7.2"
	[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
fi
####### BREW ############### Ensure brew commands take precedence
[ -d "/home/linuxbrew/.linuxbrew/bin" ] && export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
####### CONDA ##############
if [ -d "$HOME/anaconda3" ]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
conda_home="$HOME/anaconda3/bin/conda";
__conda_setup="$($conda_home 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fi
