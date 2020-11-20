# deserializes a csv string currently expects the first line to be the column
# headers rows are separated by \n or \r\n every value is delimited by double
# quoutes ""
function(csv_deserialize csv)
  set(args ${ARGN})
  list_extract_flag(args --headers)
  ans(first_line_headers)
  string(REPLACE "\r" "" csv "${csv}")

  string_split("${csv}" "\n")
  ans(lines)
  string(STRIP "${lines}" lines)

  set(res)
  set(headers)
  set(first true)
  set(i 0)
  foreach(line ${lines})
    map_new()
    ans(current_line)
    set(current_headers ${headers})
    while(true)
      string_take_delimited(line)
      ans(val)
      if("${line}_" STREQUAL "_")
        break()
      endif()

      string_take(line ",")
      ans(comma)

      if(first)
        if(first_line_headers)
          list(APPEND headers "${val}")
        else()
          list(APPEND headers ${i})
        endif()
        math(EXPR i "${i} + 1")
      else()
        list_pop_front(current_headers)
        ans(current_header)
        map_set(${current_line} "${current_header}" "${val}")
      endif()

    endwhile()
    if(NOT first)
      list(APPEND res ${current_line})
    elseif(NOT first_line_headers)
      list(APPEND res ${current_line})
    endif()
    if(first)
      set(first false)
    endif()

  endforeach()
  return_ref(res)
endfunction()
