function(global_config key)
  map_get(global "${key}")
  ans(res)
  set("${key}"
      "${res}"
      PARENT_SCOPE)
  return_ref(res)
endfunction()
