parse

checkdirectory () 
{
if [ ! -d ./core ]; then
	echo -e "Exiting: current directory is not a Ghost root"
	exit 1
else
	echo "Directory check: [OK]"
fi;
}

enumerate_themes () 
{
dirs=();
cd ./content/themes
for file in ./*; do
	dirs=(${dirs[@]} $file)
done
cd ../../
}




# make the magic happen

checkdirectory
enumerate_themes





#checks
for item in ${dirs[*]};
do
    printf "   %s\n" $item
done