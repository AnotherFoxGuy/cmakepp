function(query_literal_definition_add type function regex)
  map_new()
  ans(query_literal_def)
  callable_function("${function}")
  ans(function)
  map_set(${query_literal_def} type "${type}")
  map_set(${query_literal_def} function "${function}")
  if(regex)
    map_set(${query_literal_def} regex "${regex}")
    address_append(__query_literal_handlers_with_regex ${query_literal_def})
  endif()
  map_set(__query_literal_handlers "${type}" "${query_literal_def}")
  return_ref(query_literal_def)
endfunction()

macro(query_literal_definitions_with_regex)
  address_get(__query_literal_handlers_with_regex)
endmacro()
macro(query_literal_definitions)
  map_value(__query_literal_handlers)
endmacro()

function(query_literal_definition_function type)
  map_tryget(__query_literal_handlers "${type}")
  ans(handler)
  map_tryget("${handler}" function)
  return_ans()

endfunction()

macro(query_literal_definition type)
  map_tryget(__query_literal_handlers "${type}")
endmacro()
