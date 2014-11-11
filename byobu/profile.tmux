#source $BYOBU_PREFIX/share/byobu/profiles/tmux

source $BYOBU_PREFIX/share/byobu/keybindings/f-keys.tmux

set-option -g set-titles on
set-option -g set-titles-string '#(whoami)@#H - byobu (#S)'
#set-option -g pane-active-border-bg $BYOBU_ACCENT
#set-option -g pane-active-border-fg $BYOBU_ACCENT
#set-option -g pane-border-fg $BYOBU_LIGHT
set-option -g history-limit 10000
set-option -g display-panes-time 150
#set-option -g display-panes-colour $BYOBU_ACCENT
#set-option -g display-panes-active-colour $BYOBU_HIGHLIGHT
#set-option -g clock-mode-colour $BYOBU_ACCENT
set-option -g clock-mode-style 24
set-option -g mode-keys emacs
#set-option -g mode-bg $BYOBU_ACCENT
#set-option -g mode-fg $BYOBU_LIGHT

# set-window-option -g window-status-attr default
# set-window-option -g window-status-bg $BYOBU_DARK
# set-window-option -g window-status-fg $BYOBU_LIGHT
# set-window-option -g window-status-current-attr reverse
# set-window-option -g window-status-current-bg $BYOBU_DARK
# set-window-option -g window-status-current-fg $BYOBU_LIGHT
# set-window-option -g window-status-alert-bg $BYOBU_DARK
# set-window-option -g window-status-alert-fg $BYOBU_LIGHT
# set-window-option -g window-status-alert-attr bold
# set-window-option -g automatic-rename on
# set-window-option -g aggressive-resize on
# set-window-option -g monitor-activity on

set -g default-command $SHELL

# Cannot use:
#  - screen-bce, screen-256color-bce: tmux does not support bce
#  - screen-256color: vim broken without -bce
set -g default-terminal "screen"

# The following helps with Shift-PageUp/Shift-PageDown
set -g terminal-overrides 'xterm*:smcup@:rmcup@'

#set -g status-bg $BYOBU_DARK
#set -g status-fg $BYOBU_LIGHT
set -g status-interval 1
set -g status-left-length 256
set -g status-right-length 256
set -g status-left '#(byobu-status tmux_left) ['
set -g status-right '] #(byobu-status tmux_right)'
#set -g message-bg $BYOBU_ACCENT
#set -g message-fg white

source $BYOBU_CONFIG_DIR/.tmux.conf
