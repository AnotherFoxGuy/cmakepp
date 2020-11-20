# safe append (can also append empty element)
function(list_append __lst value)
  if("${value}_" STREQUAL "_")
    set(value ";")
    if("${${__lst}}_" STREQUAL "_")
      return()
    endif()
  endif()
  set(${__lst}
      ${${__lst}} "${value}"
      PARENT_SCOPE)
  return()
endfunction()
