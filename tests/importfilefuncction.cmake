function(test)
	set(funcfile "${cutil_temp_dir}/tests/importfiletest.cmake")
	file(REMOVE "${cutil_temp_dir}/tests")
	file(WRITE ${funcfile} "function(myfu123unique) \n endfunction()")

	assert(NOT COMMAND thistestfunction)
	assert(NOT COMMAND myfu123unique)
	import_function(${funcfile} as thistestfunction)
	assert(COMMAND thistestfunction)
	assert(NOT COMMAND myfu123unique)
	
endfunction()