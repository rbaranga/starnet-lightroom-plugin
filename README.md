# Description
Lightroom Classic (LR) plugin for running starnet++ on one or more images. Currenty only available for OSX, MR for adding windows support more than welcome. Builds on the awsome work of Mikita from https://www.starnetastro.com

# Installation
1. Download the "Starnet.lrplugin" subfolder and add it to LR's Plugin Manager
2. Open the plugin settings and click on "Initialize" to download starnet++ (~210MB)

# Usage
Right click on starry file(s) and choose Export -> Startnet -> Remove stars

# Troubleshooting
A "Remove stars" export preset should be added automatically. If it's not picked up by LR, you can add it manually (Show package content => preset => d&d "Remove stars.lrtemplate" to LR's export)

If you get some error about permission denied when running starnet++, the +x flag might be missing. Should be able to fix it by clicking the button in the plugin's health area (Plugin manager => Starnet)

If you encounter any issues feel free to report them on GitHub but keep in mind this is a free time project so don't expect immediate replies or fixes. If you can provide a MR to fix it, that would speed things up considerably
