cmake_minimum_required(VERSION 3.10)
project(LibraryManagementSystem VERSION 1.0)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
include_directories(include)
add_executable(LibraryManagementSystem
    src/main.cpp
    src/Book.cpp
    src/Member.cpp
    src/Loan.cpp
    src/Library.cpp
)
