
;;
;; Setup puppet-mode for autoloading
;;
;;(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
;;(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

; disable color crap
(setq-default global-font-lock-mode nil)

(setq default-fill-column 72)
(setq default-major-mode 'paragraph-indent-text-mode)
;(setq-default ispell-program-name "/usr/local/ispell-3.3.02/bin/ispell")
;(setq default-major-mode 'fundamental-mode)
;(setq default-major-mode 'fundamental-mode)
(setq fundamental-mode-hook
        (setq auto-fill-mode 1)
       )
(setq text-mode-hook
     '(lambda () 
        (auto-fill-mode 1)
       ))
(setq tex-mode-hook
     '(lambda () 
        (auto-fill-mode 1)
        (read-abbrev-file "/usr/users/drjohn/emacs/mytex-mode.el")
     ))
(setq lisp-mode-hook
     '(lambda () (auto-fill-mode 1)))
(setq emacs-lisp-mode-hook
     '(lambda () (auto-fill-mode 1)))


(defun indent-relative (&optional unindented-ok)
  "Space out to under next indent point in previous nonblank line.
An indent point is a non-whitespace character following whitespace.
If the previous nonblank line has no indent points beyond the
column point starts at, `tab-to-tab-stop' is done instead."
  (interactive "P")
  (tab-to-tab-stop))



;
;  html-helper-mode
; 
(setq load-path (cons "/usr/users/drjohn/.elisp" load-path))
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode)
			    auto-mode-alist))
(setq html-helper-do-write-file-hooks t)

;
;  Set the load path
;
;(setq load-path (cons "/usr/users/drjohn/.elisp" load-path))
;(setq lpr-command "/bin/lpr")

;
; Force the loading of my own text-mode.el file
;
;(load "~/.elisp/text-mode.el")
;(load "~/.elisp/abbrev.el")
;(load "~/.elisp/tabify.el")
;(load "~/.elisp/indent.el")
;(load "~/.elisp/fill.el")

;
;  Load the SMGL editting stuff
;
(autoload 'smgl-mode "psgml" "Major mode to edit SGML files." t )

;
;  Make sure we don't do a slow terminal search, yuk!!!
;
(setq search-slow-speed 0)

;
;  define some useful macros
;
;  splits to two windows and moves to other window
; 
(global-set-key "\M-g" 'goto-line)
(fset 'two-window "2o")
(global-set-key "\M-2" 'two-window )
(fset 'one-window   "1")
(global-set-key "\M-1" 'one-window )

;; disable color crap
(setq-default global-font-lock-mode nil)


;
;   append to auto-mode-alist so that cmz starts in fortran mode
;
(setq-default abbrev-mode 1)
(setq auto-mode-alist
    (append 
     '(( "cmedt.edt" . fortran-mode ))
     '(( "\\.inc$" . fortran-mode ))
     '(( "\\.car$" . fortran-mode ))
     auto-mode-alist))
;
;    some mods to fortran-mode
;
(setq fortran-do-indent 3)
(setq fortran-if-indent 3)
;(setq fortran-comment-indent-style nil)
;(setq fortran-continuation-char 38)
(setq fortran-comment-region "C$$$")

(setq fortran-mode-hook 
      '(lambda ()
        (read-abbrev-file "/usr/users/drjohn/emacs/myfort-abbrev.el")
        (auto-fill-mode 1 )
        (setq comment-line-start "C")
	))
;        (setq comment-line-start-skip
;              "^[Cc*]\\(\\([^ \t\n]\\)\\2\\2*\\)?[ \t]*\\|^+.*")
;	))
;



;(defconst search-repeat-char ?\C-f "\
;*Character to repeat incremental search forwards.")
;(define-key global-map "\C-f" 'isearch-forward)
;(define-key esc-map "\C-f" 'isearch-forward-regexp)



(global-set-key "[1~"  'isearch-forward)                ; find
(global-set-key "[2~"   'yank)                          ; insert
(global-set-key "[3~"   'kill-region)                   ; remove
(global-set-key "[4~"   'yank)                          ; yank
(global-set-key "[5~"   'scroll-down)                   ; page-down
(global-set-key "[6~"   'scroll-up)                     ; page-up
(global-set-key "[11~"  'one-window)                    ; F1
(global-set-key "[12~"  'two-window)                    ; F2
(global-set-key "[13~"  'find-file)                     ; F3
(global-set-key "[14~"  'switch-to-buffer)              ; F4
(global-set-key "[15~"  'save-buffers-kill-emacs)       ; F5
(global-set-key "[16~"  'scroll-up)                     ; F6
(global-set-key "[16~"  'exchange-point-and-mark)       ; F7
(global-set-key "[17~"  'exchange-point-and-mark)       ; F8
(global-set-key "[18~"  'exchange-point-and-mark)       ; F9
(global-set-key "[19~"  'exchange-point-and-mark)       ; F10
(global-set-key "[28~"  'help-for-help)                 ; help
(global-set-key "[29~"  'execute-extended-command)      ; Do

(global-set-key "Op" "0")  ; number keys
(global-set-key "Oq" "1")
(global-set-key "Or" "2")
(global-set-key "Os" "3")
(global-set-key "Ot" "4")
(global-set-key "Ou" "5")
(global-set-key "Ov" "6")
(global-set-key "Ow" "7")
(global-set-key "Ox" "8")
(global-set-key "Oy" "9")

;;;
;;;  Perl
;;;
(setq auto-mode-alist (append (list (cons "\\.pl$" 'perl-mode))
                               auto-mode-alist))
(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)


;;(setq load-path (cons "/usr/lib/xemacs-21.1-p3/lisp" load-path))
;;(cond ((file-exists-p "/usr/lib/xemacs-21.1-p3/lisp/ispell.elc") 
;;       (load "/usr/lib/xemacs-21.1-p3/lisp/ispell.elc"))
;;)



;;; Commands added by calc-private-autoloads on Mon Nov 22 14:41:38 1993.
(autoload 'calc-dispatch	   "calc" "Calculator Options" t)
(autoload 'full-calc		   "calc" "Full-screen Calculator" t)
(autoload 'full-calc-keypad	   "calc" "Full-screen X Calculator" t)
(autoload 'calc-eval		   "calc" "Use Calculator from Lisp")
(autoload 'defmath		   "calc" nil t t)
(autoload 'calc			   "calc" "Calculator Mode" t)
(autoload 'quick-calc		   "calc" "Quick Calculator" t)
(autoload 'calc-keypad		   "calc" "X windows Calculator" t)
(autoload 'calc-embedded	   "calc" "Use Calc inside any buffer" t)
(autoload 'calc-embedded-activate  "calc" "Activate =>'s in buffer" t)
(autoload 'calc-grab-region	   "calc" "Grab region of Calc data" t)
(autoload 'calc-grab-rectangle	   "calc" "Grab rectangle of data" t)
(autoload 'edit-kbd-macro	   "macedit" "Edit Keyboard Macro" t)
(autoload 'edit-last-kbd-macro	   "macedit" "Edit Keyboard Macro" t)
(autoload 'read-kbd-macro	   "macedit" "Read Keyboard Macro" t)
(global-set-key "\e#" 'calc-dispatch)
;;; End of Calc autoloads.


;; Options Menu Settings
;; =====================
;;(cond
;; ((and (string-match "XEmacs" emacs-version)
;;       (boundp 'emacs-major-version)
;;       (or (and
;;            (= emacs-major-version 19)
;;            (>= emacs-minor-version 14))
;;           (= emacs-major-version 20))
;;       (fboundp 'load-options-file))
;;  (load-options-file "~/.xemacs-options")))
;; ============================
;; End of Options Menu Settings


;;(custom-set-variables
;;;; '(pc-select-selection-keys-only t)
;; '(gnuserv-program (concat exec-directory "/gnuserv"))
;; '(pc-select-meta-moves-sexps t)
;; '(user-mail-address "" t)
;; '(query-user-mail-address nil)
;; '(pc-selection-mode t nil (pc-select)))
;;(custom-set-faces)

(put 'downcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "ASCII")
 '(global-font-lock-mode t nil (font-lock))
 '(load-home-init-file t t))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

(put 'upcase-region 'disabled nil)




;; transient-mark-modes sets up to allow commenting out marked lines by
;; typing alt-;  This works as a toggle.
(setq tex-mode-hook
     '(lambda () 
        (auto-fill-mode 1)
        (transient-mark-mode 1)
;;        (read-abbrev-file "/usr/users/wtford/emacs/mytex-mode.el")
     ))
;;                                              ^- Note directory and file

;; This one doesn't work for some reason:
(setq shell-script-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))
(setq sh-mode-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))

(setq python-mode-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))
(setq cperl-mode-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))
(setq perl-mode-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))


(setq emacs-lisp-mode-hook
     '(lambda () 
        (transient-mark-mode 1)
     ))

(setq lisp-mode-hook
     '(lambda () (auto-fill-mode 1)))
(setq emacs-lisp-mode-hook
     '(lambda () (auto-fill-mode 1)))


;; 
;;-----------------------------------------------------------------------
