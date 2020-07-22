## github_get_latest_release_tag() -> name of the tag
##
## returns the list of repositories for the specified user
function(github_get_latest_release_tag user repo)
    github_api("repos/${user}/${repo}/releases/latest" --response)
    ans(res)
    assign(error = res.client_status)
    if (error)
        return()
    endif ()
    assign(content = res.content)

    ## this is a quick way to get all full_name fields of the unparsed json
    ## parsing large json files would be much too slow
    json_extract_string_value(tag_name "${content}")
    return_ans()
endfunction()