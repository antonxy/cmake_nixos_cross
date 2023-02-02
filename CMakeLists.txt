# Almost all CMake files should start with this
# You should always specify a range with the newest
# and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.1...3.25)

project(
  CmakeCrossTest
  VERSION 1.0
  LANGUAGES CXX)

# If you set any CMAKE_ variables, that can go here.
# (But usually don't do this, except maybe for C++ standard)
set(CMAKE_CXX_STANDARD 11 CACHE STRING "The C++ standard to use")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules")

find_package(Boost
	REQUIRED
	COMPONENTS
	system
	filesystem
	serialization)

find_package(FFmpeg
	REQUIRED
	COMPONENTS
	avcodec)

add_subdirectory(hello_lib)
add_subdirectory(src)
add_subdirectory(output_lib)

# Draw dependency graph and add it to the output
add_custom_target(graphviz ALL
    COMMAND ${CMAKE_COMMAND} "--graphviz=deps.dot" .
    COMMAND dot -Tpng deps.dot -o deps.png
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
)
install(FILES "${CMAKE_BINARY_DIR}/deps.png"
        DESTINATION share 
        )
