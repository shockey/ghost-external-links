checkdirectory () 
{
if [ ! -d ./core ]; then
	echo -e "Exiting: current directory is not a Ghost root."
	echo -e "Tip: Leave this script where it is, but call it from the root of your Ghost installation."
	exit 1
else
	echo -e "Directory check: OK"
fi;
if [ ! -f ./ghost-external-links/ghost-external-links.js ]; then
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
	echo "For example: 'google.com' is formatted correctly."
	echo
	while IFS= read -r -p "Enter an item (end with an empty line): " line; do
	    [[ $line ]] || break  # break if line is empty
	    whitelist+=("$line")
	done
}

# make the magic happen

# checkdirectory

echo -e "Welcome to Ghost External Links!"
echo "Please choose an action, type 'install' or 'remove': "
read action
echo

if [ $action = "install" ]; then
	enumerateThemes
	collectWhitelist # prompt the user for a whitelist of domains
	# stageSource # make a temporary derivative of the original source with the new whitelist injected
	# installScript # copy the staged code into the theme directories
	# injectReferences # inject references to our .js into themes
	# cleanupFiles
elif [ $action = "remove" ]; then
	enumerateThemes
	# removeScript
	# scrubReferences

fi;


#checks

# broken for now, since we made dirs a local variable
# for item in ${dirs[*]};
# do
#     printf "   %s\n" $item
# done