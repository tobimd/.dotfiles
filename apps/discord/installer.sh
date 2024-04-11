#!/usr/bin/env bash
set -e

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    printf "[error] not running as root\n"
    exit 1
fi


# find this file's path
root=$(realpath "$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && (pwd -W 2>/dev/null || pwd))")

# clean after errors
cleanup() {
	# restore "resources/" backup
	if [[ ! -r "$root/resources" && -r "$root/resources.bak" ]]; then
		mv "$root/resources.bak" "$root/resources"
	fi

	# restore "locales/" backup
	if [[ ! -r "$root/locales" && -r "$root/locales.bak" ]]; then
		mv "$root/locales.bak" "$root/locales"
	fi

	# remove downloaded files in "/tmp"
	if [[ ! -z "$output" ]]; then
		rm -rf "$output.tar.gz"

		if [[ -r "$output" ]]; then
			rm -r "$output"
		fi
	fi
}

# specify that cleanup should be called on errs
trap cleanup ERR

# parse argument options
TEMP=$(getopt -o 'f' --long 'force' -n 'installer.sh' -- "$@")
if [[ $? -ne 0 ]]; then echo 'terminating...' >&2 ; exit 1 ; fi
eval set -- "$TEMP"
unset TEMP

force="false"
while true; do
	case "$1" in
		'-f'|'--force')
			force="true"
			shift
			continue ;;
		'--')
			shift
			break ;;
		*)
			printf "[error] unknown error while parsing arguments\n" >&2
			exit 1 ;;
	esac
done

# get the full filename of the new version
filename=$( \
    curl --silent --show-error 'https://discord.com/api/download/stable?platform=linux&format=tar.gz' \
    | grep -Eoe 'href="[^"]+"' \
    | sed -E 's/.+(discord-.+)"/\1/g'
)
version=$(echo "$filename" | grep -Eom 1 -e '[0-9]+\.[0-9]+\.[0-9]+')

# compare local version with upstream if not using "--force"
if [[ "$force" == "false" ]]; then
	current=$(jq -r '.version' "$root/resources/build_info.json")

	if [[ "$current" == "$version" ]]; then
		printf "already up to date (v$current).\n"
		exit 0
	fi

	printf "updating from version $current to $version.\n"
else
	printf "updating to $version (forced).\n"
fi

# install version
printf "downloading\n"
output="/tmp/downloads/discord-$version"
curl \
    --show-error \
    --progress-bar \
    --location \
    --output "$output.tar.gz"  \
    "https://dl.discordapp.net/apps/linux/$version/discord-$version.tar.gz"

printf "installing\n"

# extract download
tar xf "$output.tar.gz" -C "/tmp/downloads"
mv "/tmp/downloads/Discord" "$output"

# rename the two directories to avoid collision
mv "$root/resources" "$root/resources.bak"
mv "$root/locales" "$root/locales.bak"

# mv download to discord folder
mv -ft $root $output/*

# remove backups
rm -fr "$root/resources.bak" 2>&1 >/dev/null
rm -fr "$root/locales.bak" 2>&1 >/dev/null

printf "done.\n"
