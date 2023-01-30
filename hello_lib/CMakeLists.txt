add_library(MyLibExample simple_lib.cpp)
target_include_directories(MyLibExample PUBLIC ./include)
target_link_libraries(MyLibExample PRIVATE Boost::filesystem OutputLib)
