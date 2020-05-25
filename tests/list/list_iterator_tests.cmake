function(test)

    set(lstA)
    list_iterator(lstA)
    ans(it)
    list_iterator_next(it)
    ans(res)
    assert(NOT res)
    assert(${it} EQUALS lstA 0 0)

    set(lstA a b c)
    # create iterator
    list_iterator(lstA)
    ans(it)

    # advance to first
    list_iterator_next(it)
    ans(res)
    assert(res)
    assert(${it.length} EQUAL 3)
    assert(${it.value} STREQUAL a)
    assert(${it.list_ref} STREQUAL lstA)
    assert(${it.index} EQUAL 0)

    list_iterator_next(it)
    ans(res)
    assert(res)
    assert(${it.length} EQUAL 3)
    assert(${it.value} STREQUAL b)
    assert(${it.list_ref} STREQUAL lstA)
    assert(${it.index} EQUAL 1)

    list_iterator_next(it)
    ans(res)
    assert(res)
    assert(${it.length} EQUAL 3)
    assert(${it.value} STREQUAL c)
    assert(${it.list_ref} STREQUAL lstA)
    assert(${it.index} EQUAL 2)

    list_iterator_next(it)
    ans(res)
    assert(NOT res)
    assert(${it.length} EQUAL 3)
    assert(${it.value} ISNULL)
    assert(${it.list_ref} STREQUAL lstA)
    assert(${it.index} EQUAL 3)

    set(lstA a b c)
    list_iterator(lstA)
    ans(it)
    set(res)
    list_iterator(lstA)
    ans(it)
    while(true)
        list_iterator_break(it)
        list(APPEND res ${it.index} ${it.value})
    endwhile()

    assert(
        ${res}
        EQUALS
        0
        a
        1
        b
        2
        c)

endfunction()
