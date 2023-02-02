add_library(MyLibExample SHARED simple_lib.cpp)
target_include_directories(MyLibExample PUBLIC ./include)

# OutputLib can be a private dependency since it is not used in the header
target_link_libraries(MyLibExample PRIVATE OutputLib)

# Since boost is used in the header it has to be PUBLIC
# For STATIC libraries it happens to work with PRIVATE anyway, but for shared it's important
target_link_libraries(MyLibExample PUBLIC Boost::filesystem)

install(TARGETS MyLibExample 
        RUNTIME 
        LIBRARY
        )
