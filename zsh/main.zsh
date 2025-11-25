export confd=$HOME/.config/zsh

source "$confd/keybindings.zsh"
source "$confd/history.zsh"
source "$confd/prompt.zsh"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export EDITOR="$(eval which nvim)"
export BAT_THEME="base16"
export PATH=$PATH:/home/jade/.local/bin
export INSTANCES="$HOME/.local/share/PrismLauncher/instances/"
# export MANPATH="/usr/local/man:$MANPATH"

# Example aliases
alias d="kitten diff"
alias zshconfig="yazi $HOME/.config/zsh/"
alias nvimconfig="cd ~/.config/nvim/ && yazi"
alias ohmyzsh="${EDITOR} ~/.oh-my-zsh"
alias rg='rg --no-follow --glob "!{/proc/*,/sys/,**/.git/*}" --no-messages'
alias fd='fd --exclude /proc --exclude /sys'
alias p='walker --provider archlinuxpkgs'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

if command -v "bat" &>/dev/null; then
    #! alias -g -- h='-h 2>&1 | bat --language=help --style=plain --paging=never --color always' # <--- this is discouraged! This conflicts with posix -h test operator
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color always'
    alias cat='bat --style=plain --paging=never --color auto'
fi

