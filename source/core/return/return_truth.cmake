macro(return_truth)
    if(${ARGN})
        return(true)
    endif()
    return(false)
endmacro()
