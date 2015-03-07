
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(smartparens-global-mode t)
(require 'smartparens-config)

(setq cider-lein-command "~/bin/lein")

;; hide *nrepl-connection* and *nrepl-server* buffers for `C-x b`
(setq nrepl-hide-special-buffers t)
