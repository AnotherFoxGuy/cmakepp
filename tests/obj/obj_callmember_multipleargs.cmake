function(test)
  function(TestClass)
    proto_declarefunction(test)
    function(${test})
      return("hello ${ARGN}")
    endfunction()
  endfunction()

  obj_new(TestClass)
  ans(uut)
  obj_member_call(${uut} test hello)
  ans(res)
  assert(res)
  assert(${res} STREQUAL "hello hello")
endfunction()
