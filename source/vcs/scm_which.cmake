
## `(<path=".">)->"git"|"svn"|"hg"|<null>`
##
## returns the scm found `"git"|"svn"|"hg"` in specified directory
function(scm_which)
    #message(FATAL_ERROR notimplemented)
    path("${ARGN}")
    ans(path)
    pushd("${path}")
    git(status --exit-code)
    ans(error)
    if (NOT error)
        popd()
        return(git)
    endif ()
    hg(status --exit-code)
    ans(error)
    if (NOT error)
        popd()
        return(hg)
    endif ()
    popd()
    return()
endfunction()