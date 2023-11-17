#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi


# leo run create_shares "77777field" "3u8" "8391471947992374field" "[aleo1gz527q3dt4axqjj2a5zfxattf8djh38dql79tvrn69pja93njc9qxhavjj, aleo1gz527q3dt4axqjj2a5zfxattf8djh38dql79tvrn69pja93njc9qxhavjj, aleo1q8lpp29mtp8hzwlvzqf2qzkweyn0gk92x98ujddztkug32e6cyxqhya349, aleo1q8lpp29mtp8hzwlvzqf2qzkweyn0gk92x98ujddztkug32e6cyxqhya349, aleo1mqdnfnjxnpfdkyzewqsup45sw37g3ssyndxg7nt7hgssm7zx3vxslknm3p]"

# leo run restore_secret_from_shares \
#  "{x: 1field, \
#    y: 922309144816301324502543109173820703316407336830053895717015341727054907705field }" \
#   "{x: 2field, \
#    y: 6845343146619967649889744972728947308153161740629396538520498078005765457140field }"  \
#    "{x: 3field, \
#     y: 880178506554258127663955713102286751758464541089900272539981297001313248000field }"


leo run restore_secret_from_n_shares \
    "3u8" \
    "[ \
    {x: 1field, y: 922309144816301324502543109173820703316407336830053895717015341727054907705field }, \
    {x: 2field, y: 6845343146619967649889744972728947308153161740629396538520498078005765457140field }, \
    {x: 3field, y: 880178506554258127663955713102286751758464541089900272539981297001313248000field }, \
    {x: 0field, y: 0field }, \
    {x: 0field, y: 0field } \
    ]"


