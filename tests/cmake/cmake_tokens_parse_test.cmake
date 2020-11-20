function(test)
  set(exception "{'__$type__':'exception'}")

  function(test_cmake_parse_identity str)
    timer_start(cmake_tokens_parse)
    cmake_tokens_parse("${str}" --extended)
    ans_extract(first)
    map_new()
    ans(root)
    map_set(${root} next ${first})
    # json_print(${root})
    timer_elapsed(cmake_tokens_parse)
    ans(parse_time)

    map_tryget(${root} children)
    ans(children)
    list(LENGTH children length)

    timer_start(cmake_tokens_parse)
    cmake_token_range_serialize("${root}")
    ans(res)
    timer_elapsed(cmake_tokens_parse)
    ans(unparse_time)
    message(
      "took ${parse_time} ms to parse and ${unparse_time} ms to unparse ${length} tokens"
    )
    assert("${res}" EQUALS "${str}")
  endfunction()

  function(test_cmake_parse str)
    timer_start(cmake_tokens_parse)
    cmake_tokens_parse("${str}" --extended)
    ans_extract(first)
    timer_print_elapsed(cmake_tokens_parse)
    map_new()
    ans(root)
    map_set(${root} next ${first})
    return_ref(root)
  endfunction()

  define_test_function(test_uut test_cmake_parse str)
  test_uut("{next:{value:'asd', type:'command_invocation'}}" "asd ()")
  test_uut("{next:{type:'nesting'}}" "()")
  test_uut("{next:{value:'\n', type:'new_line'}}" "\n")
  test_uut("{next:{value:'  ', type:'white_space'}}" "  ")
  test_uut("{next:{value:'(', type:'nesting',next:{type:'nesting_end'}}}" "()")
  test_uut("{next:{value:'(', type:'nesting'}}" "(())")
  test_uut("{next:{value:'#[[asd]]',type:'bracket_comment'}}" "#[[asd]]")
  test_uut("{next:{type:'eof'}}" "")
  test_uut("{next:{value:'asd', type:'command_invocation'}}" "asd()")
  test_uut("{next:{value:'asd', type:'unquoted_argument'}}" "asd")
  test_uut("{next:{value:'asd', type:'unquoted_argument'}}" "asd ")
  test_uut("{next:{type:'quoted_argument',literal_value:'asd'}}" "\"asd\"")
  test_uut("{next:{type:'white_space',value:' '}}" " ")
  test_uut("{next:{type:'line_comment',value:'#', literal_value:''}}" "#")
  test_uut(
    "{next:{type:'line_comment',value:'# hello ', literal_value:' hello '}}"
    "# hello \nbsd")
  test_uut(
    "{next:{type:'command_invocation',next:{type:'nesting',next:{type:'unquoted_argument',next:{type:'new_line', next:{type:'unquoted_argument',next:{type:'nesting_end',next:{type:'eof'}}}}}}}}"
    "set(source\nfile)")
  # return() test_uut("{next:{value:'\"asd\"',literal_value:'asd',
  # type:'quoted_argument'}}" "\"asd\"")
  test_cmake_parse_identity("#asdasd")
  test_cmake_parse_identity(";")
  test_cmake_parse_identity("asd;bsd")
  # test_cmake_parse_identity("asd\\ bsd")

  test_cmake_parse_identity("\"asd;bsd\"")
  test_cmake_parse_identity("asd")
  test_cmake_parse_identity("asd \"bsd\"")
  test_cmake_parse_identity("asd \"bsd\" (dadda)")

  test_cmake_parse_identity("set(asd bsd)")
  test_cmake_parse_identity("")
  test_cmake_parse_identity("set(asd bsd)")
  test_cmake_parse_identity(
    "if(asd AND (BSD STREQUAL sd))\nset(asd ansdnasd)\nendif()")
  test_cmake_parse_identity("set(asd (asd (kdkd) asd) bsd)")
  test_cmake_parse_identity("set(\"asd\")")
  test_cmake_parse_identity("set(\"asd\" )")
  test_cmake_parse_identity("set(\"asd\" ) ")
  test_cmake_parse_identity(" set( \"as d\" ) ")
  test_cmake_parse_identity(" set( \"as d\" ) ")
  test_cmake_parse_identity(
    " set(
    \"as
   d\"
   )
    ")

endfunction()
