import os, sys, locale
from os.path import expanduser
import abc


class Movement:
    pass


class FileMovementInterface(abc.ABC):
    def move():
        pass


class ImageMovement(FileMovementInterface):
    pass


class VideoMovement(FileMovementInterface):
    pass


class DocumentsMovement(FileMovementInterface):
    pass


class ScreenShootsMovement(FileMovementInterface):
    pass


def _mapping_origin_destination() -> dict[str, str]:
    home_path: str = expanduser("~")
    return {
        "images": {"origin": f"{home_path}/", "destination": "" f"{home_path}/"},
        "videos": {"origin": f"{home_path}/", "destination": "" f"{home_path}/"},
        "documents": {"origin": f"{home_path}/", "destination": "" f"{home_path}/"},
        "screenshoots": {"origin": f"{home_path}/", "destination": "" f"{home_path}/"},
        "others": {"origin": f"{home_path}/", "destination": "" f"{home_path}/"},
    }


def _obtain_route_to_downloads(translated_name: str) -> str:
    home_path: str = expanduser("~")
    return f"{home_path}/{translated_name}/"


def _obtain_list_of_files_to_move(path: str) -> list[str]:
    try:
        return os.listdir(path)
    except FileNotFoundError:
        print("The file has not been found")


def _move_images(file: str, origin: str, destination: str) -> None:
    pass


def _move_videos(file: str, origin: str, destination: str) -> None:
    pass


def _move_documents(file: str, origin: str, destination: str) -> None:
    pass


def _move_screenshoots(file: str, origin: str, destination: str) -> None:
    pass


def _move_others(file: str, origin: str, destination: str) -> None:
    pass


def _is_image(file: str):

    pass


def _is_screenshoot(file: str):

    pass


def move_files(list_of_files: list[str]) -> None:
    map_origin_destination: dict[str, str] = _mapping_origin_destination()
    print(map_origin_destination)
    images_routes = map_origin_destination["images"]
    for file in list_of_files:
        if _is_image(file=file):
            if _is_screenshoot(file=file):
                _move_screenshoot(
                    file=file,
                    origin=images_routes["origin"],
                    destination=images_routes["destination"],
                )
            else:
                _move_images(
                    file=file,
                    origin=images_routes["origin"],
                    destination=images_routes["destination"],
                )


if __name__ == "__main__":
    path_to_downloads: str = _obtain_route_to_downloads(translated_name="Downloads")
    list_of_files: list[str] = _obtain_list_of_files_to_move(path_to_downloads)
    move_files(list_of_files)
