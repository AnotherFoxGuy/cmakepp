#inherits from base (if base is an objct it will be set as the prototype of this)
# if base is a function / constructor then a base object will be constructed and set
# as the prototy of this
function(this_inherit baseType)
    obj_type_get(${baseType})
    ans(base)
    obj_getprototype(${this})
    ans(prototype)
    obj_setprototype(${prototype} ${base})
    map_get_special(${base} constructor)
    ans(super)
    function_import("${super}" as base_constructor REDEFINE)
    clr()
    set(__current_constructor "${super}")
    obj_setprototype(${this} ${base})
    base_constructor(${ARGN})
    obj_setprototype(${this} ${prototype})
    ans(instance)
    if(instance)
        set(this
            "${instance}"
            PARENT_SCOPE)
    endif()
endfunction()
