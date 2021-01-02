set -eux -o pipefail
if [ ! -d ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions ]; then  
        git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions; 
fi


if [ ! -d ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/themes/powerlevel10k ]; then  
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
fi

