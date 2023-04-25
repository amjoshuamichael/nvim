["?" "@"] @keyword
(statement return: (";" @keyword (expression)))
(if_else_statement ":" @keyword)

[(binary_lit) (octal_lit) (hex_lit) (decimal_lit) (float_lit) (bool_lit)] @number
(string_lit) @string

(call func: ((var_name) @function))
(function_definition name: ((var_name) @function))

(parameter (var_declaration (var_name) @variable.parameter))

(comment) @comment

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

"." @punctuation.delimiter

(type_parameters "<" @punctuation.bracket ">" @punctuation.bracket)

(dereference_type "*" @operator)
(reference_type "&" @operator)
(type (type_name) @type) 
(type (type_level_func (type_name) @type)) 
(type_defintion (type_name) @type)

(type (int_type) @type.builtin)
(type (float_type) @type.builtin)
(type (bool_type) @type.builtin)

;(math_expr (var_name) @variable.local)
;(statement (var_declaration (var_name) @variable.local))
