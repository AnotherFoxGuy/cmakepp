function(shell_path_get)
  shell_env_get(Path)
  ans(paths)
  set(paths2)
  foreach(path ${paths})
    file(TO_CMAKE_PATH path "${path}")
    list(APPEND paths2 "${path}")
  endforeach()
  return_ans(paths2)

endfunction()
