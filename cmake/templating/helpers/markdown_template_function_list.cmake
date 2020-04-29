function(markdown_template_function_list files)
    set(function_list)
    _message("XD ${files}")
    foreach (file ${files})
        cmake_script_parse_file(${file} --first-function-header)
        ans(function_def)

        assign(function_name = function_def.function_args[0])
        set(function_list "${function_list}\n* [${function_name}](#${function_name})")
    endforeach ()
    return_ref(function_list)
endfunction()