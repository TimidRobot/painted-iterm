# Test bashrc file called by test.sh

# If not running interactively, don't do anything
[[ -n "${PS1:-}" ]] || return 0

#### INTERACTIVE ######################################################

export TERM=xterm-256color

# Label             Match Pattern                               ANSI Color
PAINTED_CONFIG='
Laptop              ^lappy$                                     8
Bastions            ^bastion                                    52
Office              ^192\.168\.0\.                              18
DMZ                 ^10\.10\.10\.                               202
PROD                ^10\.10\.20\.                               1
DEV                 ^10\.10\.30\.|^10\.33\.33\.                 28
last_default        .                                           11
'
# For ANSI colors see:
# - $ ./bin/painted-colors
# - http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# - or simply search the web for: xterm OR ANSI 256 colors

source painted_iterm_include.sh
PS1="\e[0m\e[38;5;${PAINTED}m\h\e[38;5;15m \\$ \e[0m"
