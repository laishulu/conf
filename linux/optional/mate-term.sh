#!/usr/bin/env bash

# ====================CONFIG THIS =============================== #
COLOR_01="#403e41" # HOST
COLOR_02="#ff6188" # SYNTAX_STRING
COLOR_03="#a9dc76" # COMMAND
COLOR_04="#ffd866" # COMMAND_COLOR2
COLOR_05="#fc9867" # PATH
COLOR_06="#ab9df2" # SYNTAX_VAR
COLOR_07="#78dce8" # PROMP
COLOR_08="#fcfcfa" #

COLOR_09="#727072" #
COLOR_10="#ff6188" # COMMAND_ERROR
COLOR_11="#a9dc76" # EXEC
COLOR_12="#ffd866" #
COLOR_13="#fc9867" # FOLDER
COLOR_14="#ab9df2" #
COLOR_15="#78dce8" #
COLOR_16="#fcfcfa" #

BACKGROUND_COLOR="#403e41"       # Background Color
FOREGROUND_COLOR="#fcfcfa"       # Text
CURSOR_COLOR="$FOREGROUND_COLOR" # Cursor
PROFILE_NAME="Monokai Pro"
# =============================================================== #

# =============================================================== #
# | Apply Colors
# =============================================================== #
PALETTE_VALUE="'$COLOR_01:$COLOR_02:$COLOR_03:$COLOR_04:$COLOR_05:$COLOR_06:$COLOR_07:$COLOR_08:$COLOR_09:$COLOR_10:$COLOR_11:$COLOR_12:$COLOR_13:$COLOR_14:$COLOR_15:$COLOR_16'"
dconf write /org/mate/terminal/profiles/default/palette $PALETTE_VALUE
dconf write /org/mate/terminal/profiles/default/foreground-color \'$FOREGROUND_COLOR\'
dconf write /org/mate/terminal/profiles/default/background-color \'$BACKGROUND_COLOR\'
