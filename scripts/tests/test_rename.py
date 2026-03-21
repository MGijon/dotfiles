"""Tests for rename.py using the Given/When/Then convention."""

import os

from rename import rename_files


class TestRenameFiles:
    def test_renames_files_with_extension(self, tmp_path):
        # Given a directory with files that have extensions
        (tmp_path / "a.jpg").touch()
        (tmp_path / "b.jpg").touch()
        (tmp_path / "c.jpg").touch()

        # When rename_files is called with a pattern
        rename_files(str(tmp_path), "photo")

        # Then files are renamed with the pattern and consecutive indexes
        result = sorted(os.listdir(tmp_path))
        assert result == ["photo1.jpg", "photo2.jpg", "photo3.jpg"]

    def test_renames_files_without_extension(self, tmp_path):
        # Given a directory with files that have no extension
        (tmp_path / "fileA").touch()
        (tmp_path / "fileB").touch()

        # When rename_files is called with a pattern
        rename_files(str(tmp_path), "item")

        # Then files are renamed with no extension appended
        result = sorted(os.listdir(tmp_path))
        assert result == ["item1", "item2"]

    def test_renames_files_with_multiple_dots_in_name(self, tmp_path):
        # Given a file whose name contains multiple dots
        (tmp_path / "my.backup.tar.gz").touch()

        # When rename_files is called
        rename_files(str(tmp_path), "archive")

        # Then only the last extension is preserved
        result = os.listdir(tmp_path)
        assert result == ["archive1.gz"]

    def test_renaming_is_sorted_alphabetically(self, tmp_path):
        # Given files whose alphabetical order differs from creation order
        (tmp_path / "zebra.png").touch()
        (tmp_path / "alpha.png").touch()
        (tmp_path / "mango.png").touch()

        # When rename_files is called
        rename_files(str(tmp_path), "img")

        # Then indexes follow alphabetical order of original names
        result = sorted(os.listdir(tmp_path))
        assert result == ["img1.png", "img2.png", "img3.png"]

    def test_empty_directory_renames_nothing(self, tmp_path):
        # Given an empty directory
        # When rename_files is called
        rename_files(str(tmp_path), "file")

        # Then the directory remains empty
        assert os.listdir(tmp_path) == []

    def test_mixed_extensions_are_preserved(self, tmp_path):
        # Given a directory with files of different extensions (a < b < c alphabetically)
        (tmp_path / "a.jpg").touch()
        (tmp_path / "b.png").touch()
        (tmp_path / "c.gif").touch()

        # When rename_files is called
        rename_files(str(tmp_path), "media")

        # Then each file keeps its own extension, indexed by alphabetical filename order
        result = sorted(os.listdir(tmp_path))
        assert result == ["media1.jpg", "media2.png", "media3.gif"]

    def test_counter_does_not_skip_on_success(self, tmp_path):
        # Given three files
        for name in ["x.txt", "y.txt", "z.txt"]:
            (tmp_path / name).touch()

        # When rename_files is called
        rename_files(str(tmp_path), "doc")

        # Then indexes are consecutive with no gaps
        result = sorted(os.listdir(tmp_path))
        assert result == ["doc1.txt", "doc2.txt", "doc3.txt"]

    def test_single_file_is_renamed(self, tmp_path):
        # Given a directory with a single file
        (tmp_path / "lonely.md").touch()

        # When rename_files is called
        rename_files(str(tmp_path), "note")

        # Then the file is renamed to pattern + index 1
        result = os.listdir(tmp_path)
        assert result == ["note1.md"]
