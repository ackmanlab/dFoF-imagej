//dF/F image stack, James B. Ackman 2012-02-14, update 2014-02-21 09:44:13, 
// update 2016-09-19 by Sydney C. Weiser
// this macro will (1) reduce an open image stack in half
// (2) create an average image in the z-dimension
// (3) calc dF/F image stack
// Uncomment the lines 21 run("Size..." ...) as well as the filenames at line 14,32 if you want to downsample the movie size
// To run without the autosave option, comment out the lines 62
// Comment out lines 41-58 if you don't want to auto adjust the contrast

useDialogBox = 1; // disable this if you'd prefer not to have a dialog box to select slice
writeAvi = 0; // enable for automatic .avi saving

name1=getTitle;
//selectWindow(name1)
directory=getInfo("image.directory"); 
//name=getInfo("image.filename"); 
nn=replace(name1, ".tif", "-dFoF.avi"); 
//nn=replace(name1, ".tif", "-dFoF-50fps-halfsz.avi"); 
fnm=directory+nn; 
//print(fnm)

n = nSlices;
w = getWidth/2;
h = getHeight/2;
//run("Size...", "width=w height=h depth=n constrain interpolation=None");  

if (useDialogBox == 1) {
	Dialog.create("Set dFoF Frame Range"); 
	Dialog.addMessage("Set Start and End Frames"); 
	Dialog.addNumber("Start:", 1); 
	Dialog.addNumber("End:", n); 
	Dialog.show(); 
	startval = Dialog.getNumber(); 
	endval = Dialog.getNumber(); 
}
else {
	startval = 1;
	endval = n;
}

run("Z Project...", "start=" + startval + " stop=" + endval + " projection=[Average Intensity]");
name2=getTitle;
imageCalculator("Subtract create 32-bit stack", name1,name2);
name3=getTitle;
run("Jet");
imageCalculator("Divide create 32-bit stack", name3,name2);
name4=getTitle;

selectWindow(name2);
nn2=replace(name1, ".tif", "_AVG.tif");
//nn2=replace(name1, ".tif", "_AVG-halfsz.tif");
fnm2=directory+nn2;
saveAs("Tiff", fnm2);
name2=getTitle;

selectWindow(name4);
rename(nn);
name4=getTitle;

Stack.getStatistics(voxelCount, mean, min, max, stdDev);
print("stats");
print("   voxels: "+voxelCount);
print("   min: "+min);
print("   max: "+max);
print("   mean: "+mean);
print("   std dev: "+stdDev);
newMin=-3*stdDev;
newMax=7*stdDev;
//print("   new min: "+newMin);
//print("   new max: "+newMax);

//run("Brightness/Contrast...");
setMinAndMax(newMin, newMax);

getMinAndMax(min, max);
print("   new min: "+min);
print("   new max: "+max);

close(name1);
close(name3);

if (writeAvi){
  run("AVI... ", "compression=JPEG frame=50 save=&fnm");
	doCommand("Start Animation [\\]");
}

//close(name2);
//close(name4);

