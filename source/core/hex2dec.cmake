function(hex2dec str)
  string(LENGTH "${str}" len)

  if("${len}" LESS 1)

  elseif(${len} EQUAL 1)
    if(${str} MATCHES "[0-9]")
      return("${str}")
    elseif(${str} MATCHES "[aA]")
      return(10)
    elseif(${str} MATCHES "[bB]")
      return(11)
    elseif(${str} MATCHES "[cC]")
      return(12)
    elseif(${str} MATCHES "[dD]")
      return(13)
    elseif(${str} MATCHES "[eE]")
      return(14)
    elseif(${str} MATCHES "[fF]")
      return(15)
    else()
      # invalid character
      return()
    endif()
  else()
    math(EXPR len "${len} - 1")
    set(result 0)

    foreach(i RANGE 0 ${len})
      string_char_at(${str} "${i}")
      ans(c)
      hex2dec("${c}")
      ans(c)

      if("${c}_" STREQUAL "_")
        # illegal char
        return()
      endif()

      math(EXPR result "${result} + (2 << ((${len}-${i})*4)) * ${c}")
    endforeach()

    math(EXPR result "${result} >> 1")
    return(${result})

  endif()
  return()
endfunction()
