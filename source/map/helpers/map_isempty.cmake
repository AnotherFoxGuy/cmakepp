function(map_isempty map)
  map_keys(${map})
  ans(keys)
  list(LENGTH keys len)
  if(len)
    return(false)
  else()
    return(true)
  endif()
endfunction()
