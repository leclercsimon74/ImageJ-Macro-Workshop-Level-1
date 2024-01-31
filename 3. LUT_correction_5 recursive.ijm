run("Close All"); //security
dir = getDirectory("Choose directory");
listFiles(dir);

function listFiles(dir) {
   list = getFileList(dir);
   for (i=0; i<list.length; i++) {
      if (endsWith(list[i], "/")) //folder
         listFiles(""+dir+list[i]);
      if (endsWith(list[i], ".tif")) //images
      	 processImage(dir+list[i]);
   }
}

function processImage(path){
	open(path); //open
	slice = nSlices;
	setSlice(slice/2);
	Stack.setChannel(1);
	run("Blue");
	run("Enhance Contrast", "saturated=0.35 normalize");
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
	run("Save");
	
	name = getInfo("image.filename");
	ddiir = getDirectory("image");
	run("Z Project...", "projection=[Max Intensity]");
	run("Make Composite");
	Stack.setActiveChannels("11011");
	run("Stack to RGB");
	run("Scale Bar...", "width=10 height=20 thickness=10 font=24 color=White background=None location=[Lower Right] horizontal bold");
	rename("RGB_2");
	selectWindow("MAX_"+name);
	Property.set("CompositeProjection", "null");
	Stack.setDisplayMode("color");
	run("RGB Color");
	rename("RGB_1");
	run("Concatenate...", "  title=RGB image1=RGB_1 image2=RGB_2 image3=[-- None --]");
	run("Make Montage...", "columns=3 rows=2 scale=0.5");
	saveAs("PNG", ddiir+'/'+name+".png");
	run("Close All");
}