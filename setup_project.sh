#!/bin/bash

# Use realpath to ensure absolute path calculation
BASE_DIR="$(realpath "$(dirname "$0")")"
INCLUDE_DIR="${BASE_DIR}/include"
SRC_DIR="${BASE_DIR}/src"

DIRECTORIES=(
    "${INCLUDE_DIR}/models"
    "${INCLUDE_DIR}/controllers"
    "${INCLUDE_DIR}/services"
    "${SRC_DIR}/models"
    "${SRC_DIR}/controllers"
    "${SRC_DIR}/services"
    "${BASE_DIR}/libs"
    "${BASE_DIR}/tests/models"
    "${BASE_DIR}/tests/controllers"
)

MODELS=("Book" "User")
CONTROLLERS=("BookController" "UserController")

echo "Creating directories..."
for dir in "${DIRECTORIES[@]}"; do
    if [ -d "${dir}" ]; then
        echo "Error: '$dir' already exists."
        continue
    fi
    mkdir -p "$dir"
    echo "Directory created: $dir"
done

header_template() {
    [ -z "$1" ] && {
        echo "Class name not provided for header_template"
        return 1
    }
    cat <<EOF
#ifndef ${1^^}_H
#define ${1^^}_H

class $1 {
public:
    $1();
    virtual ~$1();

};

#endif // ${1^^}_H
EOF
}

cpp_template() {
    [ -z "$1" ] || [ -z "$2" ] && {
        echo "Class name or type not provided for cpp_template"
        return 1
    }
    cat <<EOF
#include "./$2/$1.h"

$1::$1() {
    // TODO: Constructor implementation
}

$1::~$1() {
    // TODO: Destructor implementation
}

EOF
}

create_classes() {
    local type=$1
    shift
    local classes=("$@")

    for class in "${classes[@]}"; do
        local header_file="${INCLUDE_DIR}/${type}/${class}.h"
        local cpp_file="${SRC_DIR}/${type}/${class}.cpp"

        # Check if class files already exist to prevent overwriting
        if [[ -f "$header_file" || -f "$cpp_file" ]]; then
            echo "Error: ${type^} class '$class' already exists."
            continue
        fi

        header_template "$class" >"$header_file"
        cpp_template "$class" "include/${type}" >"$cpp_file"
        echo "${type^} class '$class' file created."
    done
}

echo "Creating model classes..."
create_classes "models" "${MODELS[@]}"

echo "Creating controller classes..."
create_classes "controllers" "${CONTROLLERS[@]}"

echo "Creating main.cpp..."
if [ -f "${SRC_DIR}/main.cpp" ]; then
    echo "Error: '${SRC_DIR}/main.cpp' already exists."
else
    cat <<EOF >"${SRC_DIR}/main.cpp"
#include <iostream>
#include "./include/models/Book.h"
#include "./include/models/User.h"
#include "./include/controllers/BookController.h"
#include "./include/controllers/UserController.h"

int main() {
    std::cout << "Welcome to the Library Management System!" << std::endl;
    // TODO: Bootstrapping code goes here
    return 0;
}
EOF
    echo "main.cpp has been created in ${SRC_DIR}"
fi

FILES=(
    "${BASE_DIR}/.gitignore"
    "${BASE_DIR}/README.md"
    "${BASE_DIR}/HELP.md"
)

for file in "${FILES[@]}"; do
    if [ -f "${file}" ]; then
        echo "Error: '$file' already exists."
        continue
    fi
    touch "$file"
    echo "File created: $file"
done

echo "Project setup is complete."
