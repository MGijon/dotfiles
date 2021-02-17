"""Cleaning from files (moving them to their corresponding files) the next directories:
   - Downloads.
   - Desktop.
"""
import os, shutil, pdb

directories_to_be_cleaned = [os.path.expanduser("~/Downloads"), 
                             os.path.expanduser("~/Desktop")]
images_destiny = os.path.expanduser("~/Documents/Pictures")
original_number_of_images = len(os.listdir(os.path.expanduser(images_destiny)))

for directory in directories_to_be_cleaned:
    current_files = os.listdir(os.path.expanduser(directory))
    print("\n" + "Directory: " + directory + "\n")
    for file in current_files:
        try:
            # Move images
            if file.endswith(".png") or file.endswith(".jpg") or file.endswith("svg"):
                # Clean problematic characters changing the name 
                original_name = file
                new_name = file.replace(" ", "_")
                os.rename(src=directory + "/" + original_name, 
                          dst=directory + "/" + new_name)
                #print(original_name, "  =>  ", new_name)
                # Move file
                try:
                    shutil.move(src=directory + "/" + new_name, 
                                dst=images_destiny + "/" + new_name)
                    # set back the original name if it has been moved
                    os.rename(src=images_destiny + "/" + new_name, 
                              dst=images_destiny + "/" + original_name)
                except:
                    # set back the original name if it has not been moved
                    os.rename(src=directory + "/" + new_name, 
                              dst=directory + "/" + original_name)
                    pass

            # Move other kind of files
        except Exception as e:
            print(e)
            pass
        
print("\n")

final_number_of_images = len(os.listdir(os.path.expanduser(images_destiny)))
print("Number of pictures before the process: ", original_number_of_images)
print("Number of pictures after the process:  ", final_number_of_images, " (+", (final_number_of_images - original_number_of_images)/original_number_of_images * 100, "%)")
