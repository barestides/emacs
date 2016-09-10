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

;;ace-window binding
(global-set-key (kbd "C-,") 'ace-window)
(global-set-key (kbd "C-x C-j") 'switch-to-buffer)

;;Evil mode and evil leader
(require 'evil)
(evil-mode 1) 
(global-evil-leader-mode)

;;evil customizations
(defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
  (evil-scroll-line-to-center (line-number-at-pos)))

;;smex
(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-x") 'smex-major-mode-commands)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(projectile-global-mode)

