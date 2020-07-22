function(test)
    github_repository_list("kkkkkkkkkkkkkkkkkkk")
    ans(res)
    assert(NOT res)

    set(full_name "RoRBot/test")
    set(default_branch "master")
    map_capture_new(full_name default_branch)
    ans(awns)

    github_repository_list("RoRBot")
    ans(res)
    assert(${res} MAP_MATCHES ${awns})

    github_get_latest_release_tag("RigsOfRods" "rigs-of-rods")
    ans(res)
    assert(${res} STREQUAL "2020.01")

endfunction()