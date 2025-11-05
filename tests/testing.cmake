include_guard(GLOBAL)

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0012 NEW)

macro(assert CONDITION)
    cmake_parse_arguments("ARGS" "" "MESSAGE" "" ${ARGN})

    if(NOT DEFINED __failure)
        message(FATAL_ERROR "'assert' has to be called from within 'test' bock.")
    endif()

    cmake_language(EVAL CODE
        "
        if(NOT ${CONDITION})
            if(NOT ARGS_MESSAGE STREQUAL \"\")
                message(STATUS \"${ARGS_MESSAGE}\")
            endif()
            set(__failure 1)
        endif()
        "
    )
endmacro()

macro(assert_equal ACTUAL EXPECTED)
    cmake_parse_arguments("ARGS" "" "MESSAGE" "" ${ARGN})

    if(ARGS_MESSAGE)
        set(ARGS_MESSAGE "${ARGS_MESSAGE}. ")
    endif()
    set(ARGS_MESSAGE "${ARGS_MESSAGE}Expected: '${EXPECTED}' - Actual: '${ACTUAL}'")

    assert("${ACTUAL} EQUAL ${EXPECTED}"
        MESSAGE "${ARGS_MESSAGE}"
    )
endmacro()

macro(assert_str_equal ACTUAL EXPECTED)
    cmake_parse_arguments("ARGS" "" "MESSAGE" "" ${ARGN})

    if(ARGS_MESSAGE)
        set(ARGS_MESSAGE "${ARGS_MESSAGE}. ")
    endif()
    set(ARGS_MESSAGE "${ARGS_MESSAGE}Expected: '${EXPECTED}' - Actual: '${ACTUAL}'")

    assert("\"${ACTUAL}\" STREQUAL \"${EXPECTED}\""
        MESSAGE "${ARGS_MESSAGE}"
    )
endmacro()

macro(assert_defined VAR)
    cmake_parse_arguments("ARGS" "" "MESSAGE" "" ${ARGN})

    if(ARGS_MESSAGE)
        set(ARGS_MESSAGE "${ARGS_MESSAGE}: ")
    endif()
    set(ARGS_MESSAGE "${ARGS_MESSAGE}${VAR} is not defined")

    assert("DEFINED ${VAR}"
        MESSAGE "${ARGS_MESSAGE}"
    )
endmacro()

macro(test NAME)
    message(CHECK_START "Test case: ${NAME}")
    if(NOT DEFINED __failures)
        message(FATAL_ERROR "'test' block have to be placed in a 'testsuite' block")
    endif()

    set(__failure OFF)
endmacro()

macro(endtest)
    if(__failure)
        message(CHECK_FAIL "failure")
        MATH(EXPR __failures "${__failures}+1")
    else()
        message(CHECK_PASS "success")
    endif()
    unset(__failure)
endmacro()

macro(testsuite NAME)
    message(CHECK_START "Running test suite: ${NAME}")

    set(__failures 0)
endmacro()

macro(endtestsuite)
    if(__failures)
        message(CHECK_FAIL "failure")
        cmake_language(EXIT ${__failures})
    else()
        message(CHECK_PASS "success")
    endif()
endmacro()

