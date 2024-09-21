#bin/bash

rm -rf target/
mkdir target/

for item in *; do
    if [ -d "$item" ]; then
        if [ "$item" != "." ] && [ "$item" != ".." ] && [ "$item" != "pics" ] && [ "$item" != "target" ]; then
            cd "$item"
            name="Vanitas-${1}-${item}.zip"
            echo "$name"
            zip -r -q -0 "$name" *
            cp "$name" ../target/
            cd ..
        fi
    fi
done
