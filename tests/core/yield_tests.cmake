function(test)
  function(my_func)
    yield_begin()
    yield(1)
    yield(2)
    yield(3)
    yield(4)
    yield_return()
  endfunction()

  my_func()
  ans(res)
  assert(EQUALS 1 2 3 4 ${res})

endfunction()
