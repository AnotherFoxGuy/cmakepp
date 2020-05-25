function(config_function config_obj config_definition key)
    set(args ${ARGN})

    if (${key} STREQUAL "*")
        return(${config_obj})
    endif ()
    if (${key} STREQUAL "help")
        list_structure_print_help(${config_definition})
        return()
    endif ()
    if (${key} STREQUAL "print")
        json_print(${config_obj})
        return()
    endif ()
    if (${key} STREQUAL "set")
        list_pop_front(args)
        ans(key)
        map_set("${config_obj}" "${key}" ${args})
    endif ()
    map_get("${config_obj}" "${key}")
    return_ans()
endfunction()