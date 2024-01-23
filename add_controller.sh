#!/bin/bash

add_controller_class() {
    local controller_class="$1"
    local base_dir=$(dirname "$0")
    local include_dir="${base_dir}/include/controllers"
    local src_dir="${base_dir}/src/controllers"

    local header_file="${include_dir}/${controller_class}.h"
    local cpp_file="${src_dir}/${controller_class}.cpp"

    # Check if the files already exist
    if [ -f "$header_file" ] || [ -f "$cpp_file" ]; then
        echo "Error: Controller class '$controller_class' already exists." >&2
        return 1
    fi

    # Ensure include and src directories exist
    mkdir -p "$include_dir" "$src_dir"

    cat > "$header_file" <<EOF
#ifndef ${controller_class^^}_H
#define ${controller_class^^}_H

class $controller_class {
public:
    $controller_class();
    ~$controller_class();

    // TODO: Add member functions here
};

#endif // ${controller_class^^}_H
EOF

    cat > "$cpp_file" <<EOF
#include "${header_file}"

$controller_class::$controller_class() {
    // TODO: Constructor implementation
}

$controller_class::~$controller_class() {
    // TODO: Destructor implementation
}
EOF

    echo "Controller class '$controller_class' added."
}

# Process each argument as a new controller class
for controller in "$@"; do
    add_controller_class "$controller"
done