import os

DOTFILES_PATH = os.path.expanduser("~/awesomeDotfiles")

def symlink(source, destination):
    source = os.path.join(DOTFILES_PATH, source)
    destination = os.path.join(os.path.expanduser("~"), destination)


    # remove the destination if it is a folder, unlink if it is a symlink
    if os.path.isdir(destination):
        os.system(f"rm -rf {destination}")
    elif os.path.islink(destination):
        os.unlink(destination)
        
        

    print(f"Linking {source} to {destination}")
    os.symlink(source, destination)


destinations = [
    "/.config/awesome",
    "/.config/alacritty",
    "/.config/lf",
    "/.config/nitrogen",
    "/.config/pcmanfm",
    "/.config/zathura",
    "/.config/plank",
    "/.config/zsh",
    "/.config/obsidian",
    "/.config/onlyoffice",
    "/.config/rofi.rasi",
    "/.config/picom.conf",
]
sources = [
    "/configs/awesome",
    "/configs/alacritty",
    "/configs/lf",
    "/configs/nitrogen",
    "/configs/pcmanfm",
    "/configs/zathura",
    "/configs/plank",
    "/configs/zsh",
    "/configs/obsidian",
    "/configs/onlyoffice",
    "/configs/rofi.rasi",
    "/configs/picom.conf",
]

for source, destination in zip(sources, destinations):
    symlink(source, destination)