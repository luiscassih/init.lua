;; extends
; (("return"   @keyword.function) (#set! conceal "󰌑"))
; (("return"   @keyword.function) @Boolean)
(("function"     @keyword.function) (#set! conceal "󰊕"))
(("export"     @keyword.export) (#set! conceal "🢦"))
; (("const"     @keyword) (#set! conceal "✅"))
(("["     @punctuation.bracket) (#set! conceal "⎣"))
(("]"     @punctuation.bracket) (#set! conceal "⎤"))
; (("<" @punctuation.bracket) (#set! conceal "〈"))
; ((">" @punctuation.bracket) (#set! conceal "〉"))
(("const" @keyword) (#set! conceal "Ⅽ"))
(("type" @keyword) (#set! conceal "Τ"))
(("let" @keyword) (#set! conceal "Ⅼ"))
(("interface" @keyword) (#set! conceal "Ⅰ"))
(("import" @keyword.import) (#set! conceal "😈"))
; (("const" @keyword) (#set! conceal "コンスト"))
; (("const" @keyword) (#set! conceal "コンスト"))
; (("const" @keyword) (#set! conceal "コンスト"))
; alternative: https://github.com/luckasRanarison/tailwind-tools.nvim/blob/master/queries/tsx/class.scm
(
  (property_identifier) @att_name
  (#any-of? @att_name "class" "className")
  ; both string and string_fragment are for inside the quotes
  ; if I only put string @att_value, it will replace all after =, including quotes
  (string (string_fragment) @att_val)
  (#substr! @att_val 20 -1)
  (#set! @att_val conceal "…")
)
; (
;   (comment) @comment
;   (#match? @comment "^//.*[x]")
;   (#substr! @comment 3 6)
;   (#set! @comment conceal "✅")
; )
(
  (comment) @comment
  (#contains? @comment "[x]")
  ; this looks for the first find
  (#find_set_range! @comment "[x]")
  ; this sets metadata.conceal for this node
  ; if we want more, we need more nodes
  (#set! @comment conceal "☑")
)
(
  (comment) @comment
  (#contains? @comment "[ ]")
  (#find_set_range! @comment "[ ]")
  (#set! @comment conceal "☐")
)
(
  (comment) @comment
  (#contains? @comment "TODO")
) @TODOComment ;don't forget to add this new group to for example catppuccin
