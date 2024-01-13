#!/bin/bash

# Define the project root directory name and subdirectories
PROJECT_ROOT="library-management-system"
INCLUDE_DIR="$PROJECT_ROOT/include"
SRC_DIR="$PROJECT_ROOT/src"

# Creating directories
mkdir -p "$INCLUDE_DIR"
mkdir -p "$SRC_DIR"

# CMakeLists.txt boilerplate
cat <<EOF > "$PROJECT_ROOT/CMakeLists.txt"
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
EOF

# Template for .h files
header_template() {
cat <<EOF
#ifndef ${1^^}_H
#define ${1^^}_H

class $1 {
public:
    $1();
    ~$1();
    
    // Add member functions and data here
};

#endif // ${1^^}_H
EOF
}

# Template for .cpp files
cpp_template() {
cat <<EOF
#include "$1.h"

$1::$1() {
    // Constructor implementation
}

$1::~$1() {
    // Destructor implementation
}

// Add member function definitions here
EOF
}

# Create .h and .cpp files using templates
for class in "Book" "Member" "Loan" "Library"; do
    header_file="$INCLUDE_DIR/$class.h"
    header_template "$class" > "$header_file"
    
    cpp_file="$SRC_DIR/$class.cpp"
    cpp_template "$class" > "$cpp_file"
done

# Create the main file
cat <<EOF > "$SRC_DIR/main.cpp"
#include <iostream>
#include "Book.h"
#include "Member.h"
#include "Loan.h"
#include "Library.h"

int main() {
    std::cout << "Welcome to the Library Management System!" << std::endl;
    // Bootstrapping code goes here
    return 0;
}
EOF

# Inform the user
echo "Project directory structure created at ./$PROJECT_ROOT"