# (["[" <capture vars> "]"] <callable> "(" (<argument>|<assignment>)* ")" ["=>"
# <?func_name>(<arg names>)  ])->
#

function(curry_compile_encoded_list out_func)
  set(arguments ${ARGN})
  string_codes()
  set(regex_evaluates_to "=>")
  if("${arguments}" MATCHES "(.*);?${regex_evaluates_to};(.*)")
    set(definition "${CMAKE_MATCH_1}")
    set(invocation "${CMAKE_MATCH_2}")
  else()
    set(invocation "${arguments}")
    set(definition)
  endif()

  list_peek_front(invocation)
  ans(invocation_capture)

  if("${invocation_capture}" MATCHES
     "^${bracket_open_code}(.*)${bracket_close_code}$")
    string_decode_list("${CMAKE_MATCH_1}")
    ans(invocation_capture)
    list_pop_front(invocation)
  else()
    set(invocation_capture)
  endif()

  set(capture_code)
  foreach(capture ${invocation_capture})
    # todo capture by value
    set(capture_code "${capture_code}\n  set(${capture} \"${${capture}}\")")
  endforeach()

  regex_cmake()

  list_pop_front(invocation)
  ans(callable)

  string_decode_list("${callable}")
  ans(callable)

  function_import("${callable}")
  ans(invocation_name)

  set(invocation "${invocation_name};${invocation}")
  if("${invocation}" MATCHES "^(${regex_cmake_identifier});\\(;(.*);\\)")
    set(invocation_name "${CMAKE_MATCH_1}")
    set(invocation_args "${CMAKE_MATCH_2}")
  elseif("${invocation}" MATCHES "^(${regex_cmake_identifier})")
    set(invocation_name "${CMAKE_MATCH_1}")
    set(invocation_args "/*")
  endif()

  if("${definition}" MATCHES "^(${regex_cmake_identifier});\\(;?(.*);\\)")
    set(definition_name "${CMAKE_MATCH_1}")
    set(definition_args "${CMAKE_MATCH_2}")
  elseif("${definition}" MATCHES "^(${regex_cmake_identifier});?$")
    set(definition_name "${CMAKE_MATCH_1}")
    set(definition_args)
  elseif("${definition}" MATCHES "^\;?\\(;?(.*);\\)")
    set(definition_name)
    set(definition_args "${CMAKE_MATCH_1}")
  endif()

  if(NOT definition_name)
    function_new()
    ans(definition_name)
  endif()

  map_new()
  ans(assignments)

  set(arg_counter 0)
  set(arg_name_prefix __arg_)
  set(input_args)

  foreach(argument ${definition_args})
    string_decode_list("${argument}")
    ans(argument)
    set(argument_name "__${argument}")
    map_set(${assignments} ${argument} "${argument_name}")
    set(input_args "${input_args} ${argument_name}")
  endforeach()

  set(regex_arg_replacement "\\/(${regex_cmake_identifier}|\\*)")
  set(regex_pos_replacement "\\/(0|([1-9][0-9]*))")
  set(output_args)
  foreach(argument ${invocation_args})
    string_decode_list("${argument}")
    ans(argument)
    if("${argument}" MATCHES "^${regex_pos_replacement}$")
      set(argument_id "${CMAKE_MATCH_1}")
      set(argument_out "\${ARGV${argument_id}}")
    elseif("${argument}" MATCHES "^${regex_arg_replacement}$")
      set(argument_id "${CMAKE_MATCH_1}")
      if("${argument_id}" STREQUAL "*")
        set(argument_out "\${ARGN}")
      else()
        map_tryget("${assignments}" "${argument_id}")
        ans(argument_out)
        set(argument_out "\${${argument_out}}")
      endif()
    else()
      argument_escape("${argument}")
      ans(argument_out)
    endif()
    set(output_args "${output_args} ${argument_out}")
  endforeach()
  if(NOT "${output_args}_" STREQUAL "_")
    string(SUBSTRING "${output_args}" 1 -1 output_args)
  endif()
  if(NOT "${input_args}_" STREQUAL "_")
    string(SUBSTRING "${input_args}" 1 -1 input_args)
  endif()

  set(code
      "function(${definition_name} ${input_args})${capture_code}\n  ${invocation_name}(${output_args})\n  return_ans()\nendfunction()"
  )
  set(${out_func}
      "${definition_name}"
      PARENT_SCOPE)
  return_ref(code)

endfunction()

#
function(curry_compile)
  arguments_encoded_list(0 ${ARGC})
  ans(arguments)
  curry_compile_encoded_list(__outfunc "${arguments}")
  return_ans()
endfunction()

#
function(curry3)
  arguments_encoded_list(0 ${ARGC})
  ans(arguments)
  curry_compile_encoded_list(__outfunc "${arguments}")
  ans(code)
  eval("${code}")
  return_ref(__outfunc)
endfunction()
