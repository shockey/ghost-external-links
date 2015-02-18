checkdirectory () 
{
if [ ! -d ./core ]; then # checks for Ghost blog core in current directory
	echo -e "Exiting: current directory is not a Ghost root."
	echo -e "Tip: Leave this script where it is, but call it from the root of your Ghost installation."
	exit 1
else
	echo -e "Directory check: OK"
fi;
if [ ! -f ./ghost-external-links/ghost-external-links.js ]; then # checks for js in correct relative path
	echo -e "Exiting: could not find ghost-external-links.js in the script's directory."
	exit
else 
	echo -e "File presence check: OK"
fi;
}

enumerateThemes () 
{
dirs=();
cd ./content/themes
for file in ./*; do
	dirs=(${dirs[@]} $file)
done
cd ../../
echo -e 
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
	mkdir ./ghost-external-links/staged
	cp ./ghost-external-links/ghost-external-links.js ./ghost-external-links/staged/ghost-external-links.js
	sed -i '' 's@// add your excluded domains here@$whitelistString@g' ./ghost-external-links/staged/ghost-external-links.js 
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
echo "Please choose an action, type 'install' or 'remove': "
read action
echo

if [ $action = "install" ]; then
	enumerateThemes
	collectWhitelist # prompt the user for a whitelist of domains
	stageSource # make a temporary derivative of the original source with the new whitelist
	# installScript # copy the staged code into the theme directories
	# injectReferences # inject references to our .js into themes
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