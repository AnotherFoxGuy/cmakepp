function(promise_all)
  arguments_foreach(0 ${ARGC} promise)
  ans(promises)
  map_new()
  ans(accu)
  list(LENGTH promises count)
  task_anonymous("" ())
  ans(promise_all)
  promise("${promise_all}")
  ans(promise_all)
  foreach(promise ${promises})
    map_tryget("${promise}" task_queue)
    map_set("${promise_all}" task_queue "${__ans}")

    promise_then_anonymous(
      "${promise}"
      ()
      map_set
      (${accu} ${promise} \${ARGN})
      map_count
      (${accu})
      ans
      (count)
      if
      (\${count} EQUAL ${count})
      # this orders the keys in the correct order
      map_set_special
      ("${accu}" keys ${promises})
      map_values
      ("${accu}")
      ans
      (values)
      promise_resolve
      ("${promise_all}" "\${values}")
      endif
      ())

  endforeach()
  return_ref(promise_all)
endfunction()
