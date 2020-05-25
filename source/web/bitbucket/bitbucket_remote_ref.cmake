function(bitbucket_remote_ref user repo ref_type ref)
    set(api_uri "https://bitbucket.org/api/1.0")
    http_get("${api_uri}/repositories/${user}/${repo}/changesets/${ref}" --silent-fail --json)
    ans(bitbucket_response)
    if(NOT bitbucket_response)
        return()
    endif()
    map_tryget(${bitbucket_response} raw_node)
    ans(commit)
    map_capture_new(user repo ref_type ref commit bitbucket_response)
    return_ans()
endfunction()
