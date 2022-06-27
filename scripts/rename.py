"""Rename the files inside the folder with a given pattern and consecutive indexes.
   Arguments:
       -d  :  directory that contains the files
       -p  :  base pattern
"""
import os
import argparse

parser = argparse.ArgumentParser(description="Rename the files inside the folder")

parser.add_argument("-d", metavar="path", type=str, help="Direcectory")
parser.add_argument("-p", type=str, help="Pattern to be replicated")

args = parser.parse_args()
path = args.d
patt = args.p

counter = 1
for original_name in os.listdir(path):
    file_extension = original_name.split(".")[-1]
    original_file = path + "/" + original_name
    new_name_file = path + "/" + patt + str(counter) + "." + file_extension

    try:
        os.rename(original_file, new_name_file)
    except Exception as e:
        print(e)

    counter += 1

print("The name of ", str(counter - 1), " files has been change successfully!!")
