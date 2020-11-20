# cmakepp_compile()
#
# compiles cmakepp into a single file which is faster to include
function(cmakepp_compile target_file)
  path_qualify(target_file)
  cmakepp_config(base_dir)
  ans(base_dir)

  file(STRINGS "${base_dir}/cmakepp.cmake" cmakepp_main_file)

  file(WRITE "${target_file}" "##  CMake++ Compiled module\n\n")

  foreach(line ${cmakepp_main_file})
    if("_${line}" STREQUAL
       "_include(\"\${cmakepp_base_dir}/source/core/require.cmake\")")

    elseif(
      "_${line}"
      STREQUAL
      "_include(\"\${cmakepp_base_dir}/source/type/parameter_definition.cmake\")"
    )
      file(READ "${base_dir}/source/type/parameter_definition.cmake" content)
      file(APPEND "${target_file}" "\n\n\n${content}\n\n")
    elseif("_${line}" STREQUAL
           "_require(\"\${cmakepp_base_dir}/source/*.cmake\")")
      file(GLOB_RECURSE files "${base_dir}/source/**.cmake")
      foreach(file ${files})
        file(READ "${file}" content)
        file(RELATIVE_PATH rel_path "${base_dir}" "${file}")
        file(APPEND "${target_file}" "\n# File: ${rel_path}\n\n${content}\n")
      endforeach()
    elseif("_${line}" STREQUAL
           "_include(\"\${cmakepp_base_dir}/source/task/task_enqueue.cmake\")")
      file(READ "${base_dir}/source/task/task_enqueue.cmake" content)
      file(APPEND "${target_file}" "\n\n\n${content}\n\n")
    else()
      file(APPEND "${target_file}" "${line}\n")
    endif()
  endforeach()
  message("Building ${target_file} done")
endfunction()
