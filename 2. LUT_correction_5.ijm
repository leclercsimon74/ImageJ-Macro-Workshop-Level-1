run("Close All"); //security
//User define the directory to analyse, named dir
dir = getDirectory("Choose directory"); 
//Grab all file at the location dir
list = getFileList(dir);

//loop through all files
for (i=0; i<list.length; i++) {
	open(list[i]); // open the file
	slice = nSlices; //get the number of slice in the stack
	setSlice(slice/2); // set the view to the middle of the stack
	Stack.setChannel(1); // select channel 1
	run("Blue"); //LUT Blue
	run("Enhance Contrast", "saturated=0.35 normalize"); //auto adjust brightness/contrast
	Stack.setChannel(2);
	run("Yellow");
	run("Enhance Contrast", "saturated=0.35 normalize");
	Stack.setChannel(3);
	run("Grays");
	run("Enhance Contrast", "saturated=0.35 normalize");
	Stack.setChannel(4);
	run("Green");
	run("Enhance Contrast", "saturated=0.35 normalize");
	Stack.setChannel(5);
	run("Red");
	run("Enhance Contrast", "saturated=0.35 normalize");
	//run("Save"); //save the adjusted image
	
	name = getInfo("image.filename"); //get the name of the image
	ddiir = getDirectory("image"); //get its location on the drive
	run("Z Project...", "projection=[Max Intensity]"); //make a max z project
	run("Make Composite"); //make a composite image of the z project
	Stack.setActiveChannels("11011"); // remove the gray channel
	run("Stack to RGB"); //transform as RGB image
	run("Scale Bar...", "width=10 height=20 thickness=10 font=24 color=White background=None location=[Lower Right] horizontal bold");
	rename("RGB_2"); //rename the RGB image
	selectWindow("MAX_"+name); //select the Z project image
	Property.set("CompositeProjection", "null"); //Stop the composite
	Stack.setDisplayMode("color"); //set the image to show the color
	run("RGB Color"); //make them RGB
	rename("RGB_1");
	//fuse both RGB image
	run("Concatenate...", "  title=RGB image1=RGB_1 image2=RGB_2 image3=[-- None --]");
	run("Make Montage...", "columns=3 rows=2 scale=0.5"); //make a montage
	saveAs("PNG", ddiir+'/'+name+".png"); // save the montage as png image
	run("Close All"); //close all open image to clean ImageJ
}
//end of the loop and end of the macro