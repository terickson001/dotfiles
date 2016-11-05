# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

function vimode
    if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
        echo "Disabling vimode"
        set fish_key_bindings fish_default_key_bindings
    else
        echo "Enabling vimode"
        set fish_key_bindings fish_vi_key_bindings
    end
end

#bash $HOME/.config/base16-shell/scripts/base16-default-dark.sh

set -gx EDITOR vim
alias ":q"="exit"
alias "cd.."="cd .."
alias edit="$EDITOR"

#eval (fasd --init auto) &>/dev/null

rvm default
eval (python3 -m virtualfish)
