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
    "/.config/zathura"
]
sources = [
    "awesome",
    "alacritty",
    "lf",
    "nitrogen",
    "pcmanfm",
    "zathura"
]

for source, destination in zip(sources, destinations):
    symlink(source, destination)