import os

def create_symlink(source, destination):
    try:
        os.symlink(source, destination)
        print(f"Symbolic link created from {source} to {destination}")
    except OSError as e:
        print(f"Failed to create symbolic link: {e}")

# Specify your source and destination paths
source_path = os.path.expanduser("~/awesome_Dotfiles/awesome")
destination_path = os.path.expanduser("~/.config/awesome")

# Call the function to create the symlink
create_symlink(source_path, destination_path)
