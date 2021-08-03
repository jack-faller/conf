(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(save-place-mode 1)

(add-to-list 'default-frame-alist '(font . "Iosevka 9"))
(set-face-attribute 'default t :font "Iosevka")
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers t
							display-line-numbers-widen t
							display-line-numbers-type 'relative)
(setq display-line-numbers-type 'relative)

(setq show-paren-delay 0)
(show-paren-mode)
(electric-pair-mode)
(defun leader (str)
	(kbd (concat "SPC " str)))

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)
(setq-default rust-indent-offset tab-width)

(defmacro inctive-chain (&rest args)
	`(lambda () (interactive) ,@(mapcar #'cdr args)))

(defvar bootstrap-version)
(defvar all-the-icons-fonts-installed? t)

(let ((bootstrap-file
			 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
			(bootstrap-version 5))
	(unless (file-exists-p bootstrap-file)
		(setq all-the-icons-fonts-installed? nil)
		(with-current-buffer
				(url-retrieve-synchronously
				 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
				 'silent 'inhibit-cookies)
			(goto-char (point-max))
			(eval-print-last-sexp)))
	(load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(defmacro pkg (name &rest args)
	`(use-package ,name :straight t ,@args))
(defmacro pkg-github (name repo &rest args)
	`(use-package ,name
		 :straight (,name
								:type git
								:host github
								:repo ,repo)
		 ,@args))

(pkg gruvbox-theme
		 :config
		 (load-theme 'gruvbox-dark-hard t))

(pkg keyfreq
		 :config
		 (keyfreq-mode 1)
		 (keyfreq-autosave-mode 1)
		 (require 'keyfreq)
		 (setq keyfreq-excluded-commands '(self-insert-command)))

(pkg auto-package-update
		 :init
		 (setq auto-package-update-delete-old-versions t
					 auto-package-update-hide-results t)
		 :config
		 (auto-package-update-maybe))

(pkg diminish)
(pkg goto-chg)

(pkg undo-tree
		 :diminish undo-tree-mode
		 :init
		 (setq undo-tree-visualizer-timestamps t
					 undo-tree-visualizer-lazy-drawing nil
					 ;; this is broken, the after save hook below fixes it, but it still needs to be here
					 undo-tree-auto-save-history t)
		 (let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
			 (setq undo-tree-history-directory-alist (list (cons "." undo-dir))))

		 :config
		 (add-hook 'after-save-hook (lambda () (when undo-tree-mode (undo-tree-save-history nil t))))
		 (global-undo-tree-mode))

(pkg evil
		 :init
		 (add-hook 'pre-command-hook 'evil-ex-nohighlight) ;; hack for sticky search
		 (setq evil-want-integration t ;; This is optional since it's already set to t by default.
					 evil-want-keybinding nil
					 evil-cross-lines t
					 evil-search-module 'evil-search
					 evil-undo-system 'undo-tree
					 evil-ex-substitute-global t
					 evil-want-C-u-scroll t
					 evil-want-visual-char-semi-exclusive t
					 evil-want-Y-yank-to-eol t
					 evil-ex-search-vim-style-regexp t
					 evil-ex-substitute-global t
					 evil-ex-visual-char-range t ;; column range for ex commands this doesn't work
					 ;; more vim-like behavior
					 evil-symbol-word-search t
					 evil-want-change-word-to-end nil ;; ce and cw are now different
					 ;; don't activate mark on shift-click
					 shift-select-mode nil)

		 :config
		 (setq evil-emacs-state-cursor 'box
					 evil-normal-state-cursor 'box
					 evil-visual-state-cursor 'box
					 evil-insert-state-cursor 'bar
					 evil-replace-state-cursor 'hbar
					 evil-operator-state-cursor 'hollow)
		 (setq evil-extra-operator-eval-modes-alist
					 '((lisp-mode slime-eval-region)
						 (scheme-mode geiser-eval-region)
						 (clojure-mode cider-eval-region)
						 (ruby-mode ruby-send-region)
						 (enh-ruby-mode ruby-send-region)
						 (python-mode python-shell-send-region)
						 (julia-mode julia-shell-run-region)))
		 (evil-define-operator evil-eval (beg end)
			 "Evil operator for evaluating code."
			 :move-point nil
			 (interactive "<r>")
			 (let* ((ele (assoc major-mode evil-extra-operator-eval-modes-alist))
							(f-a (cdr-safe ele))
							(func (car-safe f-a))
							(args (cdr-safe f-a)))
				 (if (fboundp func)
						 (apply func beg end args)
					 (eval-region beg end t))))
		 (evil-define-operator evil-replace-with-reg (beg end type register)
			 "Evil operator for evaluating code."
			 (interactive "<R><x>")
			 (evil-delete beg end type ?_)
			 (evil-paste-before 1 register))
		 (evil-define-operator evil-comment (beg end)
			 "Evil operator for evaluating code."
			 (interactive "<r>")
			 (comment-or-uncomment-region beg end))
		 (evil-define-key 'motion 'global
			 (kbd "M-e") 'evil-backward-word-end
			 (kbd "M-E") 'evil-backward-WORD-end)
		 (evil-define-key '(normal visual) 'global
			 "ge" 'evil-eval
			 "gc" 'evil-comment
			 "gs" 'evil-replace-with-reg)
		 (evil-define-key 'normal evil-ex-search-keymap
			 "j" 'next-line-or-history-element
			 "k" 'previous-line-or-history-element)
		 (evil-define-key 'normal 'global
			 "S" (lambda () (interactive) (evil-ex "%s/"))
			 "gb" 'view-buffer
			 "gB" 'ibuffer)
		 (evil-define-key '(normal visual) 'global
			 (leader ";") 'execute-extended-command)
		 (evil-define-key nil 'global
			 (kbd "C-h") 'evil-window-left
			 (kbd "C-j") 'evil-window-down
			 (kbd "C-k") 'evil-window-up
			 (kbd "C-l") 'evil-window-right
			 (kbd "C-q") 'evil-quit
			 (kbd "C-S-q") (inctive-chain 'save-buffer 'kill-buffer)
			 (kbd "M-RET") (lambda () (interactive)
											 (split-window-horizontally)
											 (evil-window-right 1)
											 (call-interactively #'view-buffer))
			 (kbd "M-DEL") (lambda () (interactive)
											 (split-window-vertically)
											 (evil-window-down 1)
											 (call-interactively #'view-buffer)))
		 (evil-mode 1))

(pkg evil-surround
		 :config
		 (global-evil-surround-mode 1))

(pkg-github targets "noctuid/targets.el"
						:config
						(targets-setup t))

(pkg evil-exchange
		 :config (evil-exchange-install))

(pkg centered-cursor-mode
		 :config
		 (setq-default require-final-newline nil)
		 (setq mode-require-final-newline nil)
		 (global-centered-cursor-mode 1))

(pkg evil-collection
		 :diminish evil-collection-unimpaired-mode
		 :after evil
		 :init
		 (setq evil-collection-setup-minibuffer t)
		 :config
		 (setq evil-collection-mode-list (delete 'lispy evil-collection-mode-list))
		 ; (dolist (i evil-collection-minibuffer-maps)
			;  (evil-define-key 'normal (eval i)
			; 	 "cc" "cc<delete>"
			; 	 "j" 'previous-complete-history-element
			; 	 "k" 'next-complete-history-element))
		 (evil-collection-init))

(pkg lispy
		 :diminish lispy-mode
		 :after evil-collection)

(pkg lispyville
		 :after (targets)
		 :diminish lispyville-mode
		 :init
		 (add-hook 'emacs-lisp-mode-hook 'lispyville-mode)
		 (add-hook 'common-lisp-mode-hook 'lispyville-mode)
		 (add-hook 'scheme-mode-hook 'lispyville-mode)
		 (add-hook 'lisp-mode-hook 'lispyville-mode)
		 (add-hook 'lispyville-mode-hook
							 (lambda ()
								 (targets-define-to lispyville-comment 'lispyville-comment nil object
																		:bind t :keys "c")
								 (targets-define-to lispyville-atom 'lispyville-atom nil object
																		:bind t :keys "a")
								 (targets-define-to lispyville-list 'lispyville-list nil object
																		:bind t :keys "f")
								 (targets-define-to lispyville-sexp 'lispyville-sexp nil object
																		:bind t :keys "x")
								 (targets-define-to lispyville-function 'lispyville-function nil object
																		:bind t :keys "d")
								 (targets-define-to lispyville-string 'lispyville-string nil object
																		:bind t :keys "s")))
		 :config
		 (lispyville-set-key-theme '(operators
																 c-w
																 prettify
																 (atom-movement t)
																 additional-movement
																 commentary
																 slurp/barf-cp
																 (escape insert)))
		 ;; TODO make these work for visual
		 (evil-define-key '(visual normal) lispyville-mode-map
			 (leader "(") 'lispy-wrap-round
			 (leader "{") 'lispy-wrap-braces
			 (leader "[") 'lispy-wrap-brackets
			 (leader ")") 'lispyville-wrap-with-round
			 (leader "}") 'lispyville-wrap-with-braces
			 (leader "]") 'lispyville-wrap-with-brackets
			 (kbd "M-j") 'lispyville-drag-forward
			 (kbd "M-k") 'lispyville-drag-backward
			 (leader "@") 'lispy-splice
			 (leader "s") 'lispy-split
			 (leader "j") 'lispy-join
			 (leader "r") 'lispy-raise
			 (leader "R") 'lispyville-raise-list
			 (leader "i") 'lispyville-insert-at-beginning-of-list
			 (leader "a") 'lispyville-insert-at-end-of-list
			 (leader "o") 'lispyville-open-below-list
			 (leader "O") 'lispyville-open-above-list))

(pkg which-key
		 :diminish which-key-mode
		 :config (which-key-mode))

(pkg selectrum
		 :config
		 (evil-define-key '(insert normal) selectrum-minibuffer-map
			 (kbd "M-TAB") 'selectrum-insert-current-candidate
			 (kbd "TAB") 'selectrum-next-candidate
			 (kbd "<backtab>") 'selectrum-previous-candidate)
		 (selectrum-mode))

(pkg prescient
		 :config (prescient-persist-mode))

(pkg selectrum-prescient
		 :after (selectrum prescient)
		 :config (selectrum-prescient-mode))

(pkg eldoc
		 :ensure nil
		 :diminish eldoc-mode
		 :config
		 (setq eldoc-idle-delay 0))

(pkg company
		 :diminish company-mode
		 :after (evil evil-collection)
		 :init
		 (setq company-idle-delay 0
					 company-minimum-prefix-length 1)
		 :config
		 (evil-define-key 'insert company-mode-map
			 (kbd "TAB") 'company-complete)
		 (evil-define-key nil company-active-map
			 (kbd "<tab>") (inctive-chain 'company-complete-common 'company-select-next)
			 (kbd "TAB") 'company-select-next
			 (kbd "<backtab>") 'company-select-previous
			 (kbd "M-TAB") 'company-complete-common
			 (kbd "M-q") (inctive-chain 'company-select-first 'company-select-previous)
			 (kbd "<return>") nil
			 (kbd "RET") nil)
		 (global-company-mode))

(pkg all-the-icons
		 :config
		 (unless all-the-icons-fonts-installed?
			 (all-the-icons-install-fonts t)))

(pkg company-box
		 :after (company all-the-icons)
		 :diminish company-box-mode
		 :config
		 (setq company-box-doc-delay 0
					 company-box-icons-all-the-icons
					 `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.8 :face 'all-the-icons-purple))
						 (Text . ,(all-the-icons-material "text_fields" :height 0.8 :face 'all-the-icons-green))
						 (Method . ,(all-the-icons-material "functions" :height 0.8 :face 'all-the-icons-red))
						 (Function . ,(all-the-icons-material "functions" :height 0.8 :face 'all-the-icons-red))
						 (Constructor . ,(all-the-icons-material "functions" :height 0.8 :face 'all-the-icons-red))
						 (Field . ,(all-the-icons-material "functions" :height 0.8 :face 'all-the-icons-red))
						 (Variable . ,(all-the-icons-material "adjust" :height 0.8 :face 'all-the-icons-blue))
						 (Class . ,(all-the-icons-material "class" :height 0.8 :face 'all-the-icons-red))
						 (Interface . ,(all-the-icons-material "settings_input_component" :height 0.8 :face 'all-the-icons-red))
						 (Module . ,(all-the-icons-material "view_module" :height 0.8 :face 'all-the-icons-red))
						 (Property . ,(all-the-icons-material "settings" :height 0.8 :face 'all-the-icons-red))
						 (Unit . ,(all-the-icons-material "straighten" :height 0.8 :face 'all-the-icons-red))
						 (Value . ,(all-the-icons-material "filter_1" :height 0.8 :face 'all-the-icons-red))
						 (Enum . ,(all-the-icons-material "plus_one" :height 0.8 :face 'all-the-icons-red))
						 (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.8 :face 'all-the-icons-red))
						 (Snippet . ,(all-the-icons-material "short_text" :height 0.8 :face 'all-the-icons-red))
						 (Color . ,(all-the-icons-material "color_lens" :height 0.8 :face 'all-the-icons-red))
						 (File . ,(all-the-icons-material "insert_drive_file" :height 0.8 :face 'all-the-icons-red))
						 (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.8 :face 'all-the-icons-red))
						 (Folder . ,(all-the-icons-material "folder" :height 0.8 :face 'all-the-icons-red))
						 (EnumMember . ,(all-the-icons-material "people" :height 0.8 :face 'all-the-icons-red))
						 (Constant . ,(all-the-icons-material "pause_circle_filled" :height 0.8 :face 'all-the-icons-red))
						 (Struct . ,(all-the-icons-material "streetview" :height 0.8 :face 'all-the-icons-red))
						 (Event . ,(all-the-icons-material "event" :height 0.8 :face 'all-the-icons-red))
						 (Operator . ,(all-the-icons-material "control_point" :height 0.8 :face 'all-the-icons-red))
						 (TypeParameter . ,(all-the-icons-material "class" :height 0.8 :face 'all-the-icons-red))
						 ;; (Template   . ,(company-box-icons-image "Template.png"))))
						 (Yasnippet . ,(all-the-icons-material "short_text" :height 0.8 :face 'all-the-icons-green))
						 (ElispFunction . ,(all-the-icons-material "functions" :height 0.8 :face 'all-the-icons-red))
						 (ElispVariable . ,(all-the-icons-material "check_circle" :height 0.8 :face 'all-the-icons-blue))
						 (ElispFeature . ,(all-the-icons-material "stars" :height 0.8 :face 'all-the-icons-orange))
						 (ElispFace . ,(all-the-icons-material "format_paint" :height 0.8 :face 'all-the-icons-pink)))
					 company-box-icons-alist 'company-box-icons-all-the-icons)
		 (add-hook 'company-mode-hook 'company-tng-mode)
		 (add-hook 'company-tng-mode-hook 'company-box-mode))

(pkg company-prescient
		 :after (company prescient)
		 :config (company-prescient-mode))

(pkg rust-mode
		 :config
		 (add-hook 'rust-mode-hook 'lsp))

(pkg projectile
		 :config
		 (projectile-mode)
		 (setq compilation-scroll-output t)
		 (evil-define-key '(insert normal) projectile-mode-map
			 (kbd "<f5>") 'projectile-run-project)
		 (dolist (map evil-collection-compile-maps)
			 (evil-define-key 'normal map
				 "q" (inctive-chain 'kill-compilation 'quit-window)))
		 (setq projectile-project-search-path '("~/code/")))

(pkg flycheck
		 :config
		 (add-hook 'emacs-lisp-mode-hook (lambda () (flycheck-mode -1)))
		 (evil-define-key 'normal flycheck-mode-map
			 (leader "e") 'list-flycheck-errors
			 "]]" 'flycheck-next-error
			 "[[" 'flycheck-previous-error)
		 (global-flycheck-mode))

(pkg lsp-mode
		 :after (company)
		 :config
		 (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
		 (setq lsp-eldoc-enable-hover nil)
		 ;; not sure why this doesn't work if it's on the lsp-mode-map
		 (evil-define-key 'normal 'global
			 (leader "=") 'lsp-format-buffer
			 (leader "gd") 'lsp-find-definition
			 (leader "gD") 'lsp-find-declaration
			 (leader "gr") 'lsp-find-references
			 (leader "gi") 'lsp-find-implementation
			 (leader "gt") 'lsp-find-type-definition
			 ;; (leader "gh") 'hierarchy
			 (leader "ga") 'xref-find-apropos
			 (leader "o") 'lsp-organize-imports
			 (leader "r") 'lsp-rename
			 (leader "te") (lambda () (interactive) (setq lsp-eldoc-enable-hover (not lsp-eldoc-enable-hover)))
			 (leader "a") 'lsp-execute-code-action
			 "K" 'lsp-ui-doc-show
			 "gK" 'lsp-describe-thing-at-point))

(pkg lsp-ui
		 :init
		 (setq lsp-ui-doc-enable t
					 lsp-ui-doc-use-webkit t
					 lsp-ui-doc-delay most-positive-fixnum
					 lsp-ui-doc-position 'at-point
					 lsp-ui-sideline-show-hover t
					 lsp-ui-sideline-show-symbol t
					 lsp-ui-sideline-show-diagnostics t
					 lsp-ui-sideline-show-code-actions t))

(pkg dashboard
		 :after (projectile)
		 :init
		 (setq dashboard-projects-backend 'projectile)
		 :config
		 (setq dashboard-items '((recents . 5) (bookmarks . 5) (agenda . 5) (projects . 5)))
		 (dashboard-setup-startup-hook))

(pkg page-break-lines
		 :config
		 (page-break-lines-mode))

(pkg highlight-indent-guides
		 :config
		 (setq highlight-indent-guides-method 'character)
		 (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(pkg magit
		 :config
		 (evil-define-key 'normal 'global
			 (leader "m") 'magit)
		 (evil-define-key 'normal magit-mode-map
			 (kbd "M-h") 'magit-section-up
			 (kbd "M-j") 'magit-section-forward-sibling
			 (kbd "M-k") 'magit-section-backward-sibling))
(pkg treemacs
		 :config
		 (evil-define-key 'normal 'global
			 "gt" 'treemacs))
(pkg treemacs-evil
		 :after (treemacs evil))
(pkg treemacs-all-the-icons
		 :after (treemacs all-the-icons)
		 :config
		 (treemacs-load-theme 'all-the-icons))
(pkg treemacs-projectile
		 :after (treemacs projectile))
(pkg treemacs-icons-dired
		 :after (treemacs))
(pkg treemacs-magit
		 :after (treemacs magit))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
