#bin/bash

# Resourcepack compiler

rm -rf PackMake.jar PackMake.zip PackMake/ target/

PM_VER="0.0.4"


if [ ! -e "PackMake-${PM_VER}.jar" ]; then # Download PackMake if not exists
    # Newest PM_VER=$(echo $(curl -s https://api.github.com/repos/iJustLeyxo/PackMake/releases/latest) | jq -r '.tag_name')
    PM_URL="https://github.com/iJustLeyxo/PackMake/archive/refs/tags/$PM_VER.zip"
    
    if [ -z "$PM_URL" ]; then
        echo "Faulty download url"
        exit 1
    fi
    
    echo "Downloading resourcepack compiler from $PM_URL"
    curl -sLo "PackMake-${PM_VER}.zip" $PM_URL

    echo "Extracting resourcepack compiler"
    unzip -q "PackMake-${PM_VER}.zip"
    rm -f "PackMake-${PM_VER}.zip"

    PM_DIR="PackMake-$PM_VER/"
    cd "$PM_DIR"

    echo "Compiling resourcepack compiler"
    mvn -q clean package
    cd ..
    cp "$PM_DIR/target/PackMake.jar" "PackMake-${PM_VER}.jar"
    rm -rf "$PM_DIR"
fi

echo "Compiling resourcepack"
java -jar "PackMake-${PM_VER}.jar"
