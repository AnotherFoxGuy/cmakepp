function(cmake_is_script_mode)
  if(CMAKE_SCRIPT_MODE_FILE)
    return(true)
  else()
    return(false)
  endif()
endfunction()
