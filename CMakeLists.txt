cmake_minimum_required(VERSION 3.15)
project("mini.cmake" VERSION 1.0.0 LANGUAGES NONE)

# Use LANGUAGES NONE since there's no code to compile
# Set where to install the modules
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

enable_testing()
add_subdirectory(tests)

file(GLOB modules CONFIGURE_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cmake)

# Install the CMake modules
install(
    FILES
        ${modules}
    DESTINATION
        ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)

# Generate the config file
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)

# Generate version file
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

# Install the config files
install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION
        ${CMAKE_INSTALL_DATADIR}/cmake/${PROJECT_NAME}
)
