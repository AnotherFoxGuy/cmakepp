# executes a handler
function(handler_execute handler request)
    request_handler(${handler})
    ans(handler)
    data(${request})
    ans(request)
    data(${ARGN})
    ans(response)
    if(NOT response)
        data("{output:''}")
        ans(reponse)
    endif()
    assign(!response.request = request)
    if(NOT handler)
        assign(!response.error = 'handler_invalid')
        assign(!response.message = "'handler was not valid'")
    else()
        assign(!response.handler = handler)
        map_tryget(${handler} callable)
        ans(callback)
        call("${callback}" ("${request}" "${response}"))
        ans(result)
    endif()
    return_ref(response)
endfunction()
