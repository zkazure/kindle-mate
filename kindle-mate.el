;;; kindle-mate.el --- Short description -*- lexical-binding: t; -*-

;; Author: Kazure Zheng <kazurezheng@gmail.com>
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1"))
;; Keywords: kindle
;; URL: https://github.com/zkazure/kindle-mate.git

;;; Commentary:
;; read "My Clippings.txt" from kindle device,
;; search for corresponding notes with fuzzy-book-name,
;; then output the book-notes

;;; Code:

(defvar kindle-mate-clippings-path
  (concat "/run/media/" (user-login-name) "/Kindle/"))
(defvar kindle-mate-full-clippings "")
(defvar kindle-mate-book-name "")
(defvar kindle-mate-book-log "")
(defvar kindle-mate-book-notes "")
(defconst kindle-mate-split-string "==========")

(defun kindle-mate-resets-parameters ()
  "reset some important parameters"
  (setq kindle-mate-full-clippings ""
        kindle-mate-book-name ""
        kindle-mate-book-log ""
        kindle-mate-book-notes ""
        ))

(defun kindle-mate-split-into-chunks (str)
  "split str into chunks by split-string"
  (let ((chunks
         (split-string str kindle-mate-split-string t)))
    chunks)
  )

(provide 'kindle-mate)
;;; kindle-mate.el ends here
