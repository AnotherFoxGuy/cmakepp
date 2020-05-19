## cmakepp_compile()
##
## compiles cmakepp into a single file which is faster to include
function(cmakepp_compile target_file)
    path_qualify(target_file)
    cmakepp_config(base_dir)
    ans(base_dir)

    file(STRINGS "${base_dir}/cmakepp.cmake" cmakepp_main_file)

    file(WRITE "${target_file}" "##  CMake++ Compiled module\n\n")

    foreach (line ${cmakepp_main_file})
        if ("_${line}" STREQUAL "_include(\"\${cmakepp_base_dir}/cmake/core/require.cmake\")" OR
                "_${line}" STREQUAL "_include(\"\${cmakepp_base_dir}/cmake/type/parameter_definition.cmake\")")
        elseif ("_${line}" STREQUAL "_require(\"\${cmakepp_base_dir}/cmake/*.cmake\")")
            file(GLOB_RECURSE files "${base_dir}/cmake/**.cmake")
            foreach (file ${files})
                file(READ "${file}" content)
                file(RELATIVE_PATH rel_path "${base_dir}" "${file}")
                file(APPEND "${target_file}" "\n# File: ${rel_path}\n\n${content}\n")
            endforeach ()
        elseif ("_${line}" STREQUAL "_include(\"\${cmakepp_base_dir}/cmake/task/task_enqueue.cmake\")")
            file(READ "${base_dir}/cmake/task/task_enqueue.cmake" content)
            file(APPEND "${target_file}" "\n\n\n${content}\n\n")
        else ()
            file(APPEND "${target_file}" "${line}\n")
        endif ()
    endforeach ()
endfunction()
