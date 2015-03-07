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

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file "~/.emacs.d/conf")))

(ensure-installed '(better-defaults
		    clojure-mode
                    rainbow-delimiters
		    cider
		    projectile
                    cl
                    color-theme
                    ir-black-theme
                    color-theme-solarized
                    ido
                    ido-ubiquitous
                    flx-ido
                    company
                    neotree
                    evil
                    markdown-mode
                    smartparens))

(global-company-mode)
(projectile-global-mode)

(load-user-file "move-begin.el")
(load-user-file "evil-mode.el")
;(load-user-file "color-theme.el")
;(load-user-file "markdown.el")
;(load-user-file "purescript.el")
(load-user-file "clojure.el")


(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(setq ido-file-extensions-order '(".clj" ".cljs" ".cljx" ".md" ".el"
                                  ".js" ".json" ".py" ".purs" ".elm"))

;; use ibuffer instead of buffer-menu
(global-set-key (kbd "C-b") 'ido-switch-buffer)


(global-set-key (kbd "C-o") 'projectile-find-file)
