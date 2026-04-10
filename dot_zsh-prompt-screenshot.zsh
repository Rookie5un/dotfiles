autoload -U colors && colors
setopt prompt_subst

# A font-friendly prompt styled after the screenshot:
# pink user block + warm path block, without Nerd Font separators.
prompt_screenshot_path() {
  if [[ $PWD == $HOME ]]; then
    print -r -- "~"
  elif [[ $PWD == $HOME/* ]]; then
    print -r -- "~/${PWD:t}"
  else
    print -r -- "${PWD:t}"
  fi
}

build_screenshot_prompt() {
  local left_bg=211
  local mid_bg=223
  local tail_bg=230
  local dark_fg=16
  local warm_fg=52

  PROMPT="%{%f%b%k%}"\
"%K{${left_bg}}%F{${dark_fg}}%B  %n %b"\
"%K{${mid_bg}}%F{${left_bg}}%B▶%b%F{${warm_fg}}%B \$(prompt_screenshot_path) %b"\
"%K{${tail_bg}}%F{${mid_bg}}%B▶  %b"\
"%k%f"$'\n'"%F{111}%B>%b%f "
}

build_screenshot_prompt
