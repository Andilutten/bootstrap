#!/usr/bin/env bash

BOOTSTRAP_DIR=$HOME/.bootstrap

installPackages() {
	PACKAGES=(
		build-essential
		dconf-cli
		vim
		npm
		nodejs
		git
		docker.io
		golang
	)
	sudo apt update
	sudo apt install -y ${PACKAGES[@]}
}

setupGnomeTerminal() {
	dconf load /org/gnome/terminal/legacy/profiles:/ < $BOOTSTRAP_DIR/terminal.dconf
}

installFonts() {
	FONTS_DIR=$HOME/.local/share/fonts

	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip
	mkdir -p $FONTS_DIR
	unzip CascadiaCode.zip -d $FONTS_DIR
	rm CascadiaCode.zip
	fc-cache

	gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove NF Bold 10'
}

setupInputSources() {
	dconf load /org/gnome/desktop/input-sources/ < $BOOTSTRAP_DIR/inputs.dconf
}

setupWindowManagement() {
	dconf load /org/gnome/desktop/input-sources/ < $BOOTSTRAP_DIR/windows.dconf
}

setupBash() {
cat << EOF >> $HOME/.profile
# Set up pathing for golang
export GOPATH="\$HOME/.local/go"
export GOBIN="\$GOPATH/bin"
export PATH="\$GOBIN:\$PATH"

# Set up pathing for npm
export NPMPATH="\$HOME/.local/npm"
export NPMBIN="\$HOME/.local/npm/bin"
export PATH="\$NPMBIN:\$PATH"
EOF
cat << EOF >> $HOME/.bashrc
export EDITOR=\${EDITOR:-vim}
EOF
}

installPackages
installFonts
setupInputSources
setupGnomeTerminal
setupWindowManagement
setupBash
