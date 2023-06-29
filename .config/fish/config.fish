#!/usr/bin/env fish

# Variables
set -U fish_greeting ""
set -a PATH $HOME/.local/bin
set -a PATH $HOME/.cargo/bin
set -x -U GOPATH $HOME/go
set -x -U XDG_DATA_DIRS /usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
set -x -U QT_QPA_PLATFORMTHEME 'qt5ct'
set -x -U MICRO_TRUECOLOR 1
set -x -U EDITOR /bin/micro
set -x -U OPENAI_API_KEY 'N/A'

# Common aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls -F --color"
alias code="code-oss"
alias gdb="gdb --tui"
alias server="python3 -m http.server"
alias setbrightness="xrandr --output eDP --brightness"
alias lock="i3lock -c 282a36"
alias pavucontrol="pavucontrol-qt"
alias vim="lvim"

# Fish prompt Dracula Theme
function fish_prompt
  # Cache exit status
  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (cat /etc/hostname)
  end
  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
        set -g __fish_prompt_char \u276f\u276f
      case '*'
        set -g __fish_prompt_char »
    end
  end

  # Setup colors
  set -l normal (set_color normal)
  set -l green (set_color 50fa7b)
  set -l yellow (set_color f1fa8c)
  set -l purple (set_color bd93f9)
  set -l red (set_color ff5555)
  set -l bpurple (set_color -o bd93f9)
  set -l bred (set_color -o ff5555)
  set -l bgreen (set_color -o 50fa7b)
  set -l bwhite (set_color -o f8f8f2)

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_showcolorhints true

  # Python virtual env prompt
  if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  end

  # Color prompt char red for non-zero exit status
  set -l pcolor $bpurple
  if [ $last_status -ne 0 ]
    set pcolor $bred
  end

  # Top
  echo -n $purple$USER$normal$green@$normal$yellow$__fish_prompt_hostname$normal$red:$normal$green(prompt_pwd)$normal
  __fish_vcs_prompt;echo

  # Bottom
  echo -n $pcolor$__fish_prompt_char $normal
end

# Simple file extraction function
function ex
    if test -f $argv # Check if the file exists
        switch $argv
            case '*.tar.bz2'
                tar xjf $argv
            case '*.tar.gz'
                tar xzf $argv
            case '*.bz2'
                bunzip2 $argv
            case '*.rar'
                unrar x $argv
            case '*.gz'
                gunzip $argv
            case '*.tar'
                tar xf $argv
            case '*.bz2'
                tar xjf $argv
            case '*.tgz'
                tar xzf $argv
            case '*.zip'
                unzip $argv
            case '*.Z'
                uncompress $argv
            case '*.7z'
                7z x $argv
            case '*.deb'
                ar x $argv
            case '*.tar.xz'
                tar xf $argv
            case '*.tar.zst'
                unzstd $argv
            case '*'
                echo "$argv can't be extracted via ex"
        end
    else
        echo "File $argv not found."
        echo "Usage: \$ ex <file-name>"
    end
end
