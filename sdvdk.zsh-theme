# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"
local git_status='$(git_prompt_status)'
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}unmerged "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}deleted "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[yellow]%}renamed "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}modified "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}added "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%}untracked "

# Ruby info.
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[blue]%}{$(rvm-prompt v g s)}%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}{$(rbenv version | sed -e "s/ (set.*$//")}%{$reset_color%}'
  fi
fi

local hg_prompt_info='$(hg_prompt_info)'
#$ZSH_PROMPT_BASE_COLOR
#$ZSH_THEME_HG_PROMPT_PREFIX\
#$ZSH_THEME_REPO_NAME_COLOR
#$_DISPLAY
#$ZSH_PROMPT_BASE_COLOR
#$ZSH_THEME_HG_PROMPT_SUFFIX
#$ZSH_PROMPT_BASE_COLOR
#$(hg_dirty)
#$ZSH_PROMPT_BASE_COLOR

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $ 
PROMPT="
%{$fg[white]%}[%D{%d/%b/%y} %*] \
${rvm_ruby} \

%{$terminfo[bold]$fg[blue]%}%{$reset_color%}\
%{$fg[cyan]%}%n\
%{$fg[white]%}@\
%{$fg[green]%}$(box_name)\
%{$fg[white]%}:\
${hg_prompt_info}${git_info} ${git_status}
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%} \
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
