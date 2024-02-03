#!/bin/bash

merge_lecture() {
    cd ../$1
    cat $(ls | grep -E "^[0-9].*.md$") > ../merge-lec/temp.md
    sed -E -i 's/^(#+) /\1# /g' ../merge-lec/temp.md
    cat README.md ../merge-lec/temp.md >> ../merge-lec/lec.md
    printf "\n<div style=\"page-break-after: always;\"></div>\n\n" >> ../merge-lec/lec.md
    cd ../merge-lec
}

export -f merge_lecture
rm -rf lec.md temp.md
cat ../org_README.md > lec.md
printf "\n<div style=\"page-break-after: always;\"></div>\n\n" >> lec.md
ls .. | grep -E "^lec" | xargs -n 1 -P 1 bash -c 'merge_lecture "$@"' _

./mdfmt -w ./lec.md
rm -rf temp.md
