function(this_declare_call out_function_name)
  function_new()
  ans(callfunc)
  map_set_special("${this}" call "${callfunc}")
  set(${out_function_name}
      ${callfunc}
      PARENT_SCOPE)
endfunction()
