;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Custom
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Use-Package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Disable lock files
(setq create-lockfiles nil)

;; Store backup and autosave in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Disable dialog box
(setq use-dialog-box nil)

;; Font
(set-frame-font "SF Mono 10" nil t)

;; Disable toolbar, scrollbar, menubar
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; 2 character margin on left and right
(add-hook 'window-configuration-change-hook
          (lambda ()
            (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 4 4)))

;; Disable the start page
(setq inhibit-startup-screen t)

;; Tab in Evil
(setq evil-want-C-i-jump nil)
;; Evil
(unless (package-installed-p 'evil)
(package-install 'evil))
(use-package evil
    :config
    (evil-mode 1))


; Line numbers
(use-package linum-relative
    :init
    (setq linum-relative-backend 'display-line-numbers-mode)
    :config
    (add-hook 'prog-mode-hook 'linum-relative-mode))
    

;; Start page
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title "Welcome to Vi IMproved!")
  (setq dashboard-startup-banner "~/.emacs.d/kyuu.png")
  :config
  (dashboard-setup-startup-hook))

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; Spaceline
(use-package spaceline-config
    :config
    (spaceline-emacs-theme))

;; Ewal
(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
              ewal-use-built-in-on-failure-p t
              ewal-built-in-palette "sexy-material"))
(use-package ewal-spacemacs-themes
  :init (progn
          (setq spacemacs-theme-underline-parens t
                my:rice:font (font-spec
                              :family "SF Mono"
                              :size 10.0))
          (show-paren-mode +1)
          (global-hl-line-mode)
          (set-frame-font my:rice:font nil t)
          (add-to-list  'default-frame-alist
                        `(font . ,(font-xlfd-name my:rice:font))))
  :config (progn
            (load-theme 'ewal-spacemacs-modern t)
            (enable-theme 'ewal-spacemacs-modern)))
(use-package ewal-evil-cursors
  :after (ewal-spacemacs-themes)
  :config (ewal-evil-cursors-get-colors
           :apply t :spaceline t))
(use-package spaceline
  :after (ewal-evil-cursors winum)
  :init (setq powerline-default-separator nil)
  :config (spaceline-spacemacs-theme))

;; Company (Autocompletion)
(use-package company
  :config 
  (add-hook 'after-init-hook 'global-company-mode)
  (company-tng-configure-default)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; LSP-mode
(setq lsp-keymap-prefix "C-l")
(use-package lsp-mode
  :init
  (setq lsp-message-project-root-warning 0)
  :hook
  (c-mode . lsp)
  (c++-mode . lsp)
  (java-mode . lsp)
  (python-mode . lsp))

;; Company-LSP
(use-package company-lsp
  :commands
  (company-lsp)
  :config
  (push 'company-lsp company-backends))

;; Flycheck (syntax checking)
(use-package flycheck
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode))

