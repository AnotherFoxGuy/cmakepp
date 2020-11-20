#
function(function_signature_get func)
  function_lines_get("${func}")
  ans(lines)
  # function_signature_regex(regex)
  foreach(line ${lines})
    string(
      REGEX
        MATCH
        "^[ ]*([mM][aA][cC][rR][oO]|[fF][uU][nN][cC][tT][iI][oO][nN])[ ]*\\([ \n\r]*([A-Za-z0-9_\\\\-]*)(.+)\\)"
        found
        "${line}")
    if(found)
      return_ref(line)
    endif()
  endforeach()
  return()
endfunction()
