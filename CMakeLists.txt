cmake_minimum_required(VERSION 3.15)
project("mini.cmake" VERSION 1.0.0 LANGUAGES NONE)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

option(MINI_CMAKE_ENABLE_TESTS "Configure unit test for 'mini.cmake'." ON)

if(MINI_CMAKE_ENABLE_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

file(GLOB modules CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cmake)

set(version_file ${PROJECT_NAME}-config-version.cmake)
write_basic_package_version_file(
    ${CMAKE_BINARY_DIR}/${version_file}
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        ${modules}
        ${CMAKE_BINARY_DIR}/${version_file}
    DESTINATION
        ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)
