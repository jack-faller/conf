config.load_autoconfig()
config.bind('o', 'set statusbar.show always;; set-cmd-text -s :open')
config.bind('O', 'set statusbar.show always;; set-cmd-text -s :open -t')
config.bind('T', 'set statusbar.show always;; set-cmd-text -s :tab-focus')
config.bind(':', 'set statusbar.show always;; set-cmd-text :')
config.bind('/', 'set statusbar.show always;; set-cmd-text /')
config.bind('<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
config.bind('<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')
c.editor.command = ["kitty", "--class", "floating", "zsh", "-c", "(cat ~/.cache/wal/sequences &) ; nvim {file} -c 'normal {line}G{column0}l'", "2> /dev/null"]
