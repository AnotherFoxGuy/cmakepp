function(map_issubsetof result superset subset)
    map_keys(${subset})
    ans(keys)
    foreach(key ${keys})
        map_tryget(${superset} ${key})
        ans(superValue)
        map_tryget(${subset} ${key})
        ans(subValue)

        is_map(${superValue})
        ans(issupermap)
        is_map(${subValue})
        ans(issubmap)
        if(issubmap AND issubmap)
            map_issubsetof(res ${superValue} ${subValue})
            if(NOT res)
                return_value(false)
            endif()
        else()
            list_isvalid(${superValue})
            ans(islistsuper)
            list_isvalid(${subValue})
            ans(islistsub)
            if(islistsub AND islistsuper)
                address_get(${superValue})
                ans(superValue)
                address_get(${subValue})
                ans(subValue)
            endif()
            list_equal("${superValue}" "${subValue}")
            ans(res)
            if(NOT res)
                return_value(false)
            endif()
        endif()
    endforeach()
    return_value(true)
endfunction()
