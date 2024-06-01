;extends
((function_definition
  name: (identifier) @fn.name
  parameters: (parameters) @fn.param
  (#offset! @fn.param 0 1 0 -1)))

;extends
((function_definition
  name: (identifier) @fn.name))
