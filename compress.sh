#bin/bash
# Requires optipng

find . \( -path ./.git -prune -o -path ./target -prune \) -o -type d -exec bash -c 'echo "Compressing $0" && cd $0 && optipng -silent -strip all -o7 *png' {} \;
