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

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

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
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;;Disable mouse
(require 'disable-mouse)
(global-disable-mouse-mode)

;;Evil mode and evil leader
(require 'evil)
(evil-mode 1)
;; (global-evil-leader-mode)
(require 'evil-magit)

;;Relative line numbers
(require 'linum-relative)

(require 'eclim)
(setq eclimd-autostart t)
(global-eclim-mode)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)

(add-hook 'after-init-hook 'global-company-mode)

;;Change next and previous in company drop down to use control rather than meta
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

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

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;;Key chord to make simultaneous 'jk' bind to escape
(setq key-chord-two-keys-delay 0.15)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)


(setq visible-bell 1)

;;smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
;;old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
	     [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
	     [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
	     [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
	     [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

;;Projectile
(projectile-global-mode)
(setq projectile-switch-project-action 'neotree-projectile-action)

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

;;Remove white space upon save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;Eclim
(require 'eclim)
(setq eclimd-autostart t)
(global-eclim-mode)

;;Save buffers and stuff on exit
(desktop-save-mode 1)


;; ;;Eshell custom prompt
;; (setq eshell-prompt-function
;;       (lambda()
;;         (concat
;; 	  ((lambda (p-lst)
;; 	     (mapconcat (lambda (elm) (propertize (substring elm 0 1) 'face `(:foreground "green")))
;;                                    p-lst
;;                                    "/"))
;;                  (split-string (eshell/pwd) "/"))
;;                 (if (= (user-uid) 0) " # " " $ "))))

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun custom-stop ()
  (interactive)
  (cider-interactive-eval
   (format "(stop)")))

;;treat hyphens as part of words
(modify-syntax-entry ?- "w")

(define-key cider-mode-map (kbd "C-c C-w") 'custom-stop)

;;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
