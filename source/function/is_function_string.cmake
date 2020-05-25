#returns true if the the string val is a function
function(is_function_string result val)
    if(NOT val)
        return_value(false)
    endif()
    # string(MD5 hash "${val}") set(hash "hash_${hash}") get_property(was_checked GLOBAL PROPERTY "${hash}") if(was_checked) return_value(${was_checked}) endif()

    string(REGEX MATCH ".*([mM][aA][cC][rR][oO]|[fF][uU][nN][cC][tT][iI][oO][nN])[ ]*\\(" function_found "${val}")
    if(NOT function_found)
        return_value(false)
    endif()
    # set_property(GLOBAL PROPERTY "${hash}" true)
    return_value(true)

endfunction()
