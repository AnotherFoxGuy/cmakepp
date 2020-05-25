function(test)

    stack_new()
    ans(stack)
    stack_isempty(${stack})
    ans(res)
    assert(res)

    stack_push(${stack} "")
    stack_isempty(${stack})
    ans(res)
    assert(NOT res)
    stack_push(${stack} "a")
    stack_push(${stack} "")
    stack_push(${stack} "b")
    stack_pop(${stack})
    ans(res)
    assert("${res}" STREQUAL "b")
    stack_pop(${stack})
    ans(res)
    assert("${res}_" STREQUAL "_")
    stack_pop(${stack})
    ans(res)
    assert("${res}" STREQUAL "a")
    stack_pop(${stack})
    ans(res)
    assert("${res}_" STREQUAL "_")
    stack_pop(${stack})
    ans(res)
    assert("${res}_" STREQUAL "_")
    stack_isempty(${stack})
    ans(res)
    assert(res)

    stack_at(${stack} 3)
    ans(res)
    assert(NOT res)

    stack_at(${stack} 0)
    ans(res)
    assert(NOT res)

    stack_push(${stack} abc)
    stack_at(${stack} 0)
    ans(res)
    assert("${res}" STREQUAL "abc")

    stack_at(${stack} 1)
    ans(res)
    assert(NOT res)

    stack_push(${stack} def)

    stack_enumerate(${stack})
    ans(elements)
    assert(EQUALS abc def ${elements})

    stack_pop(${stack})
    stack_enumerate(${stack})
    ans(elements)
    assert(EQUALS abc ${elements})

    stack_pop(${stack})
    stack_enumerate(${stack})
    ans(elements)
    assert(NOT elements)

endfunction()
