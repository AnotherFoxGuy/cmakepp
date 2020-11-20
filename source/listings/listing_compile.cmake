function(listing_compile listing)
  address_get("${listing}")
  ans(code)
  set(indent_on
      while
      if
      function
      foreach
      macro
      else
      elseif)
  set(unindent_on
      endwhile
      endif
      endfunction
      endforeach
      endmacro
      else
      elseif)
  set(current_indentation "")
  set(indented)

  foreach(line ${code})
    string(STRIP "${line}" line)
    string_take_regex(line "[^\\(]+")
    ans(func_name)
    if(func_name)
      list_contains(unindent_on ${func_name})
      ans(unindent)
      if(unindent)
        string_take(current_indentation "  ")
      endif()
      set(line "${current_indentation}${func_name}${line}")
      list_contains(indent_on ${func_name})
      ans(indent)
      if(indent)
        set(current_indentation "${current_indentation}  ")

      endif()
    endif()
    list(APPEND indented "${line}")
  endforeach()
  string(REPLACE ";" "\n" code "${indented}")
  string_decode_semicolon("${code}")
  ans(code)
  string(REPLACE "'" "\"" code "${code}")
  string(REGEX REPLACE "([^$]){([a-zA-Z0-9\\-_\\.]+)}" "\\1\${\\2}" code
                       "${code}")
  return_ref(code)
endfunction()
