//dF/F image stack, James B. Ackman 2012-02-14, update 2014-04-18 13:55:00
// this macro can 
// (1) Concatenate multiple image timeseries stacks (multiple tiff stacks) if nImages>1. Make the stacks are opened in order.
// (2) reduce an open image stack in half if halfsz==1 (default is halfsz==0)
// (3) create an average image over time (z-dimension)
// (4) calc dF/F image stack
// (5) Auto save the average image in original directory
// (6) Auto save an .avi movie in original directory

var name1;
var fnm;
var id=1; //initial image id for filepath and image title
var nn;
var halfsz=0; //binary T/F on whether to downsample the movie
var directory;

if (nImages==0) {
  print("No images are open");
} else if (nImages==1) {
  getNamePath(id);
  dFoFautoSave(name1,fnm,nn,directory,halfsz);
} else if (nImages>1) {
  getNamePath(id);
  catImages(name1);
  dFoFautoSave(name1,fnm,nn,directory,halfsz);
}

function getNamePath(id) {
  selectImage(id);
  name1=getTitle;
  directory=getInfo("image.directory");  
  nn=replace(name1, ".tif", "-dFoF-50fps.avi");  
  fnm=directory+nn;
  return name1;
  return fnm;
  return nn;
  return directory;
}

function catImages(name1) {
  run("Concatenate...", "all_open title=&name1");
}

function dFoFautoSave(name1,fnm,nn,directory,halfsz) {
//selectWindow(name1)
n=nSlices();
w=getWidth/2;
h=getHeight/2;
if (halfsz>0) {
  run("Size...", "width=w height=h depth=n constrain interpolation=None"); 
} 

nn2=replace(name1, ".tif", "_AVG.tif");
fnm2=directory+nn2;
run("Z Project...", "start=1 stop=n projection=[Average Intensity]");
saveAs("Tiff", fnm2);
name2=getTitle();

imageCalculator("Subtract create 32-bit stack", name1,name2);
name3=getTitle();
run("Jet");
imageCalculator("Divide create 32-bit stack", name3,name2);
name4=getTitle();
selectWindow(name4);
rename(nn);
name4=getTitle();

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

run("AVI... ", "compression=JPEG frame=50 save=&fnm");
doCommand("Start Animation [\\]");

//close(name2);
//close(name4);
}
