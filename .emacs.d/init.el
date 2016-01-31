;; 2012/09/11 -- DAISUKE INOUE --
(setq debug-on-error t)					;問題発生時に*BACKTRACE*を開く

;; IMEについて
;; Windows Xpを使用の場合　→　MS-IMEで問題なく使用可能です。
;; Windows 7を使用の場合　→　GoogleIMEを使用してください。
;; ※MS-IMEを使用するとインライン入力ができなくなる。
;;  ++++++++++++++++++++++++++++ LOAD-PATH +++++++++++++++++++++++++++
;; ;; load-path を追加する関数を定義
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
;; ;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
;; (add-to-load-path "elisp" "conf" "public_repos")

;; 上記の自動化は、%HOME%から起動した場合のみ有効。
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/conf")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/etc")
(add-to-list 'load-path "~/.emacs.d/public_repos")

(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/elisp/color-theme-6.6.0/themes")
(add-to-list 'load-path "~/.emacs.d/elisp/packages")

;; ++++++++++++++++++++++ PACKAGES +++++++++++++++++++++
;; package.el の設定
(when (require 'package nil t)
  ;; パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
  (add-to-list 'package-archives
			   '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
			   '("ELPA" . "http://tromey.com/elpa/"))
  ;; インストールしたパッケージにロードパスを通して読み込む
  (package-initialize)
)

;; ユーザ用初期化ファイル
;(if (file-exists-p (expand-file-name "~/.emacs.my.el"))
;    (load (expand-file-name "~/.emacs.my.el") nil t nil))

;;  ++++++++++++++++++++++++ ENVIRONMENT +++++++++++++++++++++++++
;; Set Environment

;(setenv "PATH" "C:\\cybwin\\bin") 		;PATHを上書きする
;(setenv "PATH" (format "C:\\cybwin\\bin;%s" (getenv "PATH"))) ;PATHに追加する
;(add-to-list 'exec-path "c:/cygwin/bin")
;(add-to-list 'exec-path "c:/cygwin/bin/Global")
;(add-to-list 'exec-path "~/.emacs.d/bin")

;; Here are refence from "http://stackoverflow.com".
;; この設定だとWindowsXPではOK。ただしWindows7だとNG
;;windows only stuff
;; (when (string-equal system-type "windows-nt")
;;   (progn
;; 	(setq cygwin-bin "c:\\cygwin\\bin")
;; 	(setq gnu-bin "C:\\apps\\GnuWin32\\gnuwin32\\bin")
;; 	(setenv "PATH"
;; 			(concat cygwin-bin ";" gnu-bin ";"))
;; 	(setq exec-path
;; 		  '(cygwin-bin gnu-bin)))) 

;; 文字コードを指定する
(set-language-environment 'Japanese)
;(prefer-coding-system 'shift_jis)		;S-JISを設定
(prefer-coding-system 'utf-8)

;; PATHの設定を行います。
;; WindowsXp , Windows7両方で動作確認済み
;; cygwin-bin に設定しているパスにgrep等のexeファイルを格納すること
(when (string-equal system-type "windows-nt")
  (progn
	(setq cygwin-bin "c:/cygwin/bin")
	(setq gnu-global (concat (getenv "HOME") "/GnuGlobal/bin"))				;GnuGlobalへのPATH
	(setq home-bin (concat (getenv "HOME") "/bin")) ; ~/bin
	(setq home-bat (concat (getenv "HOME") "/bat")) ; ~/bat
	(setq local-paths (getenv "PATH"))		;現在の環境PATHを取得する

	;; 環境PATHの設定:SHELLから実行する際にglobal.exeなどをCALLできるようにする
;	(setenv "PATH"
;			(concat cygwin-bin ";" gnu-global ";" local-paths)) ;EMACSのPATH設定＋現在の環境PATH
	(setenv "PATH"
			(concat cygwin-bin ";" gnu-global ";" home-bin ";" home-bat ";" local-paths)) ;EMACSのPATH設定＋現在の環境PATH

	;; exec-pathの設定：emacs内部からgrep.exe,global.exeをCALLする場合に必要
	(add-to-list 'exec-path home-bat)	;~/bat
	(add-to-list 'exec-path home-bin)	;~/bin
	(add-to-list 'exec-path cygwin-bin)	; cygwinのexe
	(add-to-list 'exec-path gnu-global)	; gtags
    (setq locale-coding-system 'cp932)
    (set-file-name-coding-system 'cp932)
))

;; 起動時の画面を非表示にする
(setq inhibit-startup-message t)

;; バックアップファイルを作らない
;;(setq backup-inhibited t)
(setq make-backup-files nil) ; 初期値=t
;; オートセーブファイルは作る
(setq auto-save-default t) ; 初期値=t

;; バックアップファイルの作成場所をシステムのtempディレクトリに変更する
;(setq backup-directory-alist
;	  `((".*" . ,temporary-file-directory)))

;; オートセーブファイルの作成場所をシステムのtempディレクトリに変更する
;(setq auto-save-file-name-transforms
;	  `((".*" ,temporary-file-directory t)))

; temporary-file-directory : システムのTEMP

;; +++++++++++++++++++++++ KEY BINDING +++++++++++++++++++++++++
;; [f1] :HELP
;; [f2] :find-file   :C-x C-f
;; [f3] :buffer-menu :C-x C-b
;; [f4]
;; [f5]
;; [f6]
;; [f7] :fold-dwim-toggle   : cc-mode :ブロック折り畳み機能
;; [f8] :fold-dwim-show-all : cc-mode :ブロック折り畳み機能
;; [f9] :fold-dwim-hide-all : cc-mode :ブロック折り畳み機能

(global-set-key [f2] 'find-file)		 ; C-x C-f
(global-set-key [f3] 'buffer-menu)		 ; open buffer windwow

(global-set-key [M-left] 'shrink-window-horizontally)
(global-set-key [M-right] 'enlarge-window-horizontally)

(global-set-key [M-up] 'shrink-window)
(global-set-key [M-down] 'enlarge-window)

(global-set-key [C-tab] 'other-window)  ; ohter-window
;(global-set-key [C-tab] 'winring-jump-to-configuration)

;; [C-t]でバッファを切り替える。初期値は"transpose-chars"
;;(global-set-key [C-t] 'other-window)

;; C-c から始まるコマンドは拡張機能の指針としてユーザのために
;; 空けておくというルールがあります。そのため,C-c Xxx に登録するのが良い。

;;lgrep設定
;(setq grep-command "lgrep -n -Oe")
;(setq grep-program "lgrep")

;;  ++++++++++++++++++++ DISPLAY INFORMATION on TITLE BAR ++++++
;; タイトルバーにファイル名を表示
(setq frame-title-format "%f")

;; メニューバーを非表示にする
;(menu-bar-mode -1)

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; +++++++++++++ DISPLAY INFORMATION on MODE LINE. +++++++++++++
;; 時刻を24時間制でモードラインに表示
(setq display-time-24hr-format t)
(display-time)

;; Display column number.
(column-number-mode t) 

;; Display file-size
(size-indication-mode t)

;; ++++++++++++ DISPLAY INFORMATION on BUFFER ++++++++++++++
;; Display line-number
(global-linum-mode t)

;;Tabの幅を４(setq-defaultにしないとすべてのバッファに適用できない）
(setq-default tab-width 4)

;; 長い行でも折り返さない
(setq-default truncate-lines t)

;; 全角空白と改行文字を表示する
;; install-elisp RET http://homepage3.nifty.com/satomii/software/jaspace.el
(when (require 'jaspace nil t)
  (setq jaspace-alternate-jaspac-string "□") ;全角空白をこの字で表示
  (if window-system
	  (setq jaspace-alternate-eol-string "↓\n")) ;改行文字
  (setq jaspace-highlight-tabs t)
)
;;  ------------------------------------------------------------
;; 色変更
(when (require 'color-theme nil t)
  ;; テーマを読み込むための設定
  (color-theme-initialize)
  ;; テーマをgnome2に変更する
  (color-theme-gnome2)
)

;; auto-install
(when (require 'auto-install nil t)
  ;; インストールディレクトリを設定する。初期値は, ~/.emacs.d/auto-install/
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;; install-elispを利用可能にする
  (auto-install-compatibility-setup)	;互換性確保
)

;; Redo
(when (require 'redo+ nil t)
  ;; C-.にredoを割り当てる
  (global-set-key (kbd "C-.") 'redo)
)

;; color-moccur
;(auto-install-from-emacswiki) RET (color-moccur.el) RET
(when (require 'color-moccur nil t)
  ;; M-oにoccur-by-moccurを割り当てる
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでＡＮＤ検索
  (setq moccur-split-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$") ;#init.el#は除外する
  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
			 (require 'migemo nil t))
	(setq moccur-use-migemo t))
)
;; end of setting color-moccur

;; anything
;; (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq 
   ;; 候補を表示するまでの時間. default = 0.5
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間. default = 0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数. default = 50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
	;; root権限でアクションを実行するときのコマンド
	;; default = "su"
	(setq anything-su-or-sudo "sudo"))

  ;; Pattern matchingを拡張する
  (require 'anything-match-plugin nil t)
  
  ;; 日本語環境の場合は必要
  ;; http://0xcc.net/migemo/
  (when (and (equal current-language-environment "Japanese") ;日本語環境
			 (executable-find "cmigemo")
			 (require 'migemo nil t))
	(require 'anything-migemo nil t))

  (when (require 'anything-complete nil t)
	;; lispシンボルの補完候補の再検索時間
	(anything-lisp-complete-symbol-set-timer 150))

  ;; shows current selection prettily.
  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
	(require 'anything-auto-install nil t))

  ;; 
  (when (require 'descbinds-anything nil t)
	;; describe-bindingsをAnythingに置き換える
	(descbinds-anything-install))

;  ;; grepをAnything-grepで置き換える
;  (require 'anything-grep nil t)
  
  ;; 要 color-moccur.el
  (when (require 'anything-c-moccur nil t)
	(setq 
	 ;; anything-c-moccur用 `anything-idle-delay
	 anything-c-moccur-anything-idle-delay 0.1
	 ;; バッファの情報をハイライトする
	 lanything-c-moccur-higlight-info-line-flag t
	 ;; 現在選択中の候補の位置をほかのWindowを表示する
	 anything-c-moccur-enable-auto-look-flag t
	 ;; 起動時にポイントの位置の単語を初期パターンにする
	 anything-c-moccur-enable-initial-pattern t)
	 ;; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
	(global-set-key (kdb "C-M-o") 'anything-c-moccur-occur-by-moccur))
)
;; end of setting Anything

;; この機能をINSTALLするとcppファイルでfloatなどが入力できなくなる。
;; ｆが入力できない
;; Auto-complete
;; (when (require 'auto-complete-config nil t)
;;   (add-to-list 'ac-dictionary-directories
;; 			   "~/.emacs.d/elisp/ac-dict")
;; ; 意味ない？
;; ;  (add-to-list 'ac-dictionary-directories
;; ;			   "~/.emacs.d/elpa/auto-complete-1.4/dict")

;;   (define-key ac-mode-map (kbd "f5") 'auto-complete)
;;   (ac-config-default)
;; )
;; End of setting Auto-complete


;; cua-mode(矩形編集)
(cua-mode t)							; cua-mode = ON
(setq cua-enable-cua-keys nil)			; CUAキーバインドを無効にする

;; paren-mode : 対応する括弧を強調して表示する
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t)      ; 有効化
;; parenのスタイル; expressionは括弧内も強調表示
(setq show-paren-style 'expression)
;;フェイスを変更する(指定の色でunderlineを引く)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; 現在、どこの関数内にいるかを常に画面上部に表示する
(which-func-mode t)
;; 全てのメジャーモードに対して which-func-modeを適用する。
(setq which-func-modes t)

;; 画面上部に表示する場合は、下２桁が必要。
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format))) 

;; +++++++++++++++++++++ grep 拡張 ++++++++++++++++++++
;; grepのバッファを複数保持できるようにする。
;; install-elisp-from-emacswiki grep-a-lot.el
(when (require 'grep-a-lot)
  (grep-a-lot-setup-keys)
  ;; igrepを使う人用
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
	(gtags-mode t)						;gtagsモード
	(setq gtags-path-style 'absolute)			;default=root
	(local-set-key [C-f7] 'gtags-find-tag-from-here)
	(local-set-key [M-f7] 'gtags-pop-stack)
	)
)
;Cygwin＋Emacsの場合に必要になるらしい。Windows上でNTEmacsの場合は不要？？？
; 	;; Install-elisp-from-emacswiki RET cygwin-mount.el
; 	;; Cygwinを使用している環境では、正しくソースの位置を表示してくれない問題があります。
; 	;; こんなんでるらしい↓↓
; 	;; Use C-u M-x make-directory RET RET to create directory and its parents
; 	(when (and (string-equal system-type "windows-nt")
; 			   (require 'cygwin-mount nil t))
; 	  (cygwin-mount-activate))
; 	)
;)

;; emacs-lisp-mode-hook用の関数を定義
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  ;; ECHOエリアにElispの書式を表示します。
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))

;; emacs-lisp-modeのフックをセット
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;; C言語系の共通HOOK
(defun c-mode-common-hooks ()
  "c-mode-common-hooks"

  ;; 折り畳み機能(マイナーモード)
  ;; install-elisp :: http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Download/fold-dwim.el
  (when (and (require 'hideshow nil t)
			 (require 'fold-dwim nil t))
	;; ブロック折り畳み機能のマイナーモード有効
	(hs-minor-mode t)
	;; F7キー：toggle
	(local-set-key [f7] 'fold-dwim-toggle)
	;; F8キー :show
	(local-set-key [f8] 'fold-dwim-show-all)
	;; F9キー :hide
	(local-set-key [f9] 'fold-dwim-hide-all)
	)
  ;; #ifdef , #ifndef , #if 0 , #else のプリプロセッサを隠す
  ;; C-c @ C-d = hide-ifdef-block
  ;; C-c @ C-s = show-ifdef-block
  (when (require 'hideif nil t)
	(hide-ifdef-mode))
)

;; C言語系共通HOOKに追加する
(add-hook 'c-mode-common-hook 'c-mode-common-hooks)

;;C言語のインデント量を「４」にする
(setq c-mode-hook
	   '(lambda ()
		  (c-set-style "stroustrup" )
		  (setq c-basic-offset 4 )

		  ;; #if 0- #endif ﾊｲﾗｲﾄ
		  (cpp-highlight-buffer t)

		  ;; GTAGSを利用可能にします。
		  ;; 各言語ごとのHOOKを利用することで設定が上書きされにくくします。 
		  (gtags-startup-hooks)
		  ))

;; (setq c-tab-always-indent t) ;半自動インデント
;;(setq lisp-indent-line 4 );

;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない

			 ;; #if 0- #endif ﾊｲﾗｲﾄ
			 (cpp-highlight-buffer t)

			 ;; GTAGSを利用可能にします。
			 ;; 各言語ごとのHOOKを利用することで設定が上書きされにくくします。 
			 (gtags-startup-hooks)

             )) 

;--------------------------------------------------
;; cpp-highlight-bufferの設定
;--------------------------------------------------
;; knownなやつも表示
(setq cpp-known-face 'default)
;; unknownなやつはハイライトする
(setq cpp-unknown-face 'highlight)
;; 選ぶのはlight background
(setq cpp-face-type 'light)
;; knownもunknownもwritable
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

;; このファイルに間違いがあった場合に全てを無効にします
;(put 'eval-expression 'disabled nil)


;; installed elisp files
;(install-elisp "http://www.emacswiki.org/emacs/download/redo+.el") ; REDO
;(install-elisp "http://bit.ly/pkg-el") 	;Packages for Emacs24

;  package-install
;(package-install 'multi-term)

;; ++++++++++ SPEEDBAR ++++++++++++++
;; Install-elisp-from-emacswiki
(require 'sr-speedbar)					;フレームの中にSPEEDBARを設置する

;; 
;;  +++++++++ Entry Register +++++++++++
;; EMACSが一時的に保持するデータです。
(set-register ?e '(file . "~/.emacs.d/init.el")) ;C-x r j e

