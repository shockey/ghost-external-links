**Ghost External Links** uses jQuery to add the `target="_blank"` attribute to HTML links that don't match a whitelist, so they'll open in a new tab or window.


#Quick Start
1. Clone this repository into your Ghost blog's root directory: `git clone https://github.com/kyleshockey/ghost-external-links.git`.
2. Change directories to the git repo you just cloned: `cd ghost-external-links`.
3. Make sure the installer script is executable: `chmod +x ./install.sh`.
4. Change directories back to your Ghost root: `cd ../`.
4. Run the installer:`./ghost-external-links/install.sh install`.

#Manual Installation
1. Clone this repository into your Ghost blog's root directory: `git clone https://github.com/kyleshockey/ghost-external-links.git`.
2. Edit the `excluded` array in `ghost-external-links.js` to your liking.
3. Copy `ghost-external-links.js` into the `assets/js` folder of any themes you want to run.
4. Insert `<script src="/assets/js/ghost-external-links.js"></script>` into the `default.hbs` file of any themes you want to run, below `{{ghost_foot}}`.
5. 

# Quick Remove
1. Change directories to your Ghost root.
2. Run the removal script: `./ghost-external-links/install.sh remove`.