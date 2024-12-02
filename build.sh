#bin/bash

echo "Downloading resourcepack compiler"
rm -rf PackMake.jar PackMake.zip PackMake/
curl -L -o "PackMake.zip" "https://api.github.com/repos/iJustLeyxo/PackMake/releases/latest"
unzip PackMake.zip
cd PackMake
echo "Compiling resourcepack compiler"
mvn clean package
cd ..
cp PackMake/target/PackMake.jar .
java -jar PackMake.jar
rm -rf PackMake.jar PackMake.zip PackMake/

cd target/

for item in *; do
    if [ -d "$item" ]; then
        if [ "$item" != "." ] && [ "$item" != ".." ]; then
            dir="${item}/"
            file="Vanitas-${1}-${item}.zip"
            echo "Compiling ${file}"
            cp "../LICENSE" "$dir"
            cp "../README.md" "$dir"
            cd "$dir"
            zip -r -q -0 "$file" *
            cp "$file"
            rm -rf "$dir"
            cd ..
        fi
    fi
done
