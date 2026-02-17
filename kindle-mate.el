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
  (concat "/run/media/" (user-login-name)
          "/Kindle/documents/My Clippings.txt"))
(defvar kindle-mate-full-clippings "")
(defvar kindle-mate-book-name "")
(defvar kindle-mate-book-log "")
(defvar kindle-mate-book-notes "")
(defconst kindle-mate-split-string "==========")

(defun kindle-mate-reset-parameters ()
  "reset some important parameters"
  (setq kindle-mate-full-clippings ""
        kindle-mate-book-name ""
        kindle-mate-book-log ""
        kindle-mate-book-notes ""
        ))

(defun kindle-mate-get-full-clippings ()
  (with-temp-buffer
    (insert-file-contents kindle-mate-clippings-path)
    (string-replace "\r" "\n" (buffer-string))))

(defun kindle-mate-split-into-chunks (str)
  "split str into chunks by split-string"
  (let ((chunks
         (split-string str kindle-mate-split-string t)))
    chunks)
  )

(defun kindle-mate-split-into-book-data (chunk)
  "split every chunk into book-data"
  (let ((chunk (string-trim chunk)))
    (unless (string-empty-p chunk)
      (let* ((lines (split-string chunk "\n" t))
             (book-name (car lines))
             (book-log (cadr lines))
             (book-note (cddr lines)))
        `((name . ,book-name)
          (log . ,book-log)
          (note . ,book-note))
        )))
  )

(defun kindle-mate-set-name-pattern (fuzzy-book-name)
  "set the name pattern based on fuzzy-book-name"
  (let ((pattern (rx line-start
                     (* anything)
                     (literal fuzzy-book-name)
                     (* anything)
                     line-end)))
    pattern))

(defun kindle-mate-get-real-book-name (pattern str)
  "get the real book name based on pattern"
  (cl-some (lambda (line)
             (when (string-match pattern line)
               (string-trim (match-string 0 line))))
           (split-string str "\n" t)))

(defun kindle-mate-process-book-data (book-data)
  "add all notes corresponding to target book to kindle-mate-book-notes"
  (when (and book-data
             (> (length book-data) 0)
             (string= kindle-mate-book-name
                      (alist-get 'name book-data)))
    (setq kindle-mate-book-notes
          (concat kindle-mate-book-notes
                  "\n\n"
                  (alist-get 'note book-data)))
    ))

(provide 'kindle-mate)
;;; kindle-mate.el ends here
