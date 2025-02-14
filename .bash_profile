# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
	# needed for brew
	eval "$(/usr/local/bin/brew shellenv)"
fi

# Only run these on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	# needed for brew to work
# 	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi
#
# if [ -r ~/.bashrc ]; then
# 	source ~/.bashrc
# fi

export XDG_CONFIG_HOME="$HOME"/.config

source ~/.bashrc
