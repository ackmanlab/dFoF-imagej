# dFoF-imagej
ImageJ helper macros for calcium imaging timeseries

This repo contains some ImageJ macros for making a dF/F movie from an ImageJ timeseries array. Works best if file extension is '.ijm' and saved in your ImageJ application folder under `ImageJ/plugins/Macros/dFoFmovie.ijm` or `ImageJ/plugins/Macros/dFoFmovie-CatFullAutoSave.ijm` so that it can be simply run as a plugin. Requires a lut named 'Jet' in your ImageJ/Fiji installation under Image --> Lookup Tables (though it can be changed manually in the macro file to any color mapping you'd like). 

Learn more about the ImageJ macro language at [https://imagej.nih.gov/ij/developer/macro/macros.html](https://imagej.nih.gov/ij/developer/macro/macros.html). 

Also please see the many useful example macros that come with every ImageJ installation under `ImageJ/macros`. Just open these txt files in your text editor (Sublime Text, Atom, etc) and inspect what they do. These examples are invaluable for helping you learn to write your own macros. Also Fiji (ImageJ 'with batteries included') has an interactive interpreter for quick copy/paste/run of macro commands under Menu Plugins --> Scripting --> Macro Interpreter that is very useful while you trying to implement a routine.
