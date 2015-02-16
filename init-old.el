(require 'cl)
(require 'package)

;; emacs package management using http://wikemacs.org/wiki/Package.el
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

; dependencies
(defvar packages '(
  python
  haskell-mode
  yaml-mode
  markdown-mode
  coffee-mode 
  scss-mode
  sass-mode
  magit
  rainbow-delimiters
  rainbow-blocks
;  gist
  deft
;  nxhtml
;  auctex
;  switch-window ; (replace C-x o)
;  auto-complete
  viper
;; color themes
  color-theme-ir-black
))


;; go mode
;; alternatively; M-x package install go-mode (could be outdated)
;
;(setq load-path (cons "/usr/local/go/misc/emacs" load-path))
;(require 'go-mode-load)


; predicate `-p` to check if we need to install any packages 
(defun all-packages-installed-p ()
  (loop for pkg in packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

;; install all packages not yet installed
(unless (all-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p))))

;-----------------------------------------------------------

; setup rainbow colored delimiter
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

; mode hooks
(add-to-list 'auto-mode-alist '("\\.txt\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))

(require 'haskell-mode)
; setup indent mode for haskell
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(setq haskell-program-name "cabal repl")
(setq haskell-process-path-cabal "/Users/wires/Library/Haskell/bin/cabal")
(setq haskell-process-type (quote cabal-repl))

; enable ido-mode
;(require 'ido)
(ido-mode t)
;(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enabled-flex-matching t)
;(setq ido-file-extensions-order '(".org" ".md" ".txt" ".js" ".py" ".hs" ."v"))

; switch buffers with C-b (instead of `C-x b`) 
(global-set-key (kbd "C-b") 'ido-switch-buffer)

; regular copy-past
(cua-mode t)

; use latexmk -pdf to compile LaTeX
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run Latexmk on file")
    TeX-command-list))
 )

; enable wordwrap
(setq word-wrap t)

; no splash screen, thanks
(setq inhibit-splash-screen t)

; have line numbers and column numbers in the mode line
(line-number-mode 1)
(column-number-mode 1)

; disable toolbar and scrollbar
(tool-bar-mode -1)
(scroll-bar-mode -1)

(unless (string-match "apple-darwin" system-configuration)
  ;; on mac, there's always a menu bar drawn, don't have it empty
  (menu-bar-mode -1)
)
