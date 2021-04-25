"""Cleaning files (moving them to their corresponding files) the next directories:
   - Downloads.
   - Desktop.
"""
import os, shutil, pdb

directories_to_be_cleaned = [os.path.expanduser("~/Downloads"), 
                             os.path.expanduser("~/Desktop")]
images_destiny = os.path.expanduser("~/Documents/Pictures")

#### 
#files_moved = {1: ["Python", 33.2, 'UP'], 2: ["Java", 23.54, 'DOWN'], 3: ["Ruby", 17.22, 'UP'], 10: ["Lua", 10.55, 'DOWN'], 5: ["Groovy", 9.22, 'DOWN'], 6: ["C", 1.55, 'UP']}                         # to save all the data
#print ("{:<8} {:<15} {:<10} {:<10}".format('Pos','Lang','Percent','Change'))
#for k, v in files_moved.items():
#    lang, perc, change = v
#    print ("{:<8} {:<15} {:<10} {:<10}".format(k, lang, perc, change))


#dota_teams = ["Liquid", "Virtus.pro", "PSG.LGD", "Team Secret"] 
#data = [[1, 2, 1, 'x'], ['x', 1, 1, 'x'], [1, 'x', 0, 1], [2, 0, 2, 1]] 
#format_row = "{:>12}" * (len(dota_teams) + 1)
#print(format_row.format("", *dota_teams))
#for team, row in zip(dota_teams, data):
#    print(format_row.format(team, *row))

cols_names=["", "Original", "Final", "Moved", "Variation (%)"]
data_to_display_images={
    "Desktop": ["-", "-", "-", "-"],
    "Downloads": ["-", "-", "-", "-"],
    "Pictures": ["-", "-", "-", "-"],
}

########################


original_number_of_images = len(os.listdir(os.path.expanduser(images_destiny)))  # save for statistics

for directory in directories_to_be_cleaned:
    current_files = os.listdir(os.path.expanduser(directory))
    

    ## FXXXX THIS
    #data_to_display_images[directory.split("/")[-1]][1] = len(current_files)  ## All files 

    print("Cleaning images from: " + directory)
    for file in current_files:
        try:
            # Move images
            if file.endswith(".png") or file.endswith(".jpg") or file.endswith("svg") or file.endswith(".jpeg"):
                # Clean problematic characters changing the name 
                original_name = file
                new_name = file.replace(" ", "_")
                os.rename(src=directory + "/" + original_name, 
                          dst=directory + "/" + new_name)
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

    
    # Update information about this directory
    data_to_display_images[directory.split("/")[-1]][1] = original_number_of_images
    data_to_display_images[directory.split("/")[-1]][2] = 99
    data_to_display_images[directory.split("/")[-1]][3] = 99

print("\n")

final_number_of_images = len(os.listdir(os.path.expanduser(images_destiny)))
print("Number of pictures before the process: ", original_number_of_images)
print("Number of pictures after the process:  ", final_number_of_images, " (+", (final_number_of_images - original_number_of_images)/original_number_of_images * 100, "%)")



# Print the statistics of the images moved
print("{:<10} {:<10} {:<10} {:<10} {:<10}"\
    .format(cols_names[0], cols_names[1], cols_names[2], cols_names[3], cols_names[4]))
j = 23
for i in data_to_display_images: 
    print("{:<10} {:<10} {:<10} {:<10} {:<10}"\
        .format(i, data_to_display_images[i][0], data_to_display_images[i][1], data_to_display_images[i][2], data_to_display_images[i][3]))
