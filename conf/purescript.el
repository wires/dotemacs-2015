

(add-to-list 'load-path "~/.emacs.d/purescript-mode/")
(require 'purescript-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/.emacs.d/purescript-mode/")
(add-hook 'purescript-mode-hook #'turn-on-purescript-indent)

(setq cider-auto-select-error-buffer nil)
