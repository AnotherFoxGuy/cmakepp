function(map_clone_deep original)
  map_clone_shallow("${original}")
  ans(result)

  is_map("${result}")
  ans(ismap)
  if(ismap)
    map_keys("${result}")
    ans(keys)
    foreach(key ${keys})
      map_get(${result} ${key})
      ans(value)
      map_clone_deep("${value}")
      ans(cloned_value)
      map_set(${result} ${key} ${cloned_value})
    endforeach()
  endif()
  return_ref(result)
endfunction()
