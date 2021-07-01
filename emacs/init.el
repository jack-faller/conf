(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defmacro pkg (name &rest args)
  `(use-package ,name :ensure t ,@args))

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
     (evil-want-fine-undo t)
     (evil-ex-substitute-global t)
     :config
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

; centre line on scroll
(add-hook 'post-command-hook #'recenter)

(pkg evil-collection
     :after evil
     :custom
     (evil-collection-setup-minibuffer t)
     :init
     (evil-collection-init))

(pkg lispy
     :config
     (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))
(pkg lispyville
     :init
     (add-hook 'emacs-lisp-mode-hook #'lispyville-mode)
     (add-hook 'lisp-mode-hook #'lispyville-mode)
     :config
     (lispyville-set-key-theme '(operators c-w additional)))

(add-to-list 'default-frame-alist '(font . "Iosevka 9"))
(set-face-attribute 'default t :font "Iosevka")

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq evil-emacs-state-cursor '("black" box)
      evil-normal-state-cursor '("black" box)
      evil-visual-state-cursor '("black" box)
      evil-insert-state-cursor '("black" bar)
      evil-replace-state-cursor '("black" bar)
      evil-operator-state-cursor '("black" hollow))

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
