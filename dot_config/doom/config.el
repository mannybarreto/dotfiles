;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq shell-file-name (executable-find
                       "bash"))
(setq-default vterm-shell
              "/opt/homebrew/bin/fish") (setq-default explicit-shell-file-name
              "/opt/homebrew/bin/fish")

(setq doom-theme 'modus-vivendi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Load files
(load! "keymaps.el")

(setq doom-font (font-spec :family "MesloLGM Nerd Font Mono" :size 14))

(setq scroll-margin 5)

;; Use Emacs for GPG passphrase entry
(setq epa-pinentry-mode 'loopback)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! gptel
  :config
  (setq gptel-default-mode 'org-mode)

  ;; Function to read API key from GPG file
  (defun my/read-anthropic-api-key ()
    "Read Anthropic API key from encrypted GPG file."
    (with-temp-buffer
      (insert-file-contents "~/.emacs.d/anthropic-api-key.gpg")
      (string-trim (buffer-string))))

  ;; Configure Claude 3.7 Sonnet backend
  (setq my/claude-backend (gptel-make-anthropic
                              "Claude-3.7-Sonnet"
                            :key #'my/read-anthropic-api-key
                            :stream t
                            :models '(claude-3-7-sonnet-20250219)))

  ;; Configure Gemma backends
  (setq my/gemma-12b-backend (gptel-make-ollama
                                 "Gemma-12B"
                               :host "localhost:11434"
                               :stream t
                               :models '(gemma3:12b)))

  (setq my/gemma-27b-backend (gptel-make-ollama
                                 "Gemma-27B"
                               :host "localhost:11434"
                               :stream t
                               :models '(gemma3:27b)))

  ;; Set Gemma 12B as the default
  (setq gptel-backend my/gemma-12b-backend)
  (setq gptel-model 'gemma3:12b)

  ;; Function to cycle between models
  (defun my/gptel-cycle-model ()
    "Cycle between Claude and Gemma models."
    (interactive)
    (cond
     ((eq gptel-backend my/claude-backend)
      (setq gptel-backend my/gemma-12b-backend)
      (setq gptel-model 'gemma3:12b)
      (message "Switched to Gemma 12B model"))
     ((eq gptel-backend my/gemma-12b-backend)
      (setq gptel-backend my/gemma-27b-backend)
      (setq gptel-model 'gemma3:27b)
      (message "Switched to Gemma 27B model"))
     (t
      (if (my/internet-connected-p)
          (progn
            (setq gptel-backend my/claude-backend)
            (setq gptel-model 'claude-3-7-sonnet-20250219)
            (message "Switched to Claude model"))
        (progn
          (setq gptel-backend my/gemma-12b-backend)
          (setq gptel-model 'gemma3:12b)
          (message "Cannot use Claude (offline) - using Gemma 12B instead"))))))

  ;; Function to check internet connection
  (defun my/internet-connected-p ()
    "Return non-nil if an internet connection is available."
    (= 0 (call-process "ping" nil nil nil "-c" "1" "-W" "1" "anthropic.com")))

  ;; Function to force Claude usage with internet check
  (defun my/gptel-use-claude ()
    "Switch to Claude model if internet is available."
    (interactive)
    (if (my/internet-connected-p)
        (progn
          (setq gptel-backend my/claude-backend)
          (setq gptel-model 'claude-3-7-sonnet-20250219)
          (message "Switched to Claude model"))
      (message "Cannot use Claude - no internet connection")))

  ;; Function to force Gemma 12B usage
  (defun my/gptel-use-gemma-12b ()
    "Switch to Gemma 12B model."
    (interactive)
    (setq gptel-backend my/gemma-12b-backend)
    (setq gptel-model 'gemma3:12b)
    (message "Switched to Gemma 12B model"))

  ;; Function to force Gemma 27B usage
  (defun my/gptel-use-gemma-27b ()
    "Switch to Gemma 27B model."
    (interactive)
    (setq gptel-backend my/gemma-27b-backend)
    (setq gptel-model 'gemma3:27b)
    (message "Switched to Gemma 27B model"))

  ;; Keybindings
  (map! :leader
        :prefix "c g"
        :desc "GPTel Chat"         "c" #'gptel
        :desc "GPTel Add"          "a" #'gptel-add
        :desc "GPTel Send"         "s" #'gptel-send
        :desc "Cycle Model"        "t" #'my/gptel-cycle-model
        :desc "Use Claude"         "C" #'my/gptel-use-claude
        :desc "Use Gemma 12B"      "1" #'my/gptel-use-gemma-12b
        :desc "Use Gemma 27B"      "2" #'my/gptel-use-gemma-27b))

(after! dap-rust
  ;; Tell dap-rust which debugger program to use.
  ;; It should find 'rust-gdb' in your PATH if rustup installed it correctly.
  (setq dap-rust-debug-program '("rust-gdb"))

  ;; Optional: Define explicit templates if auto-detection doesn't work well.
  ;; Often, just setting dap-rust-debug-program is enough, and dap-mode
  ;; will generate a suitable configuration when you run `dap-debug`.
  ;; But if you need specific control, you can uncomment and adapt these:
  ;; (dap-register-debug-template
  ;;  "Rust :: rust-gdb Launch"
  ;;  (list :type "gdb" ; Assumes dap-mode's built-in GDB MI driver
  ;;        :request "launch"
  ;;        :name "Rust Launch (rust-gdb)"
  ;;        ;; dap-mode's GDB integration uses :target for the program to debug
  ;;        :target (lambda () (car (dap--read-compilation-program "target/debug/" :exit-fn #'executable-find)))
  ;;        :cwd "${workspaceFolder}"
  ;;        ;; Ensure rust-gdb is the command dap uses to start gdb
  ;;        :gdbpath "rust-gdb"
  ;;        ;; :args [] ; Add command line arguments for your program here
  ;;        ;; :env {} ; Add environment variables here
  ;;        ))
  ;;
  ;; (dap-register-debug-template
  ;;  "Rust :: rust-gdb Test"
  ;;  (list :type "gdb"
  ;;        :request "launch"
  ;;        :name "Rust Test (rust-gdb)"
  ;;        :target (lambda () (car (dap--read-compilation-program "target/debug/deps/" :exit-fn #'executable-find))) ; Find test binary
  ;;        :cwd "${workspaceFolder}"
  ;;        :gdbpath "rust-gdb"
  ;;        ))
  )
