macro(arguments_expression_compile_cached type arguments argn start end)
  arguments_expression_parse_cached("${type}" "${arguments}" "${argn}"
                                    "${start}" "${end}")
  ans(ast)
  if(ast)
    map_tryget("${ast}" macro)
    ans(macro)
    if(NOT macro)
      ast_reduce_code("${ast}")
      ans(code)
      map_tryget("${ast}" value)
      ans(value)

      identifier(expr2)
      ans(identifier)

      set(macro
          "
                macro(${identifier})
                    ${code}
                    set(__ans ${value} PARENT_SCOPE)
                    set(__ans ${value})
                endmacro()
            ")
      eval("${macro}")
      map_set("${ast}" macro "${macro}")
      map_set("${ast}" macro_identifier "${identifier}")
    endif()
    set(__ans "${ast}")
  endif()
endmacro()
