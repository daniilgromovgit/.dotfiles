# История
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Автодополнение (как в fish)
autoload -Uz compinit && compinit

# Настройка pyenv (Универсальная для Arch Linux и ручной установки)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi

# Промпт
eval "$(starship init zsh)"

# Подсказки и подсветка (правильные пути для Arch Linux)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Быстрые команды для pacman (Arch)
alias pacins="sudo pacman -S"      # Установка
alias pacrem="sudo pacman -Rns"    # Полное удаление с зависимостями
alias pacupd="sudo pacman -Syu"    # Обновление системы

# Замена стандартных утилит на прокачанные
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first"
alias cat="bat --style=plain"
