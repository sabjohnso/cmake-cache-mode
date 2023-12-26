;;; cmake-cache-mode.el --- major-mode for viewing CMakeCache.txt files -*- lexical-binding: t -*-

;; Copyright (c) 2024 Samuel B. Johnson

;;; Commentary
;;

;;; Code

(defvar cmake-cache-font-lock-keywords
  `(("\\(//.*$\\)" 1 font-lock-doc-face)
    ("^\\([0-9A-Za-z_-]+\\):"  1 font-lock-variable-name-face)
    (":\\([0-9A-Za-z_-]+\\)=" 1 font-lock-type-face))
  "Default `font-lock-keywords' for `cmake-cache-mode'.")

(defvar cmake-cache-mode-map
  (let ((map (make-sparse-keymap))
        (menu-map (make-sparse-keymap)))
    (define-key map "\C-c\C-c" #'comment-region)
    (define-key map [menu-bar cmake-cache-mode] (cons "CMakeCache" menu-map))
    (define-key menu-map [dfc]
      '(menu-item "Comment Region" comment-region
                  :help "Comment Region"))
    map))

(defvar cmake-cache-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?' "\"" table)
    (modify-syntax-entry ?= "." table)
    table)
  "Syntax table for `cmake-cache-mode'.")


;;;###autoload
(define-derived-mode cmake-cache-mode prog-mode "CMakeCache"
  "A major mode for viewing CMakeCache.txt files
\\{cmake-cache-mode-map}"
  (set-syntax-table cmake-cache-mode-syntax-table)
  (set (make-local-variable 'require-final-newline) mode-require-final-newline)
  (set (make-local-variable 'comment-start) "#")
  (set (make-local-variable 'comment-end) "")
  (set (make-local-variable 'comment-start-skip) "#+ *")
  (set (make-local-variable 'font-lock-defaults)
       '(cmake-cache-font-lock-keywords nil t)))

;;;###autoload
(add-to-list 'auto-mode-alist '("CMakeCache\\.txt" . 'cmake-cache-mode))

(provide 'cmake-cache-mode)

;;; cmake-cache-mode.el ends here

