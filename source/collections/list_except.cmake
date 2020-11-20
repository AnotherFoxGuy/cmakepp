# return those elemnents of minuend that are not in subtrahend
function(list_except __list_except_minuend list_except_subtrahend)
  set(__list_except_result)
  foreach(__list_except_current ${${__list_except_minuend}})
    list(FIND ${list_except_subtrahend} "${__list_except_current}"
         __list_except_idx)
    if(${__list_except_idx} LESS 0)
      list(APPEND __list_except_result ${__list_except_current})
    endif()
  endforeach()
  return_ref(__list_except_result)
endfunction()
