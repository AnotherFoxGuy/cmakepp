
function(this_check)
	if(NOT this)
		message(FATAL_ERROR "could not find this reference")
	endif()
endfunction()