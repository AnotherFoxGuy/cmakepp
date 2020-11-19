cmake_minimum_required(VERSION 3.2)
project(
  cmakepp
  VERSION 1.0
  LANGUAGES NONE)

option(FAST_TESTS "Use compiled CMake++ module in tests" OFF)

if(FAST_TESTS)
  set(CMAKEPP_FILE "${CMAKE_CURRENT_LIST_DIR}/tmp/cmakepp.cmake")
  execute_process(COMMAND ${CMAKE_COMMAND} -P ${CMAKE_SOURCE_DIR}/cmakepp.cmake
                          cmakepp_compile ${CMAKEPP_FILE})
  file(COPY "${CMAKE_SOURCE_DIR}/resources/expr-definition.json"
       DESTINATION "${CMAKE_CURRENT_LIST_DIR}/tmp/resources/")
else()
  set(CMAKEPP_FILE "${CMAKE_SOURCE_DIR}/cmakepp.cmake")
endif()

include("${CMAKEPP_FILE}")

add_custom_target(
  compile ALL
  COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_FILE} cmakepp_compile
          release/cmakepp.cmake
  VERBATIM)

add_custom_target(
  compile_docs
  COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_FILE} cmakepp_compile_docs
  VERBATIM)

enable_testing()
glob("${CMAKE_SOURCE_DIR}/tests/**.cmake" --recurse)
ans(test_files)
foreach(test ${test_files})
  get_filename_component(test_name "${test}" NAME_WE)
  add_test(NAME "${test_name}" COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_FILE}
                                       test_execute ${test})
endforeach()

glob("${CMAKE_SOURCE_DIR}/source/**.cmake" --recurse)
ans(csource_files)
foreach(file ${csource_files})
  add_custom_command(OUTPUT ${file} COMMAND cmake-format -i ${file})
  list(APPEND format_files_list ${file})
endforeach()

add_custom_target(format DEPENDS ${format_files_list})

install(FILES "${CMAKE_BINARY_DIR}/release/cmakepp.cmake"
        DESTINATION ${CMAKE_INSTALL_PREFIX}/cmakepp)

install(
  CODE [===[
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
