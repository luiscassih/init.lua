; relevant
; https://github.com/ray-x/nvim/tree/master/after/queries/go
;; extends
;; Keywords
(("return"   @keyword) (#set! conceal "󰌑"))
; (("var"      @keyword) (#set! conceal  "ν"))
;; (("if"       @keyword) (#set! conceal "? "))
;; (("else"     @keyword) (#set! conceal "! "))
(("func"     @keyword) (#set! conceal "󰊕"))
; (("for"      @keyword) (#set! conceal ""))
(("break"    @keyword.return) (#set! conceal  "󱞣"))
; (("import"   @keyword) (#set! conceal  "󰶮"))
(("package"  @keyword) (#set! conceal  ""))
; (("continue" @keyword) (#set! conceal "↙"))

;; Function names
; ((call_expression function: (identifier) @function (#eq? @function "panic"  )) (#set! conceal ""))

;; type
; (((type_identifier) @type (#eq? @type "error")) (#set! conceal ""))
; (((nil) @type (#set! conceal "🈳")))
; (((true) @type (#set! conceal "")))
; (((false) @type (#set! conceal "")))
;; fmt.*
; (((selector_expression) @error (#eq? @error "fmt.Println"     )) (#set! conceal ""))
;; mutex
; (((selector_expression) @field (#eq? @field "mu.Lock"     )) (#set! conceal ""))
; (((selector_expression) @field (#eq? @field "mu.Unlock"     )) (#set! conceal ""))
;; type
; (((qualified_type) @type (#eq? @type "testing.T")) (#set! conceal "τ"))
;; identifiers
; (((identifier) @type (#eq? @type "err"     )) (#set! conceal "ε"))
; (((identifier) @type (#eq? @type "Response"     )) (#set! conceal ""))
; (((identifier) @field (#eq? @field "Errorf"     )) (#set! conceal "🥹"))
; (((identifier) @field (#eq? @field "assert"     )) (#set! conceal "🅰️"))
; (((field_identifier) @field (#eq? @field "Error"     )) (#set! conceal ""))
; (((field_identifier) @field (#eq? @field "Equal"     )) (#set! conceal "🟰"))
