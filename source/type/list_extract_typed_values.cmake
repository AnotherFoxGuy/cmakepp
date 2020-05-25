
function(list_extract_typed_values __lst)
    regex_cmake()
    string(REGEX MATCHALL "(^|;)<.*>($|;)" __letv_positionals "${ARGN}")
    string(REGEX MATCHALL "(^|;)\\[.*\\]($|;)" __letv_nonpositionals "${ARGN}")
    set(names)
    foreach(__letv_arg ${__letv_nonpositionals} ${__letv_positionals})
        list_extract_typed_value(${__lst} "${__letv_arg}" __letv_comment)
        ans_extract(__letv_name)
        ans(__letv_value)
        # print_vars(__letv_name __letv_value ${__lst})
        set("${__letv_name}"
            ${__letv_value}
            PARENT_SCOPE)
        list(APPEND names ${__letv_name})
        set("${__letv_name}_comment"
            "${__letv_comment}"
            PARENT_SCOPE)
    endforeach()
    set(__extracted_names
        ${names}
        PARENT_SCOPE)

    return_ref(${__lst})
endfunction()
