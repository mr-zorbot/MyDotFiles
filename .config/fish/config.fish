#!/usr/bin/env fish

# Start zellij inside containers
if status is-interactive; and set -q CONTAINER_ID
  if type -q zellij
    if test -z "$ZELLIJ"
      zellij attach main || zellij -s main
    end
  end
end

# Dracula Color Palette
set -l foreground f8f8f2
set -l selection 44475a
set -l comment 6272a4
set -l red ff5555
set -l orange ffb86c
set -l yellow f1fa8c
set -l green 50fa7b
set -l purple bd93f9
set -l cyan 8be9fd
set -l pink ff79c6

# Syntax Highlighting Colors
set -gx fish_color_normal $foreground
set -gx fish_color_command $cyan
set -gx fish_color_keyword $pink
set -gx fish_color_quote $yellow
set -gx fish_color_redirection $foreground
set -gx fish_color_end $orange
set -gx fish_color_error $red
set -gx fish_color_param $purple
set -gx fish_color_comment $comment
set -gx fish_color_selection --background=$selection
set -gx fish_color_search_match --background=$selection
set -gx fish_color_operator $green
set -gx fish_color_escape $pink
set -gx fish_color_autosuggestion $comment
set -gx fish_color_cancel $red --reverse
set -gx fish_color_option $orange

# Default Prompt Colors
set -gx fish_color_cwd $green
set -gx fish_color_host $purple
set -gx fish_color_host_remote $purple
set -gx fish_color_user $cyan

# Completion Pager Colors
set -gx fish_pager_color_progress $comment
set -gx fish_pager_color_background
set -gx fish_pager_color_prefix $cyan
set -gx fish_pager_color_completion $foreground
set -gx fish_pager_color_description $comment
set -gx fish_pager_color_selected_background --background=$selection
set -gx fish_pager_color_selected_prefix $cyan
set -gx fish_pager_color_selected_completion $foreground
set -gx fish_pager_color_selected_description $comment
set -gx fish_pager_color_secondary_background
set -gx fish_pager_color_secondary_prefix $cyan
set -gx fish_pager_color_secondary_completion $foreground
set -gx fish_pager_color_secondary_description $comment

# Git Prompt Colors
set -gx __fish_git_prompt_show_informative_status true
set -gx __fish_git_prompt_showcolorhints true
set -gx __fish_git_prompt_color_branch $green --bold
set -gx __fish_git_prompt_color_branch_detached $red --bold
set -gx __fish_git_prompt_color_flags $cyan --bold
set -gx __fish_git_prompt_color_prefix $purple --bold
set -gx __fish_git_prompt_color_suffix $purple --bold
set -gx __fish_git_prompt_color_dirtystate $red --bold
set -gx __fish_git_prompt_color_invalidstate $red --bold
set -gx __fish_git_prompt_color_stagedstate $green --bold

# Variables
set -U fish_greeting ""
set -U VIRTUAL_ENV_DISABLE_PROMPT true
set -x -U GOPATH $HOME/go
set -a PATH $HOME/go/bin
set -a PATH $HOME/.local/bin
set -a PATH $HOME/.cargo/bin
set -x -U XDG_DATA_DIRS /usr/local/share:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
set -x -U QT_QPA_PLATFORM wayland
set -x -U QT_QPA_PLATFORMTHEME qt6ct
set -x -U GBM_BACKEND nvidia-drm
set -x -U __GLX_VENDOR_LIBRARY_NAME nvidia
set -x -U STEAMLIBRARY $HOME/.local/share/Steam
set -x -U FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git" --glob "!.node_modules"'
set -x -U FZF_DEFAULT_OPTS "--layout=reverse \
                            --border=bold \
                            --border=rounded \
                            --prompt 'Search: ' \
                            --border-label ' FZF ' \
                            --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
                            --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
                            --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
                            --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 \
                            --preview-window=right:65% \
                            --multi \
                            --bind 'ctrl-e:become($EDITOR {+})' \
                            --bind 'ctrl-a:select-all' \
                            --bind 'ctrl-alt-a:deselect-all+clear-multi' \
                            --bind 'ctrl-d:execute(dragon-drop -a {+} > /dev/null 2>&1)' \
                            --bind 'ctrl-y:execute-silent(wl-copy {+})' \
                            --bind 'ctrl-r:reload(rg --files --hidden --follow --glob \"!.git\" --glob \"!.node_modules\")' \
                            --bind 'ctrl-alt-r:reload(rg --files)'"

# Common aliases
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias gdb="gdb --tui"
alias nc="ncat"
alias fzfm="FZF_DEFAULT_COMMAND='rg --files' fzf --bind 'enter:execute(xdg-open {} >/dev/null 2>&1)' \
                                                 --preview '~/.config/fzf/fzf-preview.sh {} \$FZF_PREVIEW_COLUMNS \$FZF_PREVIEW_LINES'"

if type -q bat
  alias cat="bat -f -pp --theme=Dracula"
  alias bat="bat -f --theme=Dracula"
end

if type -q eza
  set -x -U EZA_COLORS "\
    uu=36:\
    uR=31:\
    un=35:\
    gu=37:\
    da=2;34:\
    ur=34:\
    uw=95:\
    ux=36:\
    ue=36:\
    gr=34:\
    gw=35:\
    gx=36:\
    tr=34:\
    tw=35:\
    tx=36:\
    xx=95:"
  
  alias ls="eza -F --icons"
  alias ll="eza -lhgX --icons --git"
  alias tree="eza -T --icons"
end

if type -q nvim
  set -x -U EDITOR /usr/bin/nvim
  alias vim="nvim"
  alias vi="nvim"
end

# Fish prompt Dracula Theme
function fish_prompt
    # Cache exit status
    set -l last_status $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (/usr/bin/cat /etc/hostname)
    end

    if not set -q __fish_prompt_char
       set -g __fish_prompt_char "󰜴 " 
    end
    
    set -l red (set_color -o ff5555)
    set -l green (set_color -o 50fa7b)
    set -l purple (set_color -o bd93f9)
    set -l cyan (set_color -o 8be9fd)
    set -l pink (set_color -o ff79c6)

    
    # Podman container prompt
    if set -q CONTAINER_ID
      echo -n $purple"["$cyan" "$pink$CONTAINER_ID$purple"]"
    end
 
    # Python virtual env prompt
    if set -q VIRTUAL_ENV
      echo -n $purple"["$cyan"󰌠"$pink (basename "$VIRTUAL_ENV")$purple"]"
    end
    
    # Color prompt char red for non-zero exit status
    set -l pcolor $green
    if [ $last_status -ne 0 ]
      set pcolor $red
    end
    
    echo -n $purple"["$cyan" "$pink$USER$purple"]"
    echo -n $purple"["$cyan"󰌢 "$pink$__fish_prompt_hostname$purple"]"
    echo -n $purple"["$cyan"󰉋 "$pink(prompt_pwd)$purple"]"

    __fish_vcs_prompt
    echo

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

# Shows weather in the terminal
function wttr
  curl wttr.in
end
