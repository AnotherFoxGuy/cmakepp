function(test)
    set(res "")
    # Whitespaces at beginning are removed
    set(input "  whitespaces")
    string_take_whitespace(input)
    ans(res)
    assert("${res}" STREQUAL "  ")
    assert("${input}" STREQUAL "whitespaces")

    set(res "")
    # Whitespaces at the end are not removed
    set(input "whitespaces  ")
    string_take_whitespace(input)
    ans(res)
    assert("${res}_" STREQUAL "_")
    assert("${input}" STREQUAL "whitespaces  ")

    set(res "")
    # Whitespaces only at beginning are removed
    set(input "  whitespaces  ")
    string_take_whitespace(input)
    ans(res)
    assert("${res}" STREQUAL "  ")
    assert("${input}" STREQUAL "whitespaces  ")

    set(res "")
    # Whitespaces in the middle are kept (1/2)
    set(input "white  spaces")
    string_take_whitespace(input)
    ans(res)
    assert("${res}_" STREQUAL "_")
    assert("${input}" STREQUAL "white  spaces")

    set(res "")
    # Whitespaces in the middle are kept (2/2)
    set(input "  white  spaces")
    string_take_whitespace(input)
    ans(res)
    assert("${res}" STREQUAL "  ")
    assert("${input}" STREQUAL "white  spaces")

    set(res "")
    # Whitespaces only result in empty string "input" (1/2)
    set(input " ")
    string_take_whitespace(input)
    ans(res)
    assert("${res}" STREQUAL " ")
    assert("${input}_" STREQUAL "_")

    set(res "")
    # Whitespaces only result in empty string "input" (2/2)
    set(input "   ")
    string_take_whitespace(input)
    ans(res)
    assert("${res}" STREQUAL "   ")
    assert("${input}_" STREQUAL "_")
endfunction()
