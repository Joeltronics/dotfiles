#!/bin/bash

ANY_ERRORS=0

make_symlink()
{
	local TARGET=$(realpath $1)
	local LINK_LOCATION=$2

	if ! [[ -f $TARGET ]]; then
		echo "ERROR: $TARGET does not exist" >&2
		ANY_ERRORS=1
		return 1
	fi

	local LINK_DIR=$(dirname $LINK_LOCATION)
	if ! [[ -d $LINK_DIR ]]; then
		echo "$LINK_DIR does not exist; creating"
		mkdir -p $LINK_DIR
	fi

	local LN_FORCE=""

	if [[ -L "$LINK_LOCATION" ]]; then
		echo "$LINK_LOCATION already exists as a symlink; replacing"
		LN_FORCE="-f"
	elif [[ -f "$LINK_LOCATION" ]]; then
		echo "ERROR: $LINK_LOCATION already exists (and is not a symlink)" >&2
		ANY_ERRORS=1
		return 1
	else
		echo "$LINK_LOCATION does not exist; creating symlink"
	fi

	echo "ln -s $TARGET $LINK_LOCATION $LN_FORCE"
	if ! ln -s $TARGET $LINK_LOCATION $LN_FORCE ; then
		echo "ERROR: \"ln -s $TARGET $LINK_LOCATION $LN_FORCE\" returned error" >&2
		ANY_ERRORS=1
	fi
}

echo "Setting up symlinks..."
echo ""

make_symlink ./bashrc ~/.bashrc
make_symlink ./bash_aliases ~/.bash_aliases
make_symlink ./inputrc ~/.inputrc
make_symlink ./git-autosquash ~/.local/bin/git-autosquash

echo ""
if [[ $ANY_ERRORS != 0 ]]; then
	echo "Done, but there were errors (see above)"
else
	echo "Success!"
fi
