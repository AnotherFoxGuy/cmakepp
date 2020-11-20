function(ast_parse stream definition_id)

  # message_indent_push()
  if(ARGN)
    set(args ${ARGN})
    list_pop_front(args)
    ans(ast_language)

    map_get(${ast_language} parsers)
    ans(ast_parsers)
    map_get(${ast_language} definitions)
    ans(ast_definitions)
    function_import_table(${ast_parsers} __ast_call_parser)

    # json_print(${ast_definitions})
  else()
    if(NOT ast_language)
      message(FATAL_ERROR "missing ast_language")
    endif()
  endif()

  # map_get(${ast_language} parsers parsers)
  map_get("${ast_definitions}" "${definition_id}")
  ans(definition)

  map_tryget(${definition} node)
  ans(create_node)
  map_get(${definition} parser)
  ans(parser)
  map_get(${ast_parsers} "${parser}")
  ans(parser_command)
  map_tryget(${definition} peek)
  ans(peek)

  # message("trying to parse ${definition_id} with ${parser} parser")
  if(peek)
    token_stream_push(${stream})
  endif()
  # eval("${parser_command}(\"${definition}\" \"${stream}\"
  # \"${create_node}\")")

  __ast_call_parser("${parser}" "${definition}" "${stream}" "${create_node}")
  ans(node)
  if(peek)
    token_stream_pop(${stream})
  endif()

  # if(node) message(FORMAT "parsed {node.types}") else() message("failed to
  # parse ${definition_id}") endif() message_indent_pop()
  return_ref(node)
endfunction()
