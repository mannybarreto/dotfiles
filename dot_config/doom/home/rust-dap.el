;; Rust DAP configuration for home use only
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