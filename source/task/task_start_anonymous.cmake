function(task_start_anonymous arguments)
  arguments_anonymous_function(1 ${ARGC})
  ans(function_name)
  task_new("${function_name}" ${arguments})
  ans(task)
  task_start("${task}")
  return_ref(task)
endfunction()
