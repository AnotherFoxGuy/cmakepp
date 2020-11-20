# signature user_data_clear(<id:identifier>^"--all") removes the user data
# associated to identifier id WARNING: if --all flag is specified instead of an
# id all user data is deleted
#
function(user_data_clear)
  set(args ${ARGN})
  list_extract_flag(args --all)
  ans(all)
  set(id ${args})
  if(all)
    user_data_ids()
    ans(ids)
    foreach(id ${ids})
      user_data_clear("${id}")
    endforeach()
  endif()
  user_data_path("${id}")
  ans(res)
  if(EXISTS "${res}")
    rm("${res}")
    return(true)
  endif()
  return(false)
endfunction()
