# returns a list of prototypes for ${this}
function(obj_gethierarchy this)
    set(current ${this})
    set(types)
    while(current)
        obj_gettype(${current})
        ans(type)
        if(type)
            list(APPEND types ${type})
        endif()
        obj_getprototype(${current})
        ans(proto)
        set(current ${proto})
    endwhile()

    return_ref(types)
endfunction()
