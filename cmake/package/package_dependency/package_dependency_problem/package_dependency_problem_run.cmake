
function(package_dependency_problem_run package_graph root_handle)

  package_dependency_problem("${package_graph}" "${root_handle}" ${ARGN})
  ans(dependency_problem)


  package_dependency_problem_init("${dependency_problem}")  
  ans(success)
  if(NOT success)
    message(FATAL_ERROR "failed to initialize dependency_problem")
  endif()

  package_dependency_problem_solve("${dependency_problem}")
  ans(success)
  if(NOT success)
    message(FATAL_ERROR "failed to solve dependency_problem")
  endif()

  package_dependency_problem_complete("${dependency_problem}")
  ans(success)
  if(NOT success)
    message(FATAL_ERROR "failed to complete dependency_problem")
  endif()

  return_ref(dependency_problem)

endfunction()