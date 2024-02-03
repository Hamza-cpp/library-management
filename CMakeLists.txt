cmake_minimum_required(VERSION 3.15)
project(MyProject)

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Find the Boost package (ensure that it is installed)
#find_package(Asio)
#find_package(Crow)

# Add an executable target
add_executable(MyProject src/main.cpp)

# Link Boost libraries
#target_link_libraries(MyProject PUBLIC Asio::Asio)
#target_link_libraries(MyProject PUBLIC Crow::Crow)

set(INCLUDE_PATHS boost_1_84_0 crow/include)

target_include_directories(MyProject PUBLIC ${INCLUDE_PATHS})