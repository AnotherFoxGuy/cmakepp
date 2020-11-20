function(address_type_matches ref expectedType)
  is_address(${ref})
  ans(isref)

  if(NOT isref)
    return(false)
  endif()

  address_type_get(${ref})
  ans(type)
  if(NOT "${type}" STREQUAL "${expectedType}")
    return(false)
  endif()
  return(true)
endfunction()
