#!/usr/bin/zsh

if [[ $OSTYPE == "darwin"* ]]; then
	export LS_HOME="/usr/local/bin/gls"
	export SED_HOME="/usr/local/opt/gnu-sed/libexec/gnubin/sed"

	# Homebrew
	export HOMEBREW_NO_ANALYTICS=1
	export HOMEBREW_NO_ENV_HINTS=1
	export HOMEBREW_AUTOREMOVE=1

	# Gem
	export GEM_HOME="$HOME/.config/gem"

	# Android Studio
	export ANDROID_HOME="$HOME/Library/Android/sdk"
	export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
	export ANDROID_AVD_HOME="$HOME/.android/avd"

	PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
	PATH="/usr/local/Homebrew/bin:$PATH"
	PATH="$GEM_HOME/bin:$PATH"

	alias ip='ipconfig getifaddr en0'
fi
