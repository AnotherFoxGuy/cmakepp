function(list_select_property __lst __prop)
    set(__result)
    foreach(__itm ${${__lst}})
        map_tryget("${__itm}" "${__prop}")
        ans(__res)
        list(APPEND __result "${__res}")
    endforeach()
    return_ref(__result)
endfunction()
