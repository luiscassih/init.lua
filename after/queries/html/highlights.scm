;; extends
(attribute
  (attribute_name) @_attribute_name
  (#eq? @_attribute_name "class")
  (quoted_attribute_value (attribute_value) @att_val)
  (#set! @att_val conceal "…"))
