function(nohup)
    wrap_executable(nohup nohup)
    nohup(${ARGN})
    return_ans()
endfunction()
