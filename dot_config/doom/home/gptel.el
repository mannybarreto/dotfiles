;; LLM configuration for home use only

(use-package aidermacs
  :bind (("C-c a" . aidermacs-transient-menu))
  :config
  (setq aidermacs-program "/Users/mannybarreto/.local/bin/aider")
  (setq aidermacs-backend 'comint)  ;; Use comint backend instead of vterm
  :custom
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet"))

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
