function(target_include_directories target)

    if(NOT COMMAND _target_include_directories)
        cmake_parse_arguments("" "SYSTEM;BEFORE;PUBLIC;INTERFACE;PRIVATE" "" "" ${ARGN})
        message(DEBUG "using fallback version of target_include_directories, consider upgrading to cmake >= 2.8.10")

        if(_SYSTEM
           OR _BEFORE
           OR _INTERFACE
           OR _PRIVATE)
            message(FATAL_ERROR "shim for target_include_directories does not support SYSTEM, PRIVATE, INTERFACE or BEFORE upgrade to cmake >= 2.8.10")
        endif()
        foreach(arg ${ARGN})
            if(TARGET "${arg}")
                get_property(
                    includes
                    TARGET ${arg}
                    PROPERTY INCLUDE_DIRECTORIES)
                set_property(
                    TARGET ${target}
                    APPEND
                    PROPERTY ${includes})
            else()
                message(FATAL_ERROR "shim version of target_include_directories only supports targets. upgrade cmake to >=2.8.10")
            endif()
        endforeach()
        return()
    else()
        # default implementation
        _target_include_directories(${target} ${ARGN})
    endif()
    event_emit(target_include_directories ${ARGN})

endfunction()
