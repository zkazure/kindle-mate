(require 'ert)
(require 'kindle-mate)

(ert-deftest kindle-mate-reset-parameters-test ()
  (let ((kindle-mate-full-clippings "x")
        (kindle-mate-book-name "y")
        (kindle-mate-book-log "z")
        (kindle-mate-book-notes "w"))
    (kindle-mate-resets-parameters)
    (should (equal kindle-mate-full-clippings ""))
    (should (equal kindle-mate-book-name ""))
    (should (equal kindle-mate-book-log ""))
    (should (equal kindle-mate-book-notes ""))))

(ert-deftest kindle-mate-gets-full-clippings-test ()
  (let ((kindle-mate-clippings-path "./My Clippings.txt"))
    (should (>  (length (kindle-mate-get-full-clippings)) 0))))

(ert-deftest kindle-mate-split-into-chunks-test ()
  (let ((kindle-mate-split-string "=="))
    (should (equal (kindle-mate-split-into-chunks
                    "==a==b==c==")
                   '("a" "b" "c")))))
