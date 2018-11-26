#!/bin/sh
DIRNAME=`dirname $0`

source $DIRNAME/.vars
source ~/.homesick/repos/homeshick/homeshick.sh
homeshick link $REPO_NAME

# SPACEMACS
git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
