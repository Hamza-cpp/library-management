#!/bin/bash

add_model_class() {
    local model_class="$1"
    local base_dir=$(dirname "$0")
    local include_dir="${base_dir}/include/models"
    local src_dir="${base_dir}/src/models"

    local header_file="${include_dir}/${model_class}.h"
    local cpp_file="${src_dir}/${model_class}.cpp"

    # Check if the files already exist
    if [ -f "$header_file" ] || [ -f "$cpp_file" ]; then
        echo "Error: Model class '$model_class' already exists." >&2
        return 1
    fi

    # Ensure include and src directories exist
    mkdir -p "$include_dir" "$src_dir"

    cat >"$header_file" <<EOF
#ifndef ${model_class^^}_H
#define ${model_class^^}_H

class $model_class {
public:
    $model_class();
    virtual ~$model_class();

};

#endif // ${model_class^^}_H
EOF

    cat >"$cpp_file" <<EOF
#include "${header_file}"

$model_class::$model_class() {
    // TODO: Constructor implementation
}

$model_class::~$model_class() {
    // TODO: Destructor implementation
}
EOF

    echo "Model class '$model_class' added."
}

# Process each argument as a new model class
for model in "$@"; do
    add_model_class "$model"
done
