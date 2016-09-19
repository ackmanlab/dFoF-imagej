# dFoF-imagej
ImageJ helper macros for calcium imaging timeseries

This repo contains some ImageJ macros for making a dF/F movie from an ImageJ timeseries array. Works best if file extension is '.ijm' and saved in your ImageJ application folder under `ImageJ/plugins/Macros/dFoFmovie.ijm` or `ImageJ/plugins/Macros/dFoFmovie-CatFullAutoSave.ijm` so that it can be simply run as a plugin. Requires a lut named 'Jet' in your ImageJ/Fiji installation under Image --> Lookup Tables (though it can be changed manually in the macro file to any color mapping you'd like). 

Learn more about the ImageJ macro language at <a href="https://imagej.nih.gov/ij/developer/macro/macros.html">. Also please see lots of useful example macros that come with each ImageJ installation under `ImageJ/macros`.
