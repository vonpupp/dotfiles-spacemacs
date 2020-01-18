#!/usr/bin/env bash

EMACS_VERSION=26.3
mkdir -p ~/.emacs.d/elpa/$EMACS_VERSION/develop/contrib/scripts/
ln -s /usr/share/java/ditaa/ditaa-0.11.jar ~/.emacs.d/elpa/$EMACS_VERSION/develop/contrib/scripts/ditaa.jar
