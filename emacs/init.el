(menu-bar-mode -1)
(toggle-scroll-bar -1) (tool-bar-mode -1)

(setq show-paren-delay 0)
(show-paren-mode)

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

(pkg goto-chg)
(pkg undo-tree
     :custom
     (undo-tree-visualizer-timestamps t)
     (undo-tree-visualizer-lazy-drawing nil)
     (undo-tree-auto-save-history t)
     :init
     (let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
       (setq undo-tree-history-directory-alist (list (cons "." undo-dir))))
     :config
     (global-undo-tree-mode))
(pkg evil
     :custom
     (evil-want-integration t) ;; This is optional since it's already set to t by default.
     (evil-want-keybinding nil)
     (evil-search-module 'evil-search)
     (evil-undo-system 'undo-tree)
     (evil-set-undo-system 'undo-tree)
     (evil-ex-substitute-global t)
     (setq evil-emacs-state-cursor 'box
	   evil-normal-state-cursor 'box
	   evil-visual-state-cursor 'box
	   evil-insert-state-cursor 'bar
	   evil-replace-state-cursor 'hbar
	   evil-operator-state-cursor 'hollow)
     :config
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
     (evil-define-key 'motion 'global (kbd "M-e") 'evil-backward-word-end)
     (evil-define-key 'motion 'global (kbd "M-E") 'evil-backward-WORD-end)
     (evil-define-key 'normal 'global (kbd "ge") 'evil-eval)
     (evil-define-key 'visual 'global (kbd "ge") 'evil-eval)
     (evil-define-key 'normal 'global (kbd "gs") 'evil-replace-with-reg)
     (evil-define-key 'visual 'global (kbd "gs") 'evil-replace-with-reg)
     (evil-define-key 'normal 'global (kbd "C-u") 'evil-scroll-up)
     (evil-mode 1))

(pkg auto-package-update
     :custom
     (auto-package-update-delete-old-versions t)
     (auto-package-update-hide-results t)
     :config
     (auto-package-update-maybe))

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
     :after evil
     :custom
     (evil-collection-setup-minibuffer t)
     :config
     (setq evil-collection-mode-list (delete 'lispy evil-collection-mode-list))
     (evil-collection-init))

(pkg lispy
     :after evil-collection
     :init
     (add-hook 'emacs-lisp-mode-hook 'lispy-mode)
     (add-hook 'common-lisp-mode-hook 'lispy-mode)
     (add-hook 'scheme-mode-hook 'lispy-mode)
     (add-hook 'lisp-mode-hook 'lispy-mode))

(pkg lispyville
     :init
     (add-hook 'lispy-mode-hook
               (lambda ()
		 (lispyville-mode)
		 (targets-define-to lispyville-comment 'lispyville-comment nil object
				    :bind t :keys   "c")
		 (targets-define-to lispyville-atom 'lispyville-atom nil object
				    :bind t :keys "a")
		 (targets-define-to lispyville-list 'lispyville-list nil object
				    :bind t :keys "f")
		 (targets-define-to lispyville-sexp 'lispyville-sexp nil object
				    :bind t :keys "x")
		 (targets-define-to lispyville-function 'lispyville-function nil object
				    :bind t :keys "d")
		 (targets-define-to lispyville-comment 'lispyville-comment nil object
				    :bind t :keys "c")
		 (targets-define-to lispyville-string 'lispyville-string nil object
				    :bind t :keys "s")))

     :config
     (lispyville-set-key-theme '(operators
				c-w
				prettify
				additional-movement
				commentary
				slurp/barf-cp
				additional
				(escape insert))))

(add-to-list 'default-frame-alist '(font . "Iosevka 9"))
(set-face-attribute 'default t :font "Iosevka")

(global-display-line-numbers-mode 1)
(setq-default display-line-numbers t
              display-line-numbers-widen t
	      display-line-numbers-type 'relative)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(centered-scroll lispyville evil-surround lispy evil)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
