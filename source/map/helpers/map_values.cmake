# returns all values of the map which are passed as ARNG
function(map_values this)
  set(args ${ARGN})
  if(NOT args)
    map_keys(${this})
    ans(args)
  endif()
  set(res)
  foreach(arg ${args})
    map_get(${this} ${arg})
    ans(val)
    list(APPEND res ${val})
  endforeach()
  return_ref(res)
endfunction()

# ## faster macro(map_values map) set(__ans ${ARGN}) if(NOT __ans)
# map_keys(${map}) endif() ## ____map_values_key does not conflict as it is the
# loop variable foreach(____map_values_key ${__ans}) map_tryget(${map}
# ${____map_values_key}) list(APPEND __map_values_result ${__ans}) endforeach()
# set(__ans ${__map_values_result}) endmacro()
