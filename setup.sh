 #!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#TODO: Host the updated modloader somewhere. The current 5.2.325 release doesn't work with some modpacks
#Working modloader can be build from the develop branch at https://github.com/Nincraft/ModPackDownloader

#curl -o $DIR/modDownloader.jar -L https://github.com/Nincraft/ModPackDownloader/releases/download/0.5.2/ModpackDownloader-cli-0.5.2.325.jar

for SERVER in $BASE_DIR/servers/*; do
	if [ -d "${SERVER}" ]; then
		echo "Downloading mods and plugins for $(basename ${SERVER})"
		if [ -f "${SERVER}"/mods.json ]; then
			java -jar $BASE_DIR/modDownloader.jar -manifest "${SERVER}"/mods.json -folder "${SERVER}"/mods
		fi
		if [ -f "${SERVER}"/spongePlugins.json ]; then
			java -jar $BASE_DIR/modDownloader.jar -manifest "${SERVER}"/spongePlugins.json -folder "${SERVER}"/mods/plugins
		fi
		if [ -f "${SERVER}"/plugins.json ]; then
			java -jar $BASE_DIR/modDownloader.jar -manifest "${SERVER}"/plugins.json -folder "${SERVER}"/plugins
		fi
	fi
done

docker-compose up -d
