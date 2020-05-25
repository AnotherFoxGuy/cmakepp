# evalutes the specified cmake code verbatim and prints it and its result
function(markdown_eval str)
    set(le_code "${str}")
    eval_ref(le_code)
    ans(result)
    set(result
        "${result}"
        PARENT_SCOPE)
    is_address("${result}")
    ans(is_address)
    if(is_address)
        json("${result}")
        ans(result)
    else()
        set(result "`${result}`")
    endif()
    template_out("${str} # => ${result}")
    return()
endfunction()
