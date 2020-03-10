(setq debug-on-error t)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (base16-zenbu)))
 '(custom-safe-themes
   (quote
    ("2e47afef55f842cc112b49103aad0cdf03f44e5c5c780621fcd22746b2ec353e" "a2ec1b9fb1001e0ff20cf4d8081d274e9e4ea5d54b41111bc018aab481868fd5" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "a920cba1f85f5d03189eb6a2ab421d5496a78022eb4e2411d557a91eca235e19" "886e74277dbab78e6db7138110dcd98cf44efc5eca72bca0947bd9c808a70edb" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437" "f117df52101107896ac5e4eef012c9f29f9c00c45e3048cbbcaef91d6f251904" "375a2072b175f88bbfb16272de07cf430d503488041ac33ec4d9fb337deb45d0" "338af97935405489710fb977a198bb833e9ffd34fbf2fab32b38637975369103" "b03a8d0138a52aa91c3b1a062281677c01e3a606dcddfba18d6fdcc657f147be" "e4c8810d9ab925567a69c11d5c95d198a4e7d05871453b2c92c020712559c4c1" default)))
 '(icicle-download-dir "~/.emacs.d/manual/icicles")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (textx-mode rust-mode caseformat autodisass-llvm-bitcode idle-highlight-in-visible-buffers-mode ssh find-file-in-project gitignore-mode lua-mode naysayer-theme flycheck htmlize org-bullets fastnav nlinum ecb wrap-region company iy-go-to-char ace-jump-mode ido-completing-read+ ido-vertical-mode fuzzy wc-mode org-journal sudo-edit iedit rainbow-delimiters slime elscreen elscreen-mew highlight-parentheses powerline base16-theme magit)))
 '(search-default-mode t)
 '(search-highlight nil)
 '(send-mail-function (quote sendmail-send-it)))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load "server")
(unless (server-running-p) (server-start))

(add-to-list 'load-path "~/.emacs.d/manual")
(let ((default-directory "~/.emacs.d/manual"))
  (normal-top-level-add-subdirs-to-load-path))

;; Backups
(make-directory "~/.saves" t)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-list-file-prefix "~/.saves/.auto-saves-")
(setq auto-save-file-name-transforms
      `((".*" , "~/.saves" t)))

;; (setq make-backup-files nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

(setq echo-keystrokes 0.1)

(require 'powerline)
(powerline-default-theme)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(if (display-graphic-p)
    (progn
      (load-theme 'naysayer t) )
  (setq base16-theme-256-color-source "base16-shell")
  (load-theme 'base16-zenbu t) )

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(global-set-key (kbd "S-<f1>")
  (lambda ()
    (interactive)
    (dired ".") ))

(elscreen-start)

(global-set-key
 (kbd "C-x t")
 'elscreen-find-file )

(require 'typing-practice)

(load-file "~/.emacs.d/manual/discord-emacs.el")
(discord-emacs-run "384815451978334208")

(electric-pair-mode 0)

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)

(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-auto-merge-work-directories-length -1)

(require 'ido-completing-read+)
(ido-ubiquitous-mode t)

;; (require 'ido-vertical-mode)
;; (ido-vertical-mode t)

(require 'ido-better-flex)
(ido-better-flex/enable)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-line-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-x s") 'save-buffer)

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c C-e") 'eval-and-replace)

(defun reload-theme ()
  "Reload the current theme"
  (interactive)
  (let* ((curr-theme (car custom-enabled-themes)))
    (unload-feature (intern (concat (symbol-name curr-theme) "-theme")))
    (load-theme curr-theme)))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; emacs-lisp-mode
(add-to-list 'auto-mode-alist '("\\emacs$" . emacs-lisp-mode))

;; Disable where necessary (i.e. term-mode)
(global-nlinum-mode t)

;; org-journal-mode
(add-hook
 'org-journal-mode-hook
 '(lambda ()
    (flyspell-mode t)
    (wc-mode t) ))

;; c-mode
(if (not (numberp (position 'naysayer custom-enabled-themes)))
    (font-lock-add-keywords
     'c-mode
     '(
       ("\\_<\\(\\(?:NULL\\|_\\(?:Bool\\|Complex\\|Imaginary\\|_\\(?:a\\(?:\\(?:sm\\|ttribute\\)__\\)\\|declspec\\)\\)\\|a\\(?:sm\\|uto\\)\\|break\\|c\\(?:ase\\|har\\|on\\(?:st\\|tinue\\)\\)\\|d\\(?:efault\\|o\\(?:uble\\)?\\)\\|e\\(?:lse\\|num\\|xtern\\)\\|f\\(?:loat\\|or\\)\\|goto\\|i\\(?:f\\|n\\(?:line\\|t\\)\\)\\|long\\|re\\(?:gister\\|strict\\|turn\\)\\|s\\(?:hort\\|i\\(?:gned\\|zeof\\)\\|t\\(?:atic\\|ruct\\)\\|witch\\)\\|t\\(?:ype\\(?:\\(?:de\\|o\\)f\\)\\)\\|un\\(?:ion\\|signed\\)\\|vo\\(?:id\\|latile\\)\\|while\\)\\)\\_>" 1 'font-lock-keyword-face append)
       ("\\_<\\(true\\|false\\)\\_>" 1 'font-lock-constant-face)
       ("\\<\\(\\sw+\\) ?(" 1 'font-lock-function-name-face)
       ("\\b\\([0-9]*\\.[0-9]+f\\{0,1\\}\\)\\b" 1 'font-lock-constant-face)
       ("\\b\\(\\(0\\|[1-9][0-9]*\\)[uUlL]*\\)\\b" 1 'font-lock-constant-face)x
       ("\\([|!.+=&/%*:^~<>-]+\\)" 1 'font-lock-builtin-face)
       ("\\([][,(){};]+\\)" 1 'font-lock-delim-face) ))
  (setq face-remapping-alist '((font-lock-function-name-face . default))) )

(defun my/c-initialization-hook ()
  (define-key c-mode-base-map (kbd "RET") 'c-context-line-break))
(add-hook 'c-initialization-hook 'my/c-initialization-hook)

(defun my/c-mode-hook ()
  (face-remap-add-relative font-lock-variable-name-face '(custom-face-get-current-spec 'default)) ;; Remove highlighting of variable names
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'brace-list-intro '+)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0))

(add-hook 'c-mode-hook 'my/c-mode-hook)

;; text-mode
(defun my/text-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq indent-line-function 'insert-tab) )

(add-hook 'text-mode-hook 'my/text-mode-hook)

;; SSH Mode
(require 'ssh)
(add-hook 'ssh-mode-hook
          (lambda ()
            (setq ssh-directory-tracking-mode 'ftp)
            (shell-dirtrack-mode t)
            (setq dirtrackp nil)))

;; Org-Mode
;; (require 'org-install)
;; (require 'org)

;; (defun my/org-mode-hook ()
;;   (org-bullets-mode t))

;; (add-hook 'org-mode-hook 'my/org-mode-hook)

;; (setq org-hide-leading-stars t
;;       org-ellipsis "..."
;;       org-src-fontify-natively t
;;       org-src-tab-acts-natively t
;;       org-directory "~/.org")

;; (defun org-file-path (filename)
;;   "Return the absolute address of an org file, given its relative name."
;;   (concat (file-name-as-directory org-directory) filename))

;; (setq org-index-file (org-file-path "index.org")
;;       org-archive-location (concat (org-file-path "archive.org") "::* From %s")
;;       org-agenda-files (list org-index-file))

;; (defun my/mark-done-and-archive ()
;;   "Mark the state of an org-mode item as DONE and archive it."
;;   (interactive)
;;   (org-todo 'done)
;;   (org-archive-subtree))

;; (define-key org-mode-map (kbd "C-c C-x C-s") 'my/mark-done-and-archive)
    
;; (setq org-log-done 'time)
;; (setq org-capture-templates
;;       '(("r" "Finished book"
;;          table-line (file "~/.org/notes/books-read.org")
;;          "| %^{Title} | %^{Author} | %u |")
;;         ("b" "Books to Read"
;;          table-line (file "~/.org/notes/books-to-read.org")
;;          "| %^{Title} | %^{Author} | %u |")
;;         ("t" "Todo"
;;          entry
;;          (file+headline org-index-file "Inbox")
;;          "* TODO %?\n")))
;; (setq org-refile-use-outline-path t
;;       org-outline-path-complete-in-steps nil)

;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cc" 'org-capture)

;; (defun my/open-index-file ()
;;   "Open the master org TODO list."
;;   (interactive)
;;   (find-file org-index-file)
;;   (flycheck-mode -1)
;;   (end-of-buffer))

;; (global-set-key (kbd "C-c i") 'my/open-index-file)

;; (defun org-capture-todo ()
;;   (interactive)
;;   (org-capture :keys "t"))

;; (global-set-key (kbd "M-n") 'org-capture-todo)
;; (add-hook 'haskell-mode-hook
;;           (lambda () (local-set-key (kbd "M-n") 'org-capture-todo)))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((emacs-lisp . t)
;;    (haskell . t)
;;    (C . t)
;;    (python . t)))

;; (setq org-confirm-babel-evaluate nil)
;; (setq org-export-with-smart-quotes t)

;; GLSL mode
(load "~/.emacs.d/manual/glsl-mode")
(add-to-list 'auto-mode-alist '("\\.\\(vs\\|fs\\|gs\\|glsl\\|vert\\|frag\\|geom\\)$" . glsl-mode))
(font-lock-add-keywords
 'glsl-mode
 '(
   ("@\\(version\\|interface\\|vertex\\|geometry\\|fragment\\)" 1 'font-lock-builtin-face) ))

;; odin-mode
(load "~/.emacs.d/manual/odin-mode")
(defvar default-tab-width 4)
;; Mail

;; (autoload 'wl "wl" "Wanderlust" t)
;; ;; IMAP, gmail:
;; (setq
;;  wl-stay-folder-window t
;;  wl-folder-window-width 25

;;  wl-smtp-connection-type 'starttls
;;  wl-smtp-posting-port 587
;;  wl-smtp-authenticate-type "plain"
;;  wl-smtp-posting-user "tyler"
;;  wl-smtp-posting-server "smtp.gmail.com"
;;  wl-local-domain "gmail.com"

;;  wl-from "Me <me@tylererickson.com>"

;;  wl-fcc ".sent"
;;  wl-fcc-force-as-read t
;;  wl-default-folder "%inbox"
;;  wl-default-spec "%"
;;  wl-draft-folder ".drafts"
;;  wl-trash-folder ".trash"
;;  wl-spam-folder ".trash"
;;  wl-queue-folder ".queue"

;;  wl-folder-check-async t
 
;;  ;; hide many fields from message buffers
;;  wl-message-ignored-field-list '("^.*:")
;;  wl-message-visible-field-list
;;  '("^\\(To\\|Cc\\):"
;;    "^Subject:"
;;    "^\\(From\\|Reply-To\\):"
;;    "^Organization:"
;;    "^Message-Id:"
;;    "^\\(Posted\\|Date\\):"
;;    )
;;  wl-message-sort-field-list
;;  '("^From"
;;    "^Organization:"
;;    "^X-Attribution:"
;;    "^Subject"
;;    "^Date"
;;    "^To"
;;    "^Cc")

;;  elmo-imap4-default-server "imap.gmail.com"
;;  elmo-imap4-default-user "tcerickson98@gmail.com"
;;  elmo-imap4-default-authenticate-type 'clear
;;  elmo-imap4-default-port '993
;;  elmo-imap4-default-stream-type 'ssl

;;  ;; For non ascii-characters in folder-names
;;  elmo-imap4-use-modified-utf7 t )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
