

  function(memory_cache_exists cache_key)
    memory_cache_key("${cache_key}")
    ans(key)
    map_tryget(memory_cache_entries "${key}")
    ans(entry)
    if(entry)
      return(true)
    endif()
    return(false)
  endfunction()