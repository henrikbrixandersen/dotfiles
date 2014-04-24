;; set the load path
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp/") load-path))

;; scad
(require 'scad nil t)

;; Graphviz dot mode
(require 'graphviz-dot-mode nil t)
(add-to-list 'auto-mode-alist '("\\.uml\\'" . graphviz-dot-mode))
(setq graphviz-dot-preview-extension "svg")
(setq graphviz-dot-view-command "open %s")
(setq graphviz-dot-auto-indent-on-braces nil)
(setq graphviz-dot-auto-indent-on-semi nil)
(setq graphviz-dot-auto-indent-on-newline nil)

;; tramp
;(require 'tramp)
;(setq tramp-default-method "scpx")

;; e-mail
(setq user-mail-address "henrik@brixandersen.dk")

;; do not show the startup message
(setq inhibit-startup-message t)

;; iswitchb-mode is a must
(iswitchb-mode t)

;; automaticall de/compress files
(auto-compression-mode t)

;; turn off blinking cursor
(blink-cursor-mode 0)

;; blink frame instead of bell
(setq visible-bell t)

;; no bell
;(setq ring-bell-function (lambda ()))

;; use aspell, not ispell
(setq ispell-program-name "aspell")

;; use the danish dictionary as default
(setq ispell-dictionary "dansk")

;; indent should insert tabs
(setq indent-tabs-mode nil)
;(setq tab-width 4)

;; turn on font-lock
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;; show matching paren
(show-paren-mode t)

;; highlight the active region
(transient-mark-mode t)

;; highlight searches
(setq search-highlight t)

;; highlight query/replace
(setq query-replace-highlight t)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; show column number
(setq column-number-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, don't just add lines
(setq next-line-add-newlines nil)

;; key binding for going to a specific line
(global-set-key [(meta g)] 'goto-line)

;; load auctex
(if (load "auctex.el" t nil t)
    (progn
      (setq TeX-auto-save t)
      (setq TeX-parse-self t)

      (add-hook 'TeX-mode-hook
		(lambda ()
		  ;; spellcheck on-the-fly
		  (flyspell-mode t)
		  ;; let ispell handle TeX
		  (setq ispell-parser 'tex)
		  ;; use reftex
		  (turn-on-reftex)
		  (setq reftex-use-multiple-selection-buffers t)
		  (setq reftex-enable-partial-scans t)
		  ;; use varioref as default
		  (setq reftex-vref-is-default t)
		  (setq reftex-plug-into-AUCTeX t)))

      (add-hook 'LaTeX-mode-hook
		(lambda ()
		  ;; default to PDF mode
		  (TeX-PDF-mode)
		  ;; add Mac OS X open(1) to our list of commands (which will launch Preview.app)
		  (add-to-list 'TeX-command-list '("Preview" "open %s.pdf" TeX-run-silent nil nil))
		  ;; default to use acroread for viewing
		  (setq-default TeX-command-Show "Preview")
		  ;; shortcut for our tempo template
		  (define-key LaTeX-mode-map [(control c) (control t)] 'tempo-template-latex)))
      ))

(add-hook 'c-mode-hook
	  (lambda ()
	      (c-set-style "bsd")
	      (setq indent-tabs-mode nil)
	      ;; Use C-c C-s at points of source code so see which
	      ;; c-set-offset is in effect for this situation
	      (c-set-offset 'defun-block-intro 4)
	      (c-set-offset 'statement-block-intro 4)
	      (c-set-offset 'statement-case-intro 4)
	      (c-set-offset 'substatement-open 2)
	      (c-set-offset 'substatement 4)
	      (c-set-offset 'arglist-cont-nonempty 4)
	      (c-set-offset 'inclass 4)
	      (c-set-offset 'knr-argdecl-intro 4)))

(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
	  (lambda ()
	    (setq cperl-indent-level 4
		  cperl-close-paren-offset -4
		  cperl-continued-statement-offset 4
		  cperl-indent-parens-as-block t
		  cperl-tab-always-indent t
		  cperl-invalid-face nil)))
(custom-set-faces '(cperl-array-face ((t (:foreground "green" :weight bold))))
		  '(cperl-hash-face ((t (:foreground "red" :weight bold)))))

(add-hook 'vhdl-mode-hook
	  (lambda ()
	    (setq vhdl-actual-port-name (quote (".*" . "\\&_i"))
		  vhdl-clock-edge-condition (quote function)
		  vhdl-clock-name "clk"
		  vhdl-compiler-options "-93"
		  vhdl-conditions-in-parenthesis t
		  vhdl-electric-mode t
		  vhdl-entity-file-name (quote (".*" . "\\&_entity"))
		  vhdl-reset-active-high t
		  vhdl-reset-name "reset"
		  vhdl-self-insert-comments nil
		  vhdl-standard (quote (93 nil))
		  vhdl-upper-case-keywords t
		  vhdl-file-header "-- Copyright (c) <year> <author>
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in the
--    documentation and/or other materials provided with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
-- FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-- DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
-- OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
-- LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
-- OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
-- SUCH DAMAGE.
--

LIBRARY ieee;
use IEEE.std_logic_1164.all;

<cursor>")))

;(add-hook 'perl-mode-hook
;	  (lambda ()
;	    (setq indent-tabs-mode nil)
;	    (setq tab-width 4)
;	    (setq perl-indent-level 4)))

(add-hook 'sgml-mode-hook
	  (lambda ()
            (make-local-variable 'indent-tabs-mode)
	    (setq indent-tabs-mode 't)
	    (setq tab-width 2)
	    (setq sgml-basic-offset 2)))

;; use plain text mode for .css files
(add-to-list 'auto-mode-alist '("\\.css\\'" . text-mode))

;; use crontab-mode for crontab.* files
(add-to-list 'auto-mode-alist '("crontab\\.*" . crontab-mode))

;; use c++-mode for *.js files
(add-to-list 'auto-mode-alist '("\\.js\\'" . c++-mode))

;; use mail-mode for mutt-* files
(add-to-list 'auto-mode-alist '("mutt-*" . mail-mode))

;; use sieve-mode for *.sieve files
(add-to-list 'auto-mode-alist '("\\.sieve\\'" . sieve-mode))

;; use xml-mode for all XML files
(setq magic-mode-alist
      (cons '("<\\?xml " . xml-mode)
	    magic-mode-alist))

;; set up X11 specific stuff
(if (string-equal window-system "x")
    (progn
      ;; Make dead keys work
      (require 'iso-transl)

      ;; set the title
      (setq frame-title-format
	    (concat  "%f " invocation-name "@" system-name))

     ;; turn off the tool-bar
     (tool-bar-mode 0)

     ;; start editing server
     (server-start)

     ;; load wheel mouse support
     (mouse-wheel-mode t)

     ;; make the mouse cursor and the point play cat-and-mouse
     (mouse-avoidance-mode 'cat-and-mouse)

     ;; mode-line
     (set-face-foreground 'mode-line "Black")
     (set-face-background 'mode-line "#eaeaea")

     ;; scroll-bar
     (set-face-foreground 'scroll-bar "#cdcdb2")
     (set-face-background 'scroll-bar "#dedfce")

     ;; mouse and cursor
     (set-face-background 'mouse "Orchid")
     (set-face-background 'cursor "Orchid")

     ;; trailing-whitespace
     (set-face-background 'trailing-whitespace "Red")

     ;; default
     (set-face-foreground 'default "White")
     (set-face-background 'default "gray33")
     ;(set-face-font 'default "-*-courier-medium-r-normal-*-12-*-*-*-*-*-*-*")
     )
)
