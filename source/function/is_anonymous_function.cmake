
function(is_anonymous_function)
  if(NOT ARGN)
    return(false)
  elseif("${ARGN}" MATCHES "^\\([^\\)]*\\)")
    return(code)
  elseif(COMMAND "${ARGN}" AND "${ARGN}" MATCHES "^anonymous_[a-zA-Z0-9_]+$")
    return(instance)
  endif()
  message("${ARGN}")
  return(false)
endfunction()
