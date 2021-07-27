(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; disable gc during startup
(setq startup/gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(defun startup/reset-gc () (setq gc-cons-threshold startup/gc-cons-threshold))
(add-hook 'emacs-startup-hook 'startup/reset-gc)

(setq show-paren-delay 0)
(show-paren-mode)
(electric-pair-mode)

(defun leader (str)
  (kbd (concat "SPC " str)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
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
     :straight (el-patch
		:type git
		:host github
		:repo ,repo)
     ,@args))

(pkg auto-package-update
     :init
     (setq auto-package-update-delete-old-versions t)
     (setq auto-package-update-hide-results t)
     :config
     (auto-package-update-maybe))

(pkg diminish)
(pkg goto-chg)

(pkg undo-tree
     :diminish undo-tree-mode
     :init
     (setq undo-tree-visualizer-timestamps t)
     (setq undo-tree-visualizer-lazy-drawing nil)
     (setq undo-tree-auto-save-history t)
     (let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
       (setq undo-tree-history-directory-alist (list (cons "." undo-dir))))

     :config
     (global-undo-tree-mode))
(pkg evil
     :init
     (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
     (setq evil-want-keybinding nil)
     (setq evil-cross-lines t)
     (setq evil-search-module 'evil-search)
     (setq evil-undo-system 'undo-tree)
     (setq evil-set-undo-system 'undo-tree)
     (setq evil-ex-substitute-global t)
     (setq evil-want-C-u-scroll t)
     (setq evil-want-visual-char-semi-exclusive t)
     (setq evil-want-Y-yank-to-eol t)
     (setq evil-ex-search-vim-style-regexp t)
     (setq evil-ex-substitute-global t)
     (setq evil-ex-visual-char-range t) ; column range for ex commands this doesn't work
     ;; more vim-like behavior
     (setq evil-symbol-word-search t)
     ;; don't activate mark on shift-click
     (setq shift-select-mode nil)

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
     (evil-define-operator evil-replace-with-reg (beg end register)
       "Evil operator for evaluating code."
       (interactive "<r><x>")
       (evil-delete beg end :register ?_)
       (evil-paste-before 1 register))
     (evil-define-key 'motion 'global
       (kbd "M-e") 'evil-backward-word-end
       (kbd "M-E") 'evil-backward-WORD-end)
     (evil-define-key '(normal visual) 'global
       "ge" 'evil-eval
       "gs" 'evil-replace-with-reg)
     (defun subst-% () (interactive) (evil-ex "%s/"))
     (evil-define-key 'normal 'global
       "S" 'subst-%
       "gb" 'ibuffer
       (leader ";") 'execute-extended-command)
     (evil-define-key nil 'global
      (kbd "C-h") 'evil-window-left
      (kbd "C-j") 'evil-window-down
      (kbd "C-k") 'evil-window-up
      (kbd "C-l") 'evil-window-right
      (kbd "C-q") 'evil-quit
      (kbd "M-RET") 'evil-window-vnew
      (kbd "M-DEL") 'evil-window-new)
     (evil-mode 1))

(pkg evil-surround
     :config
     (global-evil-surround-mode 1))

(pkg-github targets "noctuid/targets.el"
	    :config
	    (targets-setup t))

(pkg evil-exchange
     :config (evil-exchange-install))

; centre line on scroll
(add-hook 'post-command-hook #'recenter)

(pkg evil-collection
     :diminish evil-collection-unimpaired-mode
     :after evil
     :init
     (setq evil-collection-setup-minibuffer t)
     :config
     (setq evil-collection-mode-list (delete 'lispy evil-collection-mode-list))
     (evil-collection-init))

(pkg lispy
     :diminish lispy-mode
     :after evil-collection)

(pkg lispyville
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
     (evil-define-key 'normal lispyville-mode-map
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
     :config (selectrum-prescient-mode))

(pkg eldoc
     :ensure nil
     :diminish eldoc-mode
     :config
     (setq eldoc-idle-delay 0))

(pkg company
     :diminish company-mode
     :init
     (setq company-idle-delay 0)
     (setq company-minimum-prefix-length 0)
     :config
     (evil-define-key nil company-active-map
       (kbd "M-TAB") 'company-complete-common)
     (global-company-mode))

(pkg company-prescient
     :config (company-prescient-mode))

(pkg yasnippet
     :diminish yas-minor-mode
     :config
     (yas-reload-all)
     (add-hook 'prog-mode-hook 'yas-minor-mode)
     (add-hook 'text-mode-hook 'yas-minor-mode))

(pkg company-box
     :diminish company-box-mode
     :hook (company-mode . company-box-mode))

(pkg rust-mode)

(pkg projectile
     :config
     (projectile-mode)
     (setq projectile-project-search-path '("~/code/")))

(pkg flycheck
     :config
     (add-hook 'emacs-lisp-mode-hook (lambda () (flycheck-mode -1)))
     (evil-define-key 'normal flycheck-mode-map
       "]]" 'flycheck-next-error
       "[[" 'flycheck-previous-error)
     (global-flycheck-mode))

(pkg lsp-mode
     :init
     (setf lsp-keymap-prefix "SPC")
     :config
     (lsp-mode)
     (add-hook 'rust-mode-hook 'lsp)
     (add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)
     (evil-define-key 'normal lsp-mode-map
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
       "K" 'lsp-describe-thing-at-point))

(pkg dashboard
  :config
  (dashboard-setup-startup-hook))

(add-to-list 'default-frame-alist '(font . "Iosevka 9"))
(set-face-attribute 'default t :font "Iosevka")

(global-display-line-numbers-mode 1)
(setq-default display-line-numbers t
	      display-line-numbers-widen t
	      display-line-numbers-type 'relative)
