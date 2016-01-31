;; 2012/09/11 -- DAISUKE INOUE --
(setq debug-on-error t)					;��蔭������*BACKTRACE*���J��

;; IME�ɂ���
;; Windows Xp���g�p�̏ꍇ�@���@MS-IME�Ŗ��Ȃ��g�p�\�ł��B
;; Windows 7���g�p�̏ꍇ�@���@GoogleIME���g�p���Ă��������B
;; ��MS-IME���g�p����ƃC�����C�����͂��ł��Ȃ��Ȃ�B
;;  ++++++++++++++++++++++++++++ LOAD-PATH +++++++++++++++++++++++++++
;; ;; load-path ��ǉ�����֐����`
;; ;; "user-emacs-directory" is defined since  versoin 23.
;; (defun add-to-load-path (&rest paths)
;;   (let (path)
;; 	(dolist (path paths paths)
;; 	  (let ((default-derectory
;; 			   (expand-file-name (concat user-emacs-directory path))))
;; 		(add-to-list 'load-path default-directory )
;; 		(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;; 			(normal-top-level-add-subdirs-to-load-path))))))
;; 
;; ;; �����̃f�B���N�g���Ƃ��̃T�u�f�B���N�g����load-path�ɒǉ�
;; (add-to-load-path "elisp" "conf" "public_repos")

;; ��L�̎������́A%HOME%����N�������ꍇ�̂ݗL���B
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/conf")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/etc")
(add-to-list 'load-path "~/.emacs.d/public_repos")

(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0/themes")
(add-to-list 'load-path "~/.emacs.d/elisp/packages")

;; ++++++++++++++++++++++ PACKAGES +++++++++++++++++++++
;; package.el �̐ݒ�
(when (require 'package nil t)
  ;; �p�b�P�[�W���|�W�g����Marmalade�ƊJ���҉^�c��ELPA��ǉ�
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
			   '("ELPA" . "http://tromey.com/elpa/"))
  ;; �C���X�g�[�������p�b�P�[�W�Ƀ��[�h�p�X��ʂ��ēǂݍ���
  (package-initialize)
)

;; ���[�U�p�������t�@�C��
;(if (file-exists-p (expand-file-name "~/.emacs.my.el"))
;    (load (expand-file-name "~/.emacs.my.el") nil t nil))

;;  ++++++++++++++++++++++++ ENVIRONMENT +++++++++++++++++++++++++
;; Set Environment

;(setenv "PATH" "C:\\cybwin\\bin") 		;PATH���㏑������
;(setenv "PATH" (format "C:\\cybwin\\bin;%s" (getenv "PATH"))) ;PATH�ɒǉ�����
;(add-to-list 'exec-path "c:/cygwin/bin")
;(add-to-list 'exec-path "c:/cygwin/bin/Global")
;(add-to-list 'exec-path "~/.emacs.d/bin")

;; Here are refence from "http://stackoverflow.com".
;; ���̐ݒ肾��WindowsXP�ł�OK�B������Windows7����NG
;;windows only stuff
;; (when (string-equal system-type "windows-nt")
;;   (progn
;; 	(setq cygwin-bin "c:\\cygwin\\bin")
;; 	(setq gnu-bin "C:\\apps\\GnuWin32\\gnuwin32\\bin")
;; 	(setenv "PATH"
;; 			(concat cygwin-bin ";" gnu-bin ";"))
;; 	(setq exec-path
;; 		  '(cygwin-bin gnu-bin)))) 

;; �����R�[�h���w�肷��
(set-language-environment 'Japanese)
;(prefer-coding-system 'shift_jis)		;S-JIS��ݒ�
(prefer-coding-system 'utf-8)

;; PATH�̐ݒ���s���܂��B
;; WindowsXp , Windows7�����œ���m�F�ς�
;; cygwin-bin �ɐݒ肵�Ă���p�X��grep����exe�t�@�C�����i�[���邱��
(when (string-equal system-type "windows-nt")
  (progn
	(setq cygwin-bin "c:/cygwin/bin")
	(setq gnu-global (concat (getenv "HOME") "/GnuGlobal/bin"))				;GnuGlobal�ւ�PATH
	(setq home-bin (concat (getenv "HOME") "/bin")) ; ~/bin
	(setq home-bat (concat (getenv "HOME") "/bat")) ; ~/bat
	(setq local-paths (getenv "PATH"))		;���݂̊�PATH���擾����

	;; ��PATH�̐ݒ�:SHELL������s����ۂ�global.exe�Ȃǂ�CALL�ł���悤�ɂ���
;	(setenv "PATH"
;			(concat cygwin-bin ";" gnu-global ";" local-paths)) ;EMACS��PATH�ݒ�{���݂̊�PATH
	(setenv "PATH"
			(concat cygwin-bin ";" gnu-global ";" home-bin ";" home-bat ";" local-paths)) ;EMACS��PATH�ݒ�{���݂̊�PATH

	;; exec-path�̐ݒ�Femacs��������grep.exe,global.exe��CALL����ꍇ�ɕK�v
	(add-to-list 'exec-path home-bat)	;~/bat
	(add-to-list 'exec-path home-bin)	;~/bin
	(add-to-list 'exec-path cygwin-bin)	; cygwin��exe
	(add-to-list 'exec-path gnu-global)	; gtags
    (setq locale-coding-system 'cp932)
    (set-file-name-coding-system 'cp932)
))

;; �N�����̉�ʂ��\���ɂ���
(setq inhibit-startup-message t)

;; �o�b�N�A�b�v�t�@�C�������Ȃ�
;;(setq backup-inhibited t)
(setq make-backup-files nil) ; �����l=t
;; �I�[�g�Z�[�u�t�@�C���͍��
(setq auto-save-default t) ; �����l=t

;; �o�b�N�A�b�v�t�@�C���̍쐬�ꏊ���V�X�e����temp�f�B���N�g���ɕύX����
;(setq backup-directory-alist
;	  `((".*" . ,temporary-file-directory)))

;; �I�[�g�Z�[�u�t�@�C���̍쐬�ꏊ���V�X�e����temp�f�B���N�g���ɕύX����
;(setq auto-save-file-name-transforms
;	  `((".*" ,temporary-file-directory t)))

; temporary-file-directory : �V�X�e����TEMP

;; +++++++++++++++++++++++ KEY BINDING +++++++++++++++++++++++++
;; [f1] :HELP
;; [f2] :find-file   :C-x C-f
;; [f3] :buffer-menu :C-x C-b
;; [f4]
;; [f5]
;; [f6]
;; [f7] :fold-dwim-toggle   : cc-mode :�u���b�N�܂��݋@�\
;; [f8] :fold-dwim-show-all : cc-mode :�u���b�N�܂��݋@�\
;; [f9] :fold-dwim-hide-all : cc-mode :�u���b�N�܂��݋@�\

(global-set-key [f2] 'find-file)		 ; C-x C-f
(global-set-key [f3] 'buffer-menu)		 ; open buffer windwow

(global-set-key [M-left] 'shrink-window-horizontally)
(global-set-key [M-right] 'enlarge-window-horizontally)

(global-set-key [M-up] 'shrink-window)
(global-set-key [M-down] 'enlarge-window)

(global-set-key [C-tab] 'other-window)  ; ohter-window
;(global-set-key [C-tab] 'winring-jump-to-configuration)

;; [C-t]�Ńo�b�t�@��؂�ւ���B�����l��"transpose-chars"
;;(global-set-key [C-t] 'other-window)

;; C-c ����n�܂�R�}���h�͊g���@�\�̎w�j�Ƃ��ă��[�U�̂��߂�
;; �󂯂Ă����Ƃ������[��������܂��B���̂���,C-c Xxx �ɓo�^����̂��ǂ��B

;;lgrep�ݒ�
;(setq grep-command "lgrep -n -Oe")
;(setq grep-program "lgrep")

;;  ++++++++++++++++++++ DISPLAY INFORMATION on TITLE BAR ++++++
;; �^�C�g���o�[�Ƀt�@�C������\��
(setq frame-title-format "%f")

;; ���j���[�o�[���\���ɂ���
;(menu-bar-mode -1)

;; �c�[���o�[���\���ɂ���
(tool-bar-mode 0)

;; +++++++++++++ DISPLAY INFORMATION on MODE LINE. +++++++++++++
;; ������24���Ԑ��Ń��[�h���C���ɕ\��
(setq display-time-24hr-format t)
(display-time)

;; Display column number.
(column-number-mode t) 

;; Display file-size
(size-indication-mode t)

;; ++++++++++++ DISPLAY INFORMATION on BUFFER ++++++++++++++
;; Display line-number
(global-linum-mode t)

;;Tab�̕����S(setq-default�ɂ��Ȃ��Ƃ��ׂẴo�b�t�@�ɓK�p�ł��Ȃ��j
(setq-default tab-width 4)

;; �����s�ł��܂�Ԃ��Ȃ�
(setq-default truncate-lines t)

;; �S�p�󔒂Ɖ��s������\������
;; install-elisp RET http://homepage3.nifty.com/satomii/software/jaspace.el
(when (require 'jaspace nil t)
  (setq jaspace-alternate-jaspac-string "��") ;�S�p�󔒂����̎��ŕ\��
  (if window-system
	  (setq jaspace-alternate-eol-string "��\n")) ;���s����
  (setq jaspace-highlight-tabs t)
)
;;  ------------------------------------------------------------
;; �F�ύX
(when (require 'color-theme nil t)
  ;; �e�[�}��ǂݍ��ނ��߂̐ݒ�
  (color-theme-initialize)
  ;; �e�[�}��gnome2�ɕύX����
  (color-theme-gnome2)
)

;; auto-install
(when (require 'auto-install nil t)
  ;; �C���X�g�[���f�B���N�g����ݒ肷��B�����l��, ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWiki�ɓo�^����Ă���elisp�̖��O���擾����
  (auto-install-update-emacswiki-package-name t)
  ;; install-elisp�𗘗p�\�ɂ���
  (auto-install-compatibility-setup)	;�݊����m��
)

;; Redo
(when (require 'redo+ nil t)
  ;; C-.��redo�����蓖�Ă�
  (global-set-key (kbd "C-.") 'redo)
)

;; color-moccur
;(auto-install-from-emacswiki) RET (color-moccur.el) RET
(when (require 'color-moccur nil t)
  ;; M-o��occur-by-moccur�����蓖�Ă�
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; �X�y�[�X��؂�ł`�m�c����
  (setq moccur-split-word t)
  ;; �f�B���N�g�������̂Ƃ����O����t�@�C��
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$") ;#init.el#�͏��O����
  ;; Migemo�𗘗p�ł�����ł����Migemo���g��
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(setq moccur-use-migemo t))
)
;; end of setting color-moccur

;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq 
   ;; ����\������܂ł̎���. default = 0.5
   anything-idle-delay 0.3
   ;; �^�C�v���čĕ`�ʂ���܂ł̎���. default = 0.1
   anything-input-idle-delay 0.2
   ;; ���̍ő�\����. default = 50
   anything-candidate-number-limit 100
   ;; ��₪�����Ƃ��ɑ̊����x�𑁂�����
   anything-quick-update t
   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
	;; root�����ŃA�N�V���������s����Ƃ��̃R�}���h
	;; default = "su"
	(setq anything-su-or-sudo "sudo"))

  ;; Pattern matching���g������
  (require 'anything-match-plugin nil t)
  
  ;; ���{����̏ꍇ�͕K�v
  ;; http://0xcc.net/migemo/
  (when (and (equal current-language-environment "Japanese") ;���{���
			 (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
	;; lisp�V���{���̕⊮���̍Č�������
	(anything-lisp-complete-symbol-set-timer 150))

  ;; shows current selection prettily.
  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))

  ;; 
  (when (require 'descbinds-anything nil t)
	;; describe-bindings��Anything�ɒu��������
	(descbinds-anything-install))

;  ;; grep��Anything-grep�Œu��������
;  (require 'anything-grep nil t)
  
  ;; �v color-moccur.el
  (when (require 'anything-c-moccur nil t)
	(setq 
	 ;; anything-c-moccur�p `anything-idle-delay
	 anything-c-moccur-anything-idle-delay 0.1
	 ;; �o�b�t�@�̏����n�C���C�g����
	 lanything-c-moccur-higlight-info-line-flag t
	 ;; ���ݑI�𒆂̌��̈ʒu���ق���Window��\������
	 anything-c-moccur-enable-auto-look-flag t
	 ;; �N�����Ƀ|�C���g�̈ʒu�̒P��������p�^�[���ɂ���
	 anything-c-moccur-enable-initial-pattern t)
	 ;; C-M-o��anything-c-moccur-occur-by-moccur�����蓖�Ă�
	(global-set-key (kdb "C-M-o") 'anything-c-moccur-occur-by-moccur))
)
;; end of setting Anything

;; ���̋@�\��INSTALL�����cpp�t�@�C����float�Ȃǂ����͂ł��Ȃ��Ȃ�B
;; �������͂ł��Ȃ�
;; Auto-complete
;; (when (require 'auto-complete-config nil t)
;;   (add-to-list 'ac-dictionary-directories
;; 			   "~/.emacs.d/elisp/ac-dict")
;; ; �Ӗ��Ȃ��H
;; ;  (add-to-list 'ac-dictionary-directories
;; ;			   "~/.emacs.d/elpa/auto-complete-1.4/dict")

;;   (define-key ac-mode-map (kbd "f5") 'auto-complete)
;;   (ac-config-default)
;; )
;; End of setting Auto-complete


;; cua-mode(��`�ҏW)
(cua-mode t)							; cua-mode = ON
(setq cua-enable-cua-keys nil)			; CUA�L�[�o�C���h�𖳌��ɂ���

;; paren-mode : �Ή����銇�ʂ��������ĕ\������
(setq show-paren-delay 0) ; �\���܂ł̕b���B�����l��0.125
(show-paren-mode t)      ; �L����
;; paren�̃X�^�C��; expression�͊��ʓ��������\��
(setq show-paren-style 'expression)
;;�t�F�C�X��ύX����(�w��̐F��underline������)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; ���݁A�ǂ��̊֐����ɂ��邩����ɉ�ʏ㕔�ɕ\������
(which-func-mode t)
;; �S�Ẵ��W���[���[�h�ɑ΂��� which-func-mode��K�p����B
(setq which-func-modes t)

;; ��ʏ㕔�ɕ\������ꍇ�́A���Q�����K�v�B
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format))) 

;; +++++++++++++++++++++ grep �g�� ++++++++++++++++++++
;; grep�̃o�b�t�@�𕡐��ێ��ł���悤�ɂ���B
;; install-elisp-from-emacswiki grep-a-lot.el
(when (require 'grep-a-lot)
  (grep-a-lot-setup-keys)
  ;; igrep���g���l�p
  (grep-a-lot-advise igrep)
)

;; +++++++++++++++++++ HOOKS +++++++++++++++++++++++++++

;; ++++GTAGS
;(setq gtags-libpath "V:/Project/ctrl/Wbond/UTC-500/inc/v2.1536/;V:/Project/ctrl/SYSLIB/v1.0057/src/;V:/Project/ctrl/SYSLIB/v1.0057/inc/;V:/Project/ctrl/BaseInc/v3.0015/;V:/Project/ctrl/Wbond/UTC_2011/APL/utclib/v3.0026/src/;V:/Project/ctrl/Wbond/UTC_2011/INC/v4.0105/;V:/Project/ctrl/BOS/v3.xxxx/v3.0010/src/;V:/Project/ctrl/BOS/v3.xxxx/v3.0010/inc/;")
(setenv "GTAGSLIBPATH" "V:/Project/ctrl/Wbond/UTC-500/inc/v2.1536/;V:/Project/ctrl/SYSLIB/v1.0057/src/;V:/Project/ctrl/SYSLIB/v1.0057/inc/;V:/Project/ctrl/BaseInc/v3.0015/;V:/Project/ctrl/Wbond/UTC_2011/APL/utclib/v3.0026/src/;V:/Project/ctrl/Wbond/UTC_2011/INC/v4.0105/;V:/Project/ctrl/BOS/v3.xxxx/v3.0010/src/;V:/Project/ctrl/BOS/v3.xxxx/v3.0010/inc/;")
(defun gtags-startup-hooks ()
  "gtags-startup-hooks"
  ;; LOAD
  (when (require 'gtags nil t)
	(gtags-mode t)						;gtags���[�h
	(setq gtags-path-style 'absolute)			;default=root
	(local-set-key [C-f7] 'gtags-find-tag-from-here)
	(local-set-key [M-f7] 'gtags-pop-stack)
	)
)
;Cygwin�{Emacs�̏ꍇ�ɕK�v�ɂȂ�炵���BWindows���NTEmacs�̏ꍇ�͕s�v�H�H�H
; 	;; Install-elisp-from-emacswiki RET cygwin-mount.el
; 	;; Cygwin���g�p���Ă�����ł́A�������\�[�X�̈ʒu��\�����Ă���Ȃ���肪����܂��B
; 	;; ����Ȃ�ł�炵������
; 	;; Use C-u M-x make-directory RET RET to create directory and its parents
; 	(when (and (string-equal system-type "windows-nt")
; 			   (require 'cygwin-mount nil t))
; 	  (cygwin-mount-activate))
; 	)
;)

;; emacs-lisp-mode-hook�p�̊֐����`
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  ;; ECHO�G���A��Elisp�̏�����\�����܂��B
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))

;; emacs-lisp-mode�̃t�b�N���Z�b�g
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;; C����n�̋���HOOK
(defun c-mode-common-hooks ()
  "c-mode-common-hooks"

  ;; �܂��݋@�\(�}�C�i�[���[�h)
  ;; install-elisp :: http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Download/fold-dwim.el
  (when (and (require 'hideshow nil t)
			 (require 'fold-dwim nil t))
	;; �u���b�N�܂��݋@�\�̃}�C�i�[���[�h�L��
	(hs-minor-mode t)
	;; F7�L�[�Ftoggle
	(local-set-key [f7] 'fold-dwim-toggle)
	;; F8�L�[ :show
	(local-set-key [f8] 'fold-dwim-show-all)
	;; F9�L�[ :hide
	(local-set-key [f9] 'fold-dwim-hide-all)
	)
  ;; #ifdef , #ifndef , #if 0 , #else �̃v���v���Z�b�T���B��
  ;; C-c @ C-d = hide-ifdef-block
  ;; C-c @ C-s = show-ifdef-block
  (when (require 'hideif nil t)
	(hide-ifdef-mode))
)

;; C����n����HOOK�ɒǉ�����
(add-hook 'c-mode-common-hook 'c-mode-common-hooks)

;;C����̃C���f���g�ʂ��u�S�v�ɂ���
(setq c-mode-hook
	   '(lambda ()
		  (c-set-style "stroustrup" )
		  (setq c-basic-offset 4 )

		  ;; #if 0- #endif ʲײ�
		  (cpp-highlight-buffer t)

		  ;; GTAGS�𗘗p�\�ɂ��܂��B
		  ;; �e���ꂲ�Ƃ�HOOK�𗘗p���邱�ƂŐݒ肪�㏑������ɂ������܂��B 
		  (gtags-startup-hooks)
		  ))

;; (setq c-tab-always-indent t) ;�������C���f���g
;;(setq lisp-indent-line 4 );

;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (c-set-offset 'innamespace 0)   ; namespace {}�̒��̓C���f���g���Ȃ�

			 ;; #if 0- #endif ʲײ�
			 (cpp-highlight-buffer t)

			 ;; GTAGS�𗘗p�\�ɂ��܂��B
			 ;; �e���ꂲ�Ƃ�HOOK�𗘗p���邱�ƂŐݒ肪�㏑������ɂ������܂��B 
			 (gtags-startup-hooks)

             )) 

;--------------------------------------------------
;; cpp-highlight-buffer�̐ݒ�
;--------------------------------------------------
;; known�Ȃ���\��
(setq cpp-known-face 'default)
;; unknown�Ȃ�̓n�C���C�g����
(setq cpp-unknown-face 'highlight)
;; �I�Ԃ̂�light background
(setq cpp-face-type 'light)
;; known��unknown��writable
(setq cpp-known-writable 't)
(setq cpp-unknown-writable 't)


;;  symbol              true            false           writable
;;  -----------------------------------------------------------------
;;  0                   light gray      default         both
;;  1                   default         light gray      both
;; (setq cpp-edit-list
;;       '((#("1" 0 1
;; 	   (fontified t c-in-sws t))
;; 	 nil
;; 	 (background-color . "medium purple")
;; 	 both nil)
;; 	(#("0" 0 1
;; 	   (fontified t c-in-sws t))
;; 	 (background-color . "medium purple")
;; 	 nil both nil)))

;; ���̃t�@�C���ɊԈႢ���������ꍇ�ɑS�Ă𖳌��ɂ��܂�
;(put 'eval-expression 'disabled nil)


;; installed elisp files
;(install-elisp "http://www.emacswiki.org/emacs/download/redo+.el") ; REDO
;(install-elisp "http://bit.ly/pkg-el") 	;Packages for Emacs24

;  package-install
;(package-install 'multi-term)

;; ++++++++++ SPEEDBAR ++++++++++++++
;; Install-elisp-from-emacswiki
(require 'sr-speedbar)					;�t���[���̒���SPEEDBAR��ݒu����

;; 
;;  +++++++++ Entry Register +++++++++++
;; EMACS���ꎞ�I�ɕێ�����f�[�^�ł��B
(set-register ?e '(file . "~/.emacs.d/init.el")) ;C-x r j e

