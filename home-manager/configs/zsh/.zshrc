export PATH="$HOME/.local/bin:$HOME/.dotnet/tools:$PATH"
export DOTNET_CLI_TELEMETRY_OPTOUT=1


zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS


_dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet


alias rebuild='sudo nixos-rebuild switch --flake ~/nix-config#thinkpad'
alias nixos-update='cd ~/nix-config && nix flake update && rebuild'
alias nixos-clean='sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot'
alias docker-on='sudo systemctl start docker'
alias docker-off='sudo systemctl stop docker'
