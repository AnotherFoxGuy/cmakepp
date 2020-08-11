cmake_minimum_required(VERSION 3.2)
project(cmakepp VERSION 1.0 LANGUAGES NONE)

set(CMAKEPP_FILE "${CMAKE_SOURCE_DIR}/cmakepp.cmake")

include("${CMAKEPP_FILE}")

add_custom_target(
        compile
        COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_FILE} cmakepp_compile release/cmakepp.cmake
        VERBATIM
)

enable_testing()
glob("${CMAKE_SOURCE_DIR}/tests/**.cmake" --recurse)
ans(test_files)
foreach (test ${test_files})
    get_filename_component(test_name "${test}" NAME_WE)
    add_test(NAME "${test_name}"
            COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_FILE} test_execute ${test})
endforeach ()

install(FILES "${CMAKE_BINARY_DIR}/release/cmakepp.cmake" DESTINATION ${CMAKE_INSTALL_PREFIX}/cmakepp)

install(CODE [===[
    include("${CMAKE_INSTALL_PREFIX}/cmakepp/cmakepp.cmake")
    pushd("${CMAKE_INSTALL_PREFIX}/cmakepp/")
    cmake(-P cmakepp.cmake cmakepp_setup_environment)
    popd()
    message("Installed CMake++ to: ${CMAKE_INSTALL_PREFIX}/cmakepp/")
]===])

# CPack
set(CPACK_PACKAGE_DESCRIPTION "CMake++")
set(CPACK_PACKAGE_CONTACT "Edgar@AnotherFoxGuy.com")
set(CPACK_PACKAGE_VENDOR "AnotherFoxGuy")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set(CPACK_PACKAGE_EXECUTABLES "icmakepp" "icmakepp")

set(CPACK_PACKAGE_NAME "CMake++")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "cmakepp")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION}")
set(CPACK_GENERATOR ZIP)
set(CPACK_MODULE_PATH "")


include(CPack)