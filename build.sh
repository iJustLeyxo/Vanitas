#bin/bash

rm -rf target/
mkdir target/

for item in *; do
    if [ -d "$item" ]; then
        if [ "$item" != "." ] && [ "$item" != ".." ] && [ "$item" != "pics" ] && [ "$item" != "target" ] && [ "$item" != "tools" ]; then
            dir="${item}/"
            file="Vanitas-${1}-${item}.zip"
            echo "Compiling ${file}"
            cp "LICENSE" "$dir"
            cp "pack.png" "$dir"
            cp "README.md" "$dir"
            cd "$dir"
            zip -r -q -0 "$file" *
            cp "$file" ../target/
            rm "$file"
            rm "LICENSE" "pack.png" "README.md"
            cd ..
        fi
    fi
done
