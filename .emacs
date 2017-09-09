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

; Use SSH for tramp-mode
(setq tramp-default-method "ssh")

;; e-mail
(setq user-mail-address "henrik@brixandersen.dk")

;; do not show the startup message
(setq inhibit-startup-message t)

;; iswitchb-mode is a must
(icomplete-mode 99)

;; automaticall de/compress files
(auto-compression-mode t)

;; turn off blinking cursor
(blink-cursor-mode 0)

;; blink frame instead of bell
(setq visible-bell t)

;; no bell
;(setq ring-bell-function (lambda ()))

;; indent should not insert tabs
(setq-default indent-tabs-mode nil)
;(setq-default tab-width 4)

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

;; automatically follow symlinks to version-controlled files
(setq vc-follow-symlinks t)

;; key binding for going to a specific line
(global-set-key [(meta g)] 'goto-line)

;; Automatically mark buffers with clients as done on C-x k
(global-set-key (kbd "C-x k")
                '(lambda ()
                   (interactive)
                   (if server-buffer-clients
                       (server-done)
                     (kill-this-buffer))))

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
(setq cperl-invalid-face nil)

;; Linux kernel C-mode hook
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))
(defun linux-c-mode-hook ()
  (setq indent-tabs-mode t)
  (setq show-trailing-whitespace t)
  (c-set-style "linux-tabs-only"))
(add-hook 'c-mode-hook 'linux-c-mode-hook)

(autoload 'ucf-mode "ucf-mode" "Xilinx UCF mode" t)
(add-to-list 'auto-mode-alist '("\\.ucf\\'" . ucf-mode))

(add-hook 'vhdl-mode-hook
          (lambda ()
            (if (and (stringp buffer-file-name)
                     (string-match "tb_.*\\.vhd\\'" buffer-file-name))
                (setq vhdl-standard (quote (8 nil)))
                (setq vhdl-standard (quote (93 nil))))
            (setq vhdl-clock-edge-condition (quote function)
                  vhdl-clock-name "clk"
                  vhdl-conditions-in-parenthesis t
                  vhdl-electric-mode t
                  vhdl-reset-active-high t
                  vhdl-reset-kind (quote sync)
                  vhdl-reset-name "reset"
                  vhdl-self-insert-comments nil
                  vhdl-insert-empty-lines (quote none)
                  vhdl-stutter-mode t
                  vhdl-upper-case-keywords t
                  vhdl-use-direct-instantiation (quote always)
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
USE ieee.std_logic_1164.ALL;

<cursor>")))



;; use crontab-mode for crontab.* files
(add-to-list 'auto-mode-alist '("crontab\\.*" . crontab-mode))

;; use makefile-mode for *.mak files
(add-to-list 'auto-mode-alist '("\\.mak" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.d" . makefile-mode))
(add-to-list 'auto-mode-alist '("Kbuild" . makefile-mode))

;; use xml-mode for *.xsd files
(add-to-list 'auto-mode-alist '("\\.xsd" . xml-mode))

;; custom snmpv2-mode font lock keywords

;; use snmpv2-mode for *-MIB.txt files
(add-to-list 'auto-mode-alist '("-MIB\\.txt" . snmpv2-mode))
(font-lock-add-keywords 'snmpv2-mode
                        '(
                          ("CONTACT-INFO" . font-lock-keyword-face)
                          ("GROUP" . font-lock-keyword-face)
                          ("MANDATORY-GROUPS)" . font-lock-keyword-face)
                          ("LAST-UPDATED" . font-lock-keyword-face)
                          ("M\\(AX-ACCESS\\|ODULE-COMPLIANCE\\)" . font-lock-keyword-face)
                          ("MODULE-IDENTITY" . font-lock-keyword-face)
                          ("MODULE" . font-lock-keyword-face)
                          ("O\\(BJECTS\\|RGANIZATION\\)" . font-lock-keyword-face)
                          ("OBJECT-GROUP" . font-lock-keyword-face)
                          ("REVISION" . font-lock-keyword-face)
                          )
                        )
(add-hook 'snmpv2-mode-hook
          (lambda ()
            (setq snmp-font-lock-keywords snmp-font-lock-keywords-3)))

;; use xml-mode for anything with an xml header
(setq magic-mode-alist
      (cons '("<\\?xml " . xml-mode)
	    magic-mode-alist))

;; set up X specific stuff
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
     ;(set-face-foreground 'mode-line "Black")
     ;(set-face-background 'mode-line "#eaeaea")

     ;; tool-bar
     ;(set-face-foreground 'tool-bar "Wheat")
     ;(set-face-background 'tool-bar "DarkSlateGray")

     ;; custom buttons
     ;(require 'cus-edit)
     ;(set-face-foreground 'custom-button-face "Wheat")
     ;(set-face-background 'custom-button-face "DarkSlateGray")
     ;(set-face-foreground 'custom-button-pressed-face "Wheat")
     ;(set-face-background 'custom-button-pressed-face "DarkSlateGray")

     ;; scroll-bar
     ;(set-face-foreground 'scroll-bar "#cdcdb2")
     ;(set-face-background 'scroll-bar "#dedfce")

     ;; menu
     ;(set-face-foreground 'menu "Wheat")
     ;(set-face-background 'menu "DarkSlateGray")
     ;(set-face-font 'menu "fixed")

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
