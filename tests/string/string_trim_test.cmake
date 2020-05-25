function(test)
    set(res "")
    # Whitespaces at beginning are removed
    set(input "  whitespaces")
    string_trim("${input}")
    ans(res)
    assert("${res}" STREQUAL "whitespaces")

    set(res "")
    # Whitespaces at the end are removed
    set(input "whitespaces  ")
    string_trim("${input}")
    ans(res)
    assert("${res}" STREQUAL "whitespaces")

    set(res "")
    # Whitespaces at beginning and end are removed
    set(input "  whitespaces  ")
    string_trim("${input}")
    ans(res)
    assert("${res}" STREQUAL "whitespaces")

    set(res "")
    # Whitespaces in the middle are kept (1/2)
    set(input "white  spaces")
    string_trim("${input}")
    ans(res)
    assert("${res}" STREQUAL "white  spaces")

    set(res "")
    # Whitespaces in the middle are kept (2/2)
    set(input "  white  spaces  ")
    string_trim("${input}")
    ans(res)
    assert("${res}" STREQUAL "white  spaces")

    set(res "")
    # Whitespaces only result in empty string (1/2)
    set(input " ")
    string_trim("${input}")
    ans(res)
    assert("${res}_" STREQUAL "_")

    set(res "")
    # Whitespaces only result in empty string (2/2)
    set(input "   ")
    string_trim("${input}")
    ans(res)
    assert("${res}_" STREQUAL "_")
endfunction()
