function(mime_type_get_extension mime_type)
  mime_type_get("${mime_type}")
  ans(mt)
  map_tryget("${mt}" extensions)
  ans(extensions)
  list_pop_front(extensions)
  ans(res)
  return_ref(res)

  return()
  if(mime_type STREQUAL "application/cmake")
    return("cmake")
  elseif(mime_type STREQUAL "application/json")
    return("json")
  elseif(mime_type STREQUAL "application/x-quickmap")
    return("qm")
  elseif(mime_type STREQUAL "application/x-gzip")
    return("tgz")
  elseif(mime_type STREQUAL "text/plain")
    return("txt")
  endif()

  return()
endfunction()
