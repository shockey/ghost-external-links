checkdirectory () 
{
if [ ! -d ./core ]; then # checks for Ghost blog in current directory
	echo -e "Exiting: current directory is not a valid Ghost root."
	echo -e "Tip: Leave this script where it is, but call it from the root of your Ghost installation."
	exit 1
else
	echo -e "Core directory check: OK"
fi;
if [ ! -d ./content/themes ]; then # checks for Ghost blog in current directory
	echo -e "Exiting: current directory is not a valid Ghost root."
	echo -e "Tip: Leave this script where it is, but call it from the root of your Ghost installation."
	exit 1
else
	echo -e "Theme directory check: OK"
fi;
if [ ! -f ./ghost-external-links/ghost-external-links.js ]; then # checks for js in correct relative path
	echo -e "Exiting: could not find ghost-external-links.js."
	exit
else 
	echo -e "File presence check: OK"
fi;
}

enumerateThemes () 
{
echo -e "Enumerating themes..."
dirs=();
cd ./content/themes
for file in ./*; do
	dirs=(${dirs[@]} $file)
done
cd ../../
for item in ${dirs[*]};
do
	if [ $loopHasRun ]; then
		themesString+=", "
	fi;
    themesString+="$item"
    loopHasRun=true
done
echo -e "Themes detected: $themesString"
}

collectWhitelist ()
{
	whitelist=()
	echo "First, let's build a list of all the websites you want to whitelist."
	echo "Type the domain name of the sites only: no http:// or slashes in the name."
	echo "For example: google.com is formatted correctly."
	echo
	while IFS= read -r -p "Enter an item (end with an empty line): " line; do
	    [[ $line ]] || break  # break if line is empty
	    whitelist+=("'$line'")
	done
	for item in ${whitelist[*]};
	do
		if [ $loopHasRun ]; then
			whitelistString+=", "
		fi;
	    whitelistString+="$item"
	    loopHasRun=true
	done
}

stageSource () 
{
	echo "Staging code with new whitelist"
	mkdir ./ghost-external-links/staged
	cp ./ghost-external-links/ghost-external-links.js ./ghost-external-links/staged/ghost-external-links.js
	sed -i '' 's@// add your excluded domains here@'"$whitelistString"'@g' ./ghost-external-links/staged/ghost-external-links.js
}

installScript () {
	cd ./content/themes
	for folder in ${dirs[*]};
	do
		cp ../../staged/ghost-external-links.js $folder/assets/js/ghost-external-links.js
		echo -e "Installed script to $folder"
	done
	cd ../../
}

injectReferences () {
	# meditate: sed 's/.*Fedora.*/&\nCygwin/' file
	cd ./content/themes
	for folder in ${dirs[*]};
	do
		sed -i '' 's|.*'"</body>"'.*|'"<script type="text/javascript" src="/assets/js/ghost-external-links.js"></script>&|" content/themes/one/default.hbs
		echo -e "Added code reference to $folder"
	done
}

cleanupFiles () {
	read wait
	rm ./ghost-external-links/staged/*
	rmdir ./ghost-external-links/staged
}

# make the magic happen

# checkdirectory

echo -e "Welcome to Ghost External Links!"
echo -e "This installer assumes that you haven't modified anything since you downloaded the plugin."
echo -e "If you've made changes, please redownload before continuing."
echo
echo "Please choose an action, 'install' or 'remove': "
read action
echo

if [ $action = "install" ]; then
	enumerateThemes
	collectWhitelist # prompt the user for a whitelist of domains
	stageSource # make a temporary derivative of the original source with the new whitelist
	installScript # copy the staged code into the theme directories
	injectReferences # inject references to our .js into themes
	cleanupFiles
elif [ $action = "remove" ]; then
	enumerateThemes
	# removeScript
	# scrubReferences
else 
	$action # else, try to call whatever was passed as a function
fi;


#checks

# broken for now, since we made dirs a local variable
# for item in ${dirs[*]};
# do
#     printf "   %s\n" $item
# done