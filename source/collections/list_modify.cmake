
function(list_modify __list_name)
    set(args ${ARGN})
    list_extract_flag(args --append)
    ans(append)
    list_extract_flag(args --remove)
    ans(remove)
    list_extract_flag(args --sort)
    ans(sort)
    list_extract_flag(args --set)
    ans(set)
    list_extract_flag(args --get)
    ans(get)
    list_extract_labelled_value(args --insert)
    ans(insert)
    list_extract_labelled_value(args --remove-at)
    ans(remove_at)
    list_extract_flag(args --remove-duplicates)
    ans(remove_duplicates)

    set(value ${${__list_name}})

    list(LENGTH value length)

    if(NOT "${insert}_" STREQUAL "_")
        list(INSERT value ${insert} ${args})
    elseif(set)
        set(value ${args})
    elseif(append)
        list(APPEND value ${args})
    elseif(remove)
        list(REMOVE_ITEM value ${args})
    elseif(NOT "${remove_at}_" STREQUAL "_")
        list(REMOVE_AT value ${remove_at})
    else()

    endif()

    if(length)
        if(remove_duplicates)
            list(REMOVE_DUPLICATES value)
        endif()
        if(sort)
            list(SORT value)
        endif()
    endif()

    set(${__list_name}
        ${value}
        PARENT_SCOPE)
endfunction()
