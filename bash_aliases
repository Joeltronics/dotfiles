# 
# Navigation etc
#

alias l='ls -CF'
alias ll='ls -lAFBGh'
alias la='ls -lahF'
alias lla='ls -lahF'

alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias .7='cd ../../../../../../../'
alias .8='cd ../../../../../../../../'

function cl() {
	cd $1
	ls -CF
}

function f() {
	xdg-open "${PWD}$@"
}

#
# grep and related
#

# alternative to find | grep
function findgrep() {
	find -not -path "*/.hg/*" | grep "$@"
}

# Find & replace via sed
function sedc() {
	find \( \
		-name '*.c' -o \
		-name '*.cpp' -o \
		-name '*.cc' -o \
		-name '*.h' -o \
		-name '*.hh' -o \
		-name '*.hpp' -o \
		-name '*.ipp' -o \
		-name '*.inl'\
		\) -not -path './build*' | xargs sed -i "$1"
}

# grep only C/C++ source & header files
function grepc() {
	echo "Header files:"
	grep -nrsI \
		--include={"*.h","*.hpp","*.hh","*.ipp"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
	echo "Source files:"
	grep -nrsI \
		--include={"*.c","*.cpp","*.cc","*.inl"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
}

# grep only C/C++ source & header files, but excluding files that have the search term in the filename
function grepcx() {
	echo "Header files:"
	grep -nrsI \
		--include={"*.h","*.hpp","*.hh","*.ipp"} \
		--exclude="*$@*" \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
	echo "Source files:"
	grep -nrsI \
		--include={"*.c","*.cpp","*.cc","*.inl"} \
		--exclude="*$@*" \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
}

# grep only .cpp files
function grepcpp() {
	grep -nrsI \
		--include="*.cpp" \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
}

# grep only C/C++ header files
function greph() {
	grep -nrsI \
		--include={"*.h","*.hpp","*.hh","*.ipp"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
}

# grep only C/C++ header files, but excluding files that have the search term in the filename
function grephx() {
	grep -nrsI \
		--include={"*.h","*.hpp","*.hh","*.ipp"} \
		--exclude="*$@*" \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
}

# grep only Makefiles, cmake files, kernel configs, and other similar
function grepmk() {
	grep -nrsI \
		--include={Makefile,"*.mk","*.cmake","CMakeLists.txt","*.inc","Kconfig","*_config","*_defconfig"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
}

# grep only Python files
function greppy() {
	grep -nrsI \
		--include="*.py" \
		--exclude-dir={.git,.hg,build,out,generated,venv,virtualenv,site-packages} \
		"$@" .
}

# grep only web files
function grepweb() {
	echo "JS files:"
	grep -nrsI \
		--include="*.js" \
		--exclude={"*.min.js"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
	echo "HTML files:"
	grep -nrsI \
		--include={"*.html","*.shtml","*.xhtml"} \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
	echo "CSS files:"
	grep -nrsI \
		--include="*.css" \
		--exclude-dir={.git,.hg,build,out,generated} \
		"$@" .
	echo ""
}
