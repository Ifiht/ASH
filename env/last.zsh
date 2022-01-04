eval "$(oh-my-posh --init --shell zsh --config ~/.ash/configs/stelbent.minimal.omp.json)"
# This line MUST be SECOND-LAST, readonly vars MUST be LAST
source $HOME/.ash/submodules/zsh-syntax/zsh-syntax-highlighting.zsh 
[ -n "$STY" ] && readonly TMOUT 
