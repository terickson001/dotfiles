;;; caseformat-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "caseformat" "caseformat.el" (0 0 0 0))
;;; Generated autoloads from caseformat.el

(autoload 'caseformat-convert "caseformat" "\
Convert STRING based on TABLE.
TABLE is a list like `caseformat-converter-table'.

Example:
  (caseformat-convert \"-foo:bar\")
  ;; => \"FooBAR\"

\(fn STRING &optional (TABLE caseformat-converter-table))" nil nil)

(autoload 'caseformat-forward "caseformat" "\
Convert non-whitespace characters from point.
If ARG is a number, this converts ARG chunks of characters.
This command does not move the cursor position.

\(fn &optional ARG)" t nil)

(autoload 'caseformat-backward "caseformat" "\
Convert non-whitespace characters backward from point.
If ARG is a number, this converts ARG chunks of characters.
This command does not move the cursor position.

\(fn &optional ARG)" t nil)

(autoload 'caseformat-mode "caseformat" "\
A minor-mode to manage caseformat commands.

\(fn &optional ARG)" t nil)

(defvar global-caseformat-mode nil "\
Non-nil if Global Caseformat mode is enabled.
See the `global-caseformat-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-caseformat-mode'.")

(custom-autoload 'global-caseformat-mode "caseformat" nil)

(autoload 'global-caseformat-mode "caseformat" "\
Toggle Caseformat mode in all buffers.
With prefix ARG, enable Global Caseformat mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Caseformat mode is enabled in all buffers where
`caseformat--turn-on-caseformat-mode' would do it.
See `caseformat-mode' for more information on Caseformat mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caseformat" '("caseformat-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; caseformat-autoloads.el ends here
