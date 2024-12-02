#bin/bash

# Resourcepack compiler

rm -rf PackMake.jar PackMake.zip PackMake/

PM_VER=$(echo $(curl -s https://api.github.com/repos/iJustLeyxo/PackMake/releases/latest) | jq -r '.tag_name')
PM_URL="https://github.com/iJustLeyxo/PackMake/archive/refs/tags/$PM_VER.zip"

if [ -z "$PM_URL" ]; then
    echo "Faulty download url"
    exit 1
fi

echo "Downloading resourcepack compiler from $PM_URL"
curl -sLo "PackMake.zip" $PM_URL

echo "Extracting resourcepack compiler"
unzip -q PackMake.zip
rm -f PackMake.zip

PM_DIR="PackMake-$PM_VER/"
cd "$PM_DIR"

echo "Compiling resourcepack compiler"
mvn -q clean package
cd ..
cp "$PM_DIR/target/PackMake.jar" "PackMake.jar"
rm -rf "$PM_DIR"

echo "Compiling resourcepack"
java -jar PackMake.jar
rm -f PackMake.jar

# Resourcepack packaging

cd target/

for item in *; do
    if [ -d "$item" ]; then
        if [ "$item" != "." ] && [ "$item" != ".." ]; then
            dir="${item}/"
            file="Vanitas-${1}-${item}.zip"
            echo "Packaging ${file}"
            cp "../LICENSE" "$dir"
            cp "../README.md" "$dir"
            cd "$dir"
            zip -rq0 "$file" *
            cp "$file" "../$file"
            cd ..
            rm -rf "$dir"
        fi
    fi
done
