Como compilar um código-fonte em Haskell sem bagunçar tudo:

`ghc -o ../bin/file file.hs -odir '../o' -hidir '../hi'`


Para que o programa funcione é necessário instalar as seguintes bibliotecas:

Csv, Text, Vector

(na linha de comando)
cabal install text
cabal install vector
cabal install csv

(caso necessario, instalar o cabal)
sudo apt-get install cabal