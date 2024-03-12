run("Close All"); //security
Dialog.create("Macro 4. Dialog options");
Dialog.addDirectory("to process", getDir("cwd"));
Dialog.addDirectory("to save", getDir("cwd"));
Dialog.setLocation(0, 0);
Dialog.show();
to_process_dir = Dialog.getString();
result_dir = Dialog.getString();

//result_dir = getDirectory("Choose directory to save to");
//to_process_dir = getDirectory("Choose directory to process");

list = getFileList(to_process_dir);

for (i=0; i<list.length; i++) {
	if (endsWith(list[i], ".tif")){ //only tif file
		processImage(to_process_dir+list[i], result_dir);
	}
}



function processImage(path, result_path){
	open(path);
	name = getTitle;
	sub_path = File.directory;
	sub_name = split(path, '\\');
	sub_name = sub_name[sub_name.length-2];
	new_name = sub_name+'_'+name;

	print(result_path+File.separator+new_name);
	
	Dialog.createNonBlocking("Manual crop");
	Dialog.addCheckbox("Pass this image", false); //if checked, will NOT process this image
	Dialog.setLocation(0, 0);
	Dialog.show();
	continue_choice = Dialog.getCheckbox();


	if (continue_choice == 0 && selectionType == 0){
	
		getSelectionBounds(x, y, width, height);
		
		if(height > width){
			dif = height - width;
			x = x - dif /2;
			width = width + dif/2;
		}
		if (width > height){
			dif = width - height;
			y = y - dif /2;
			height = height + dif /2;
		}
		
		makeRectangle(x, y, width, height);
		Stack.getPosition(channel, slice, frame);
		
		run("Duplicate...", "duplicate channels="+channel+" slices="+slice);
		run("Size...", "width=100 height=100 depth=1 constrain average interpolation=Bilinear");
	
	
		saveAs("Tiff", result_path+File.separator+new_name);
		run("Close All");
	
	}
	else{ // image is to be NOT process, close it
		run("Close");
	}
}	







