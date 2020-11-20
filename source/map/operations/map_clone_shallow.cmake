function(map_clone_shallow original)
  is_map("${original}")
  ans(ismap)
  if(ismap)
    map_new()
    ans(result)
    map_keys("${original}")
    ans(keys)
    foreach(key ${keys})
      map_get("${original}" "${key}")
      ans(value)
      map_set("${result}" "${key}" "${value}")
    endforeach()
    return(${result})
  endif()

  is_address("${original}")
  ans(isref)
  if(isref)
    address_get(${original})
    ans(res)
    address_type_get(${original})
    ans(type)
    address_new(${type})
    ans(result)
    address_set(${result} ${res})
    return(${result})
  endif()

  # everythign else is a value type and can be returned
  return_ref(original)

endfunction()
