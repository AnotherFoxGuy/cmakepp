function(make_symbol)
    address_get(symbol_count)
    ans(i)
    if(NOT i)
        function(make_symbol)
            address_get(symbol_count)
            ans(i)
            math(EXPR i "${i} + 1")
            address_set(symbol_count "${i}")
            return("symbol_${i}_${symbol_cache_key}")
        endfunction()
        address_set(symbol_count 1)
        return(symbol_1)
    endif()
    message(FATAL_ERROR "make_symbol")
endfunction()
