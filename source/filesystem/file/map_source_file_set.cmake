function(map_source_file_set map file_name)
    is_map("${map}")
    ans(is_map)
    if(is_map)
        path_qualify(file_name)
        map_set_hidden("${map}" $map_source_file "${file_name}")
        return("${file_name}")
    endif()
    return()
endfunction()
