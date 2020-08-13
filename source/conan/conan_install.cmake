# Get Conan in a new virtualenv using the Python interpreter specified by the
# package of the `python_pkg` arg (Python3 or Python2)
function(conan_install)
    find_package(Python3 COMPONENTS Interpreter)

    if (NOT Python_FOUND)
        message(FATAL_ERROR "Python3 not found!")
    endif ()

    wrap_executable_bare(python "${Python_EXECUTABLE}")

    # Now create a new virtualenv
    file(REMOVE_RECURSE "${_PMM_CONAN_VENV_DIR}")
    _pmm_log("${msg} - Create virtualenv")
    python(-m venv "${_PMM_CONAN_VENV_DIR}")
    ans_extract(error)
    if (error)
        ans_extract(stdout)
        message(FATAL_ERROR "Error while trying to create virtualenv [${error}]:\n${stdout}")
    endif ()
    _pmm_log(VERBOSE "Created Conan virtualenv in ${_PMM_CONAN_VENV_DIR}")

    # Get the Python installed therein
    unset(_venv_py CACHE)
    find_program(_venv_py
            NAMES python
            NO_DEFAULT_PATH
            PATHS "${_PMM_CONAN_VENV_DIR}"
            PATH_SUFFIXES bin Scripts
            )
    set(venv_py "${_venv_py}")
    unset(_venv_py CACHE)

    # Upgrade pip installation
    _pmm_log("${msg} - Upgrade Pip")
    _pmm_exec("${venv_py}" -m pip install -qU pip setuptools)
    if (_PMM_RC)
        _pmm_log(WARNING "Failed while upgrading Pip in the virtualenv [${_PMM_RC}]:\n${_PMM_OUTPUT}")
        _pmm_log("${msg} - Fail: Pip could not be upgraded")
        return()
    endif ()

    # Finally, install Conan inside the virtualenv.
    _pmm_log("${msg} - Install Conan")
    _pmm_exec("${venv_py}" -m pip install -q conan<${PMM_CONAN_MAX_VERSION})
    if (_PMM_RC)
        _pmm_log(WARNING "Failed to install Conan in virtualenv [${_PMM_RC}]:\n${_PMM_OUTPUT}")
        _pmm_log("${msg} - Fail: Could not install Conan in virtualenv")
        return()
    endif ()

    # Conan is installed! Set PMM_CONAN_EXECUTABLE
    find_program(
            PMM_CONAN_EXECUTABLE conan
            NO_DEFAULT_PATH
            PATHS "${_PMM_CONAN_VENV_DIR}"
            PATH_SUFFIXES bin Scripts
    )
    if (NOT PMM_CONAN_EXECUTABLE)
        _pmm_log(WARNING "Conan executbale was not found acter Conan installation. Huh??")
        _pmm_log("${msg} - Fail: No conan executable in Conan installation?")
    else ()
        _pmm_log("${msg} - Installed: ${PMM_CONAN_EXECUTABLE}")
    endif ()
endfunction()