## can be used as a standalone file to get a working copy of cmakepp
function(cmakepp_require)
	set(installation_dir ${ARGN})
	set(cmakepp_include "${installation_dir}/cmakepp.cmake")
	
	if ("${installation_dir}_" STREQUAL "_")
		set(installation_dir "${CMAKE_BINARY_DIR}/cmakepp")
	endif ()

	## prefer local verison
	if (EXISTS "${cmakepp_include}")
		message(STATUS "Using CMake++ from local installation")
		include("${cmakepp_include}")
		return()
	endif ()

	## prefer version
	if (EXISTS "$ENV{CMAKEPP_PATH}")
		message(STATUS "Using CMake++ from path")
		include("$ENV{CMAKEPP_PATH}")
		return()
	endif ()

	## download cmakepp
	set(git_uri "https://github.com/AnotherFoxGuy/cmakepp")
	set(cmakepp_uri "${git_uri}/releases/download/v0.0.3/cmakepp.cmake")

	message(STATUS "Downloading CMake++")
	
	file(DOWNLOAD "${cmakepp_uri}" "${cmakepp_include}" STATUS status)
	include("${cmakepp_include}")
endfunction()