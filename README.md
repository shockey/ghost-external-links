**Ghost External Links** uses jQuery to add the `target="_blank"` attribute to HTML links that don't match a whitelist, so they'll open in a new tab or window.

It also includes an easy-to-use installer that makes up for the lack of a Ghost plugin engine.

# Usage
### Quick Start
1. Change directories to your Ghost root.
2. Run this command: `git clone https://github.com/kyleshockey/ghost-external-links.git && chmod +x ./ghost-external-links/install.sh && ./ghost-external-links/install.sh`.

### Manual Installation
1. Clone this repository into your Ghost blog's root directory: `git clone https://github.com/kyleshockey/ghost-external-links.git`.
2. Edit the `excluded` array in `ghost-external-links.js` to your liking.
3. Copy `ghost-external-links.js` into the `assets/js` folder of any themes you want to run.
4. Insert `<script src="/assets/js/ghost-external-links.js"></script>` into the `default.hbs` file of any themes you want to run, below `{{ghost_foot}}`.

### Quick Remove
1. Change directories to your Ghost root.
2. Run the removal script: `./ghost-external-links/install.sh`.

# Dependencies
- Script
  - jQuery
- Installer
  - Bash
  - sed

# Contributions
Contributions are welcome! Feel free to fork this repository and create a pull request for any changes you make. There's a todo list on the wiki.
