# parses str into a linked list of tokens using token_definitions
function(tokens_parse token_definitions str)
  map_new()
  ans(first_token)
  set(last_token ${first_token})
  while(true)
    # recursion anker
    string_isempty("${str}")
    ans(isempty)
    if(isempty)
      map_tryget(${first_token} next)
      ans(first_token)
      return(${first_token})
    endif()

    set(token)
    set(ok)
    foreach(token_definition ${token_definitions})
      map_tryget(${token_definition} regex)
      ans(regex)
      # message("trying ${regex} with '${str}'") set(match)
      string(REGEX MATCH "^(${regex})" match "${str}")
      list(LENGTH match len)
      if("${len}" GREATER 0)
        map_tryget(${token_definition} except)
        ans(except)
        list(LENGTH except hasExcept)
        if(NOT hasExcept OR NOT "_${match}" MATCHES "_(${except})")

          # message(FORMAT "matched {token_definition.name}  match: '${match}'
          # ") message("stream ${str}")
          string(LENGTH "${match}" len)
          string(SUBSTRING "${str}" "${len}" -1 str)
          token_new(${token_definition} "${match}")
          ans(token)
          # message(FORMAT "token {token_definition.regex} matches ${match}")
          set(ok true)
          break()
        endif()
      endif()
    endforeach()

    if(NOT ok)
      # message("failed - not a token  @ ...${str}")
      return()
    endif()

    if(token)
      if(last_token)
        map_set(${last_token} next ${token})
      endif()
      set(last_token ${token})
    endif()
  endwhile()

endfunction()
