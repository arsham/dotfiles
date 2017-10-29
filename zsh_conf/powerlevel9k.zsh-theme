# Load the theme.
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs disk_usage load ram swap custom_random_emoji battery)
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=4
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %T}"

## Information about the icon unicodes are available in https://github.com/bhilburn/powerlevel9k/blob/master/functions/icons.zsh
## Also running get_icon_names will show you the list
POWERLEVEL9K_HOME_ICON=$'\uE12C '
POWERLEVEL9K_HOME_SUB_ICON=$'\uE18D '
POWERLEVEL9K_EXECUTION_TIME_ICON=$'\UE89C '
POWERLEVEL9K_FOLDER_ICON=$'\uE818 '
POWERLEVEL9K_VCS_BRANCH_ICON=$'\uF126 '
POWERLEVEL9K_PYTHON_ICON=$'\UE63C '

POWERLEVEL9K_BATTERY_ICON='\uf1e6 '
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'

POWERLEVEL9K_SWAP_ICON='\uE87D '

# Apply theme
antigen theme bhilburn/powerlevel9k powerlevel9k

POWERLEVEL9K_CUSTOM_RANDOM_EMOJI="random_emoji"
