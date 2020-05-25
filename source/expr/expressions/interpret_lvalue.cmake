function(interpret_lvalue tokens)
    set(exceptions)
    interpret_scope_lvalue("${tokens}")
    ans(ast)
    if(ast)
        return(${ast})
    endif()
    ans_append(exceptions)
    interpret_navigation_lvalue("${tokens}")
    ans(ast)
    if(ast)
        return(${ast})
    endif()
    ans_append(exceptions)

    throw("could not interpret lvalue" ${exceptions} --function interpret_lvalue)
endfunction()
