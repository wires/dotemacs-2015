(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; update package list
(when (not package-archive-contents)
  (package-refresh-contents))

;; define a list of packages
(defvar packages '(
	clojure-mode
	nrepl
))

;; install the uninstalled
(dolist (p packages)
  (when (not (package-installed-p p))
      (package-install p)))
