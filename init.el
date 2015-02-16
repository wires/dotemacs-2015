(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-initialize)

;; update package list
(when (not package-archive-contents)
  (package-refresh-contents))

;; load these packages
(defun ensure-installed (packages)
  (dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; (defun load-user-file (file)
;;   (interactive "f")
;;   "Load a file in current user's configuration directory"
;;   (load-file (expand-file-name file "~/.emacs.d/")))

;; ;; clojure(script)
;; (ensure-installed '(clojure-mode
;; 		    monroe
;; 		    rainbow-delimiters))

;; ;; https://github.com/sanel/monroe
;; (require 'monroe)
;; (add-hook 'clojure-mode-hook 'clojure-enable-monroe)
;; (setq monroe-default-host "localhost:55115")

(ensure-installed '(better-defaults
		    clojure-mode
                    rainbow-delimiters
		    cider
		    projectile
                    cl
                    color-theme
                    color-theme-ir-black
                    color-theme-solarized
                    ido
                    ido-ubiquitous
                    flx-ido
                    company
                    neotree
                    ;;evil
                    markdown-mode
                    smartparens))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(autoload 'markdown-mode "markdown-mode"
       "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.txt\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(projectile-global-mode)
(global-company-mode)
(smartparens-global-mode t)
(require 'smartparens-config)
;;(evil-mode 1)

;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(setq ido-file-extensions-order '(".clj" ".cljs" ".cljx" ".md" ".el" ".js" ".json" ".py"))

;; use ibuffer instead of buffer-menu?
(global-set-key (kbd "C-b") 'ido-switch-buffer)

(load-theme 'solarized-dark t)
;(load-theme 'ir-black t)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

    Move point to the first non-whitespace character on this line.  If
    point is already there, move to the beginning of the line.
    Effectively toggle between the first non-whitespace character and the
    beginning of the line.

    If ARG is not nil or 1, move forward ARG - 1 lines first.  If point
    reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(global-set-key (kbd "C-o") 'projectile-find-file)

(setq cider-auto-select-error-buffer nil)

(color-theme-initialize)
