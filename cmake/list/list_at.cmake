function(list_at result lst idx)
	list(LENGTH ${lst} len)
	if(${idx} LESS 0)
		math(EXPR idx "${len} ${idx}")
	endif()
	list(GET ${lst} ${idx} value)
	set(${result} "${value}" PARENT_SCOPE)
endfunction()