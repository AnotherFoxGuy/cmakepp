# removes duplicates from a list
function(list_remove_duplicates __lst)
  list(LENGTH ${__lst} len)
  if(len EQUAL 0)
    return()
  endif()
  list(REMOVE_DUPLICATES ${__lst})
  set(${__lst}
      ${${__lst}}
      PARENT_SCOPE)
  return()
endfunction()
