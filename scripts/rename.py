"""Rename the files inside the folder with a given pattern and consecutive indexes.
Arguments:
    -d  :  directory that contains the files
    -p  :  base pattern
"""

import os
import argparse


def rename_files(path: str, pattern: str) -> None:
    filenames = sorted(os.listdir(path))
    counter = 1
    success = 0

    for original_name in filenames:
        original_file = os.path.join(path, original_name)

        parts = original_name.rsplit(".", 1)
        if len(parts) == 2:
            new_name = f"{pattern}{counter}.{parts[1]}"
        else:
            new_name = f"{pattern}{counter}"
        new_file = os.path.join(path, new_name)

        try:
            os.rename(original_file, new_file)
            success += 1
            counter += 1
        except Exception as e:
            print(f"[ERROR] Could not rename '{original_name}': {e}")

    print(f"{success} of {len(filenames)} files renamed successfully.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Rename the files inside the folder")
    parser.add_argument("-d", metavar="path", type=str, required=True, help="Directory")
    parser.add_argument("-p", type=str, required=True, help="Pattern to be replicated")
    args = parser.parse_args()

    rename_files(args.d, args.p)
