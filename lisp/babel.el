
(setq-default org-src-fontify-natively t         ; Fontify code in code blocks.
              org-adapt-indentation nil          ; Adaptive indentation
              org-src-tab-acts-natively t        ; Tab acts as in source editing
              org-confirm-babel-evaluate nil     ; No confirmation before executing code
              org-edit-src-content-indentation 0 ; No relative indentation for code blocks
              org-fontify-whole-block-delimiter-line t) ; Fontify whole block
