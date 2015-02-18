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
local dirs=();
cd ./content/themes
for file in ./*; do
	local dirs=(${dirs[@]} $file)
done
cd ../../
echo -e 
}

# make the magic happen

checkdirectory

echo -e "Welcome to Ghost External Links!"
echo "Please choose an action, type 'install' or 'remove': "
read action
echo

if [ $action = "install" ]; then
	enumerateThemes
	# collectWhitelist # prompt the user for a whitelist of domains
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