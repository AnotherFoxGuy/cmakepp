function(check_function func)
    is_function(res "${func}")
    if(NOT res)
        message(FATAL_ERROR "expected a function instead got: '${func}'")
    endif()
endfunction()
