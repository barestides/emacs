(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Add MELPA
(when (>= emacs-major-version 24)
    (require 'package)
      (add-to-list
           'package-archives
              '("melpa" . "http://melpa.org/packages/")
                 t)
        (package-initialize))

;;Zenburn color theme
(load-theme 'zenburn t)

;;line highlighting
(global-hl-line-mode 1)

;;ido vertical display
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;;ace-window binding
(global-set-key (kbd "C-,") 'ace-window)
(global-set-key (kbd "C-x C-j") 'switch-to-buffer)

;;Evil mode and evil leader
(require 'evil)
(evil-mode 1) 
(global-evil-leader-mode)
(require 'evil-magit)

;;Relative line numbers
(require 'linum-relative)

;;vimish-fold
(require 'vimish-fold)
(global-set-key (kbd "C-;") #'vimish-fold-toggle)
(global-set-key (kbd "C-'") #'vimish-fold)

;;CIDER package / toolkit
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook
	  (lambda () (local-set-key (kbd "C-l") #'cider-repl-clear-buffer)))
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

;;Enable paredit when in clojure mode
(add-hook 'clojure-mode-hook 'paredit-mode)

;;new paredit keybindings to work with evil-mode
(evil-define-key 'normal paredit-mode-map (kbd "M->") 'paredit-forward-slurp-sexp)
(evil-define-key 'normal paredit-mode-map (kbd "M-<") 'paredit-forward-barf-sexp)
(evil-define-key 'normal paredit-mode-map (kbd "C-<") 'paredit-backward-slurp-sexp)
(evil-define-key 'normal paredit-mode-map (kbd "C->") 'paredit-backward-barf-sexp)

(evil-define-key 'insert paredit-mode-map (kbd "M->") 'paredit-forward-slurp-sexp)
(evil-define-key 'insert paredit-mode-map (kbd "M-<") 'paredit-forward-barf-sexp)
(evil-define-key 'insert paredit-mode-map (kbd "C-<") 'paredit-backward-slurp-sexp)
(evil-define-key 'insert paredit-mode-map (kbd "C->") 'paredit-backward-barf-sexp)

;;evil customizations
(defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

;;smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;Projectile
(projectile-global-mode)

;;Function that actually clears eshell properly
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(add-hook 'eshell-mode-hook
      '(lambda()
          (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

;;Eshell custom prompt
(setq eshell-prompt-function
      (lambda()
        (concat
	  ((lambda (p-lst)
	     (mapconcat (lambda (elm) (propertize (substring elm 0 1) 'face `(:foreground "green")))
                                   p-lst 
                                   "/"))
                 (split-string (eshell/pwd) "/"))
                (if (= (user-uid) 0) " # " " $ "))))
