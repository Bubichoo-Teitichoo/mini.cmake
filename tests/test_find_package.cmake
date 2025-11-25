include(testing NO_POLICY_SCOPE)

testsuite("mini.cmake find_package test")
    test("mini.cmake - find_package and include")
        file(MAKE_DIRECTORY test_find_package)

        # Write a test CMakeLists.txt
        file(WRITE test_find_package/CMakeLists.txt [=[
            cmake_minimum_required(VERSION 3.30)
            project(TestFindPackage LANGUAGES NONE)

            find_package(mini.cmake)

            if(NOT mini.cmake_FOUND)
                message(FATAL_ERROR "mini.cmake could not be found.")
            endif()

            if(NOT DEFINED mini.cmake_VERSION)
                message(FATAL_ERROR "mini.cmake_VERSION not set.")
            endif()

            include(mini.string)
            mini_string_snake_case("Foo Bar" output)
            if(NOT "${output}" STREQUAL "foo_bar")
                message(FATAL_ERROR "converting string to snake case failed")
            endif()
        ]=])

        # Install the package first
        # Run cmake project that includes the project
        execute_process(
            COMMAND ${CMAKE_COMMAND} --install ${BINARY_DIR} --prefix bin
            COMMAND ${CMAKE_COMMAND} -B build -S . -DCMAKE_PREFIX_PATH=bin
            WORKING_DIRECTORY test_find_package
            RESULT_VARIABLE result
            OUTPUT_VARIABLE output
            ERROR_VARIABLE error
        )

        if(output)
            message("${output}")
        endif()
        assert_equal(${result} 0 MESSAGE ${error})
    endtest()
endtestsuite()
