function(obj_import obj)
    if(ARGN)
        foreach(arg ${ARGN})
            obj_get("${obj}" "${arg}")
            ans(val)
            set("${arg}"
                "${val}"
                PARENT_SCOPE)
        endforeach()
    endif()
    obj_keys("${obj}")
    ans(keys)
    foreach(key ${keys})
        obj_get("${obj}" "${key}")
        ans(val)
        set("${key}"
            "${val}"
            PARENT_SCOPE)
    endforeach()

endfunction()
