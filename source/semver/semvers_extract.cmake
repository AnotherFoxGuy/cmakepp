# extracts semvers from the input
function(semvers_extract)
    set(semver_regex "([0-9\\.]+(-[a-zA-Z0-9\\.-]*)?(\\+[a-zA-Z0-9\\.-]*)?)")
    string(REGEX MATCHALL "${semver_regex}" version_strings "${ARGN}")
    set(result)
    foreach(version_string ${version_strings})
        semver_parse_lazy("${version_string}")
        ans(semver)
        list(APPEND result "${semver}")
    endforeach()
    return_ref(result)
endfunction()
