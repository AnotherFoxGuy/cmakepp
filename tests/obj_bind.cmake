function(obj_bind_test)
	obj_create(obj)
	function(fufufuf result input)
		return_value("hello from fufufuf ${input}")
	endfunction()
	obj_bind(bound_function ${obj} fufufuf)
	assert(bound_function)
	assert(NOT res)
	call_function("${bound_function}" res "invalue" a b c)
	assert(res)
	assert(${res} STREQUAL "hello from fufufuf invalue")
endfunction()