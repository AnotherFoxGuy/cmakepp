function(obj_type_get type)
  if(NOT COMMAND ${type})
    message(
      FATAL_ERROR
        "obj_new: only cmake functions are allowed as types, '${type}' is not function"
    )
  endif()
  set(base)
  # get_property(base GLOBAL PROPERTY "type_${type}")
  if(NOT base)
    map_new()
    ans(base)
    set_property(GLOBAL PROPERTY "type_${type}" "${base}")
    map_set_special("${base}" constructor "${type}")
  endif()
  return_ref(base)
endfunction()
