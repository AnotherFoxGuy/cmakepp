function(ast_eval_identifier ast scope)
  map_get(${ast} data)
  ans(identifier)
  message("resolving identifier: ${identifier} in '${scope}'")

  map_has(${scope} "${identifier}")
  ans(has_value)
  if(has_value)
    map_get(${scope} "${identifier}")
    ans()
    return_ref(value)
  endif()
  # message("no value in scope")

  if(COMMAND "${identifier}")
    # message("is command")
    return_ref(identifier)
  endif()

  if(DEFINED "${identifier}")
    message("is a cmake var")
    return_ref(${identifier})
  endif()
  return()
endfunction()
