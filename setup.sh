#!/usr/bin/env bash

installPackages() {
	PACKAGES=(
		build-essential
		dconf-cli
		vim
		git
		docker.io
		golang
	)
	SNAP_PACKAGES_CLASSIC=(
		slack
	)
	sudo apt install -y ${PACKAGES[@]}
	for PACKAGE in ${SNAP_PACKAGES_CLASSIC[@]}; do
		yes | sudo snap install $PACKAGE --classic
	done
}

setupGnomeTerminal() {
	dconf load /org/gnome/terminal/legacy/profiles:/ << \
EOF
[:b1dcc9dd-5262-4d8d-a863-c897e6d979b9]
audible-bell=false
background-color='rgb(34,34,34)'
bold-is-bright=false
custom-command=''
default-size-columns=120
default-size-rows=70
foreground-color='rgb(253,253,253)'
login-shell=false
palette=['rgb(34,34,34)', 'rgb(252,127,81)', 'rgb(90,215,110)', 'rgb(254,222,157)', 'rgb(236,130,212)', 'rgb(253,161,139)', 'rgb(103,209,251)', 'rgb(253,253,253)', 'rgb(146,137,134)', 'rgb(252,116,82)', 'rgb(114,254,154)', 'rgb(255,246,191)', 'rgb(253,164,233)', 'rgb(253,177,162)', 'rgb(155,226,253)', 'rgb(255,255,255)']
preserve-working-directory='always'
scrollbar-policy='never'
use-custom-command=false
use-system-font=true
use-theme-colors=false
visible-name='Andilutten'
EOF
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
	dconf load /org/gnome/desktop/input-sources/ << \
EOF
[/]
sources=[('xkb', 'us+colemak')]
xkb-options=['ctrl:nocaps', 'caps:none']
EOF
}

setupWindowManagement() {
	dconf load /org/gnome/desktop/input-sources/ << \
EOF
[/]
resize-with-right-button=true
EOF
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
