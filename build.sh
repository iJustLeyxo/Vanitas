#bin/bash

mkdir target

for item in *; do
    if [ -d "$item" ]; then
        if [ "$item" != "." ] && [ "$item" != ".." ] && [ "$item" != "pics" ] && [ "$item" != "target" ]; then
            cd "$item"
            zip -r -0 "${item}.zip" *
            cp "${item}.zip" ../target/
            cd ..
        fi
    fi
done
