function(test)

    semver_compare("1.0.0" "2.0.0")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("2.0.0" "2.1.0")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("2.1.0" "2.1.1")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-alpha" "1.0.0")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-alpha" "1.0.0")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-alpha" "1.0.0-alpha.1")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-alpha.1" "1.0.0-alpha.beta")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-alpha.beta" "1.0.0-beta")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-beta" "1.0.0-beta.2")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-beta.2" "1.0.0-beta.11")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-beta.1" "1.0.0-rc.11")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)
    semver_compare("1.0.0-rc.1" "1.0.0")
    ans(semver_compare)
    assert(${semver_compare} EQUAL 1)

endfunction()
