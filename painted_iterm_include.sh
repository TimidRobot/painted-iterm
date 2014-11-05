# Include file to be sourced by .bashrc
# https://github.com/TimZehta/painted-iterm
#
# Exports the ANSI color code specified in PAINTED_CONFIG as the variable
# PAINTED. The PAINTED variable can then be used for custom prompts,
# setting the window title via bin/painted-label, etc.
#
# Also sets paints current window PAINTED color.
#
# Requires Bash version 3 or later

# If running non-interactively, do nothing
[[ -n "${PS1:-}" ]] || return 0

#### INTERACTIVE ##############################################################


#### VARIABLES ################################################################


ansi_to_rgb=(   000-000-000 128-000-000 000-128-000 128-128-000 000-000-128
    128-000-128 000-128-128 192-192-192 128-128-128 255-000-000 000-255-000
    255-255-000 000-000-255 255-000-255 000-255-255 255-255-255 000-000-000
    000-000-095 000-000-135 000-000-175 000-000-215 000-000-255 000-095-000
    000-095-095 000-095-135 000-095-175 000-095-215 000-095-255 000-135-000
    000-135-095 000-135-135 000-135-175 000-135-215 000-135-255 000-175-000
    000-175-095 000-175-135 000-175-175 000-175-215 000-175-255 000-215-000
    000-215-095 000-215-135 000-215-175 000-215-215 000-215-255 000-255-000
    000-255-095 000-255-135 000-255-175 000-255-215 000-255-255 095-000-000
    095-000-095 095-000-135 095-000-175 095-000-215 095-000-255 095-095-000
    095-095-095 095-095-135 095-095-175 095-095-215 095-095-255 095-135-000
    095-135-095 095-135-135 095-135-175 095-135-215 095-135-255 095-175-000
    095-175-095 095-175-135 095-175-175 095-175-215 095-175-255 095-215-000
    095-215-095 095-215-135 095-215-175 095-215-215 095-215-255 095-255-000
    095-255-095 095-255-135 095-255-175 095-255-215 095-255-255 135-000-000
    135-000-095 135-000-135 135-000-175 135-000-215 135-000-255 135-095-000
    135-095-095 135-095-135 135-095-175 135-095-215 135-095-255 135-135-000
    135-135-095 135-135-135 135-135-175 135-135-215 135-135-255 135-175-000
    135-175-095 135-175-135 135-175-175 135-175-215 135-175-255 135-215-000
    135-215-095 135-215-135 135-215-175 135-215-215 135-215-255 135-255-000
    135-255-095 135-255-135 135-255-175 135-255-215 135-255-255 175-000-000
    175-000-095 175-000-135 175-000-175 175-000-215 175-000-255 175-095-000
    175-095-095 175-095-135 175-095-175 175-095-215 175-095-255 175-135-000
    175-135-095 175-135-135 175-135-175 175-135-215 175-135-255 175-175-000
    175-175-095 175-175-135 175-175-175 175-175-215 175-175-255 175-215-000
    175-215-095 175-215-135 175-215-175 175-215-215 175-215-255 175-255-000
    175-255-095 175-255-135 175-255-175 175-255-215 175-255-255 215-000-000
    215-000-095 215-000-135 215-000-175 215-000-215 215-000-255 215-095-000
    215-095-095 215-095-135 215-095-175 215-095-215 215-095-255 215-135-000
    215-135-095 215-135-135 215-135-175 215-135-215 215-135-255 215-175-000
    215-175-095 215-175-135 215-175-175 215-175-215 215-175-255 215-215-000
    215-215-095 215-215-135 215-215-175 215-215-215 215-215-255 215-255-000
    215-255-095 215-255-135 215-255-175 215-255-215 215-255-255 255-000-000
    255-000-095 255-000-135 255-000-175 255-000-215 255-000-255 255-095-000
    255-095-095 255-095-135 255-095-175 255-095-215 255-095-255 255-135-000
    255-135-095 255-135-135 255-135-175 255-135-215 255-135-255 255-175-000
    255-175-095 255-175-135 255-175-175 255-175-215 255-175-255 255-215-000
    255-215-095 255-215-135 255-215-175 255-215-215 255-215-255 255-255-000
    255-255-095 255-255-135 255-255-175 255-255-215 255-255-255 008-008-008
    018-018-018 028-028-028 038-038-038 048-048-048 058-058-058 068-068-068
    078-078-078 088-088-088 096-096-096 102-102-102 118-118-118 128-128-128
    138-138-138 148-148-148 158-158-158 168-168-168 178-178-178 188-188-188
    198-198-198 208-208-208 218-218-218 228-228-228 238-238-238)



#### FUNCTIONS ################################################################


__export_painted_color() {
    # Compare hostname then ssh_connection IP to host/env table and export
    # PAINTED (ANSI color code)

    export_painted_by_host() {
        local _color _host _label _pat
        _label=${1}
        _pat=${2}
        _color=${3}
        # remove everything after first period
        _host=${HOSTNAME%%.*}
        if [[ "${_host}" =~ ${_pat} ]]
        then
            export PAINTED=${_color}
            return 0
        else
            return 1
        fi
    }

    export_painted_by_ip() {
        local _color _ip _label _pat
        _label=${1}
        _pat=${2}
        _color=${3}
        if [[ -n "${SSH_CONNECTION}" ]]
        then
            # remove everything after last space from back
            _ip=${SSH_CONNECTION% *}
            # remove everything before last space from front
            _ip=${_ip##* }
        else
            _ip='unknown'
        fi
        if [[ "${_ip}" =~ ${_pat} ]]
        then
            export PAINTED=${_color}
            return 0
        else
            return 1
        fi
    }

    local IFS=$'\012'
    for _line in ${PAINTED_CONFIG}
    do
        unset IFS
        # 1) check against first part of HOSTNAME
        export_painted_by_host ${_line} && return 0
        # 2) check against SSH_CONNECTION IP
        export_painted_by_ip ${_line} && return 0
    done
}


__paint_window() {
    # Set iTerm2 window color
    #
    # Args: ANSI
    local _rgb _r _g _b
    _rgb=${ansi_to_rgb[${1}]}
    # extract values and convert from base10 to base10 to drop leading zeros
    _r=$(( 10#${_rgb:0:3} ))
    _g=$(( 10#${_rgb:4:3} ))
    _b=$(( 10#${_rgb:8:3} ))
    # Output to stderr to prevent noise
    printf '\e]6;1;bg;red;brightness;%d\a' ${_r} 1>&2
    printf '\e]6;1;bg;green;brightness;%d\a' ${_g} 1>&2
    printf '\e]6;1;bg;blue;brightness;%d\a' ${_b} 1>&2
}


painted-config() {
    # Show formatted PAINTED_CONFIG

    print_painted() {
        local _color _label _len _pat
        _label=${1}
        _pat=${2}
        _ansi=${3}
        # Print Label and Match Pattern
        printf '%-20s%-44s' ${_label} ${_pat}
        # variable length color block before color code
        _len=$(( 9 - ${#_ansi} ))
        printf "\e[48;5;%dm%${_len}s" ${_ansi} ' '
        # color code (black on white)
        printf '\e[38;5;%dm\e[48;5;%dm%d' 0 15 ${_ansi}
        # short color code block after color code
        printf '\e[48;5;%dm ' ${_ansi}
        # Reset text colors
        printf '\e[0m'
        echo
    }

    echo
    # Header: underlined bright white on black
    printf '\e[38;5;%dm\e[48;5;%dm\e[4m' 15 0
    printf '%-20s%-44s%s\n' 'Label' 'Match Pattern' 'ANSI Color'
    # Reset text colors
    printf '\e[0m'
    local IFS=$'\012'
    for _line in ${PAINTED_CONFIG}
    do
        unset IFS
        print_painted ${_line}
    done
    echo
}


#### MAIN #####################################################################


if [[ -z "${PAINTED_CONFIG:-}" ]]
then
    echo 'WARNING: the PAINTED_CONFIG variable is not set' 1>&2
else
    __export_painted_color

    # Activate for TERMs that might be in iTerm2
    painted_prompt='[[ -n "${PAINTED:-}" ]] && __paint_window ${PAINTED}'
    #painted_prompt='type -t getsetcolor >/dev/null && getsetcolor'
    case ${TERM} in
        rxvt*|screen*|xterm*)
            if [[ -n "${PROMPT_COMMAND}" ]]
            then
                export PROMPT_COMMAND="${PROMPT_COMMAND}; ${painted_prompt}"
            else
                export PROMPT_COMMAND="${painted_prompt}"
            fi
            ;;
    esac
fi
