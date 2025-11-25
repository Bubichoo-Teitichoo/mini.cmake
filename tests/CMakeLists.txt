cmake_policy(SET CMP0110 NEW)

add_test(
    NAME "mini.cmake (find_package)"
    COMMAND ${CMAKE_COMMAND}
        -D CMAKE_MODULE_PATH=${CMAKE_CURRENT_SOURCE_DIR}
        -D BINARY_DIR=${CMAKE_BINARY_DIR}
        -P ${CMAKE_CURRENT_SOURCE_DIR}/test_find_package.cmake
)

add_test(
    NAME "mini.string"
    COMMAND ${CMAKE_COMMAND}
        -P ${CMAKE_CURRENT_SOURCE_DIR}/test_mini.string.cmake
)
