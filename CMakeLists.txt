cmake_minimum_required(VERSION 3.2)
project(
  cmakepp
  VERSION 1.0
  LANGUAGES NONE)

set(CMAKEPP_FILE "${CMAKE_SOURCE_DIR}/cmakepp.cmake")

include("${CMAKEPP_FILE}")

# ##############################################################################
# Test target
# ##############################################################################

option(FAST_TESTS "Use compiled CMake++ module in tests" OFF)

if(FAST_TESTS)
  set(CMAKEPP_TEST_FILE "${CMAKE_CURRENT_LIST_DIR}/tmp/cmakepp.cmake")
  execute_process(COMMAND ${CMAKE_COMMAND} -P ${CMAKE_SOURCE_DIR}/cmakepp.cmake
                          cmakepp_compile ${CMAKEPP_TEST_FILE})
  file(COPY "${CMAKE_SOURCE_DIR}/resources/expr-definition.json"
       DESTINATION "${CMAKE_CURRENT_LIST_DIR}/tmp/resources/")
else()
  set(CMAKEPP_TEST_FILE "${CMAKE_SOURCE_DIR}/cmakepp.cmake")
endif()

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
  add_test(NAME "${test_name}" COMMAND ${CMAKE_COMMAND} -P ${CMAKEPP_TEST_FILE}
                                       test_execute ${test})
endforeach()

# ##############################################################################
# Format target
# ##############################################################################
assign(cmakepp_files = glob ("${CMAKE_SOURCE_DIR}/source/**.cmake" --recurse))
assign(cmakepp_files[] = glob ("${CMAKE_SOURCE_DIR}/tests/**.cmake" --recurse))
set(tmp_dir "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/tmp")
file(MAKE_DIRECTORY ${tmp_dir})
foreach(file ${cmakepp_files})
  file(RELATIVE_PATH x "${CMAKE_SOURCE_DIR}" "${file}")
  string(REPLACE "/" "_" fake_file ${x})
  set(tfake_file "${tmp_dir}/${fake_file}")
  add_custom_command(
    COMMENT "Formating ${file}"
    OUTPUT ${tfake_file}
    DEPENDS ${file}
    COMMAND cmake-format -i ${file} || (exit 0)
    COMMAND ${CMAKE_COMMAND} -E touch ${tfake_file})
  list(APPEND format_files_list ${tfake_file})
endforeach()
set_source_files_properties(${format_files_list} SYMBOLIC TRUE)
add_custom_target(format DEPENDS ${format_files_list})

# ##############################################################################
# Install target
# ##############################################################################

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
