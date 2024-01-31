//User define the directory to analyse, named dir
dir = getDirectory("Choose directory"); 
//Grab all file at the location dir
list = getFileList(dir);

//loop through all files
for (i=0; i<list.length; i++) {
open(list[i]); // open the file
run("HiLo"); // HiLo LUT
//or any other manipulation before used input


//user input, select the region to keep
waitForUser("Manual crop");

//if any other image manipulation after user input

if(selectionType != -1){ //if selection is not empty, clear outside
run("Clear Outside", "stack");}
run("Grays"); //change back LUT to gray
run("Save"); //save on top. Warning, erase!
run("Close"); //close the image
}
//end of the loop and end of the macro