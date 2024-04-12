#!/usr/bin/zsh

if [[ $OSTYPE == "linux-gnu"* ]]; then
	# Android Studio
	export ANDROID_HOME="$HOME/apps/android-sdk"
	export ANDROID_USER_HOME="$HOME/apps/android-studio/user"
	export ANDROID_AVD_HOME="$ANDROID_USER_HOME/avd"
	export STUDIO_JDK="$HOME/apps/android-studio/jbr"
	export NVIM_HOME="$HOME/.local/bin/nvim"

	PATH="$PATH:$ANDROID_HOME/emulator"
	PATH="$PATH:$ANDROID_HOME/platform-tools"
	PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
	PATH="$PATH:$ANDROID_HOME/tools/bin"
	PATH="$PATH:$ANDROID_HOME/tools"

	# bind DELETE key
	bindkey "^[[3~" delete-char
	# bind HOME key
	bindkey "^[[H" beginning-of-line
	# bind END key
	bindkey "^[[F" end-of-line

	# fix vte crash for `tilix`
	if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
		source /etc/profile.d/vte.sh
	fi
fi
