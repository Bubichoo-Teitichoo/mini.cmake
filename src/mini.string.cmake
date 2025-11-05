cmake_minimum_required(VERSION 3.30)
include_guard(GLOBAL)

include(mini.utils)

function(mini_string_snake_case STRING DESTINATION)
    cmake_parse_arguments("ARGS" "" "MODE;MAX_SPACES" "" ${ARGN})

    mini_set_default(ARGS_MODE TOLOWER)
    mini_set_default(ARGS_MAX_SPACES 1)

    # replace all non-word character with spaces
    string(REGEX REPLACE "[^a-zA-Z0-9]" " " STRING "${STRING}")
    string(STRIP "${STRING}" STRING)

    # Create a a regex pattern in the following manner "(<x spaces>) +"
    # This captures the maximum allowed number of spaces
    # and removes the rest of them.
    string(REPEAT " " ${ARGS_MAX_SPACES} space_regex)
    string(CONCAT space_regex "(" "${space_regex}" ") +")

    string(REGEX REPLACE "${space_regex}" "\\1" STRING "${STRING}")
    string(REPLACE " " "_" STRING ${STRING})
    string(${ARGS_MODE} "${STRING}" STRING)

    set(${DESTINATION} "${STRING}" PARENT_SCOPE)
endfunction()

function(mini_string_pascal_case STRING DESTINATION)
    # replace all non-word character with spaces
    string(REGEX REPLACE "[^a-zA-Z0-9]" " " STRING "${STRING}")
    string(STRIP "${STRING}" STRING)
    string(TOLOWER "${STRING}" STRING)

    # Turn the space separated string into a cmake-style "list"
    string(REGEX REPLACE " +" ";" STRING "${STRING}")

    unset(words)
    foreach(word ${STRING})
        string(SUBSTRING ${word} 0 1 char)
        string(SUBSTRING ${word} 1 -1 rest)

        string(TOUPPER ${char} char)
        string(CONCAT word ${char} ${rest})
        list(APPEND words ${word})
    endforeach()
    string(JOIN "" STRING ${words})

    set(${DESTINATION} ${STRING} PARENT_SCOPE)
endfunction()
