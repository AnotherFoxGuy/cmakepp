# returns all valid indices for the specified range
function(range_indices_valid __len)
  range_indices("${__len}" ${ARGN})
  ans(__indices2)
  set(__indices)
  foreach(__idx ${__indices2})
    if(NOT ${__idx} LESS 0 AND ${__idx} LESS ${__len})
      list(APPEND __indices ${__idx})
    endif()
  endforeach()
  return_ref(__indices)
endfunction()
