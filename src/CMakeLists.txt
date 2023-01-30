add_executable(MyExample simple_example.cpp)

target_link_libraries(MyExample PRIVATE MyLibExample)

install(TARGETS MyExample 
        RUNTIME DESTINATION bin
        )
