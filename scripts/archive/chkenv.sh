if [[ -z "$(command -v nvm)" ]]; then
	echo "Installing nvm"
	curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh" | bash >> /dev/null
	echo -e "nvm is now installed. "
	echo -e "You must restart your shell in order for these changes to take effect. "
	echo "If problems persist please visit http://nvm.sh/"
fi

exit 0
