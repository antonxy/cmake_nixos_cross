add_executable(MyExample simple_example.cpp)

target_link_libraries(MyExample PRIVATE MyLibExample FFmpeg)

install(TARGETS MyExample 
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        )
