config.load_autoconfig()
config.bind('o', 'set statusbar.show always;; set-cmd-text -s :open')
config.bind('O', 'set statusbar.show always;; set-cmd-text -s :open -t')
config.bind('T', 'set statusbar.show always;; set-cmd-text -s :tab-focus')
config.bind(':', 'set statusbar.show always;; set-cmd-text :')
config.bind('/', 'set statusbar.show always;; set-cmd-text /')
config.bind('<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
config.bind('<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')
c.editor.command = ["kitty", "--class", "floating", "zsh", "-c", "(cat ~/.cache/wal/sequences &) ; nvim {file} -c 'normal {line}G{column0}l'", "2> /dev/null"]

config.bind("#", "tab-focus")
config.bind(";gv", "hint -r links spawn sh '-c' '~/.config/zsh/aliases/pla {hint-url}'")
config.bind(";v", "hint links spawn detach mpv {hint-url}")
config.bind("<Alt+b>", "spawn --userscript ~/.config/qutebrowser/get.sh")
config.bind("<Alt+f>", "hint links spawn --detach mpv --force-window yes {hint-url}")
config.bind("<Alt+j>", "scroll down")
config.bind("<Alt+k>", "scroll up")
config.bind("<Space>", "tab-focus last")
config.bind("B", "spawn --userscript ~/.config/qutebrowser/stow.sh -o")
config.bind("b", "spawn --userscript ~/.config/qutebrowser/stow.sh")
config.bind("et", "open -t youtube.com/feed/subscriptions")
config.bind("el", "open -t https://www.livechart.me/users/xeere/library?completed=false&considering=true&layout=grid")
config.bind("eL", "open -t https://www.livechart.me/users/xeere/library?completed=false&considering=false&layout=grid")
config.bind("j", "run-with-count 5 scroll down")
config.bind("k", "run-with-count 5 scroll up")

c.auto_save.session = True
c.colors.webpage.preferred_color_scheme = "dark"
c.fonts.web.family.fixed = "iosevka"
c.hints.auto_follow = "always"
c.hints.chars = "abcdefghijklmnopqrstuvwxyz"
c.scrolling.bar = "always"
c.statusbar.show = "in-mode"
c.tabs.last_close = "close"
c.tabs.new_position.unrelated = "next"

c.spellcheck.languages = ["en-GB"]
