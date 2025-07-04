#!/bin/bash -e

# Default directory if no arguments are provided
default_dir=$(realpath .)

# Check the number of arguments
if [ $# -eq 0 ]; then
    # No arguments: use the default directory
    read -t 15 -p "Enter folder to display (or press Enter to use default, $default_dir): " dir
    if [ -z $dir ]; then 
       dir=$default_dir
    fi
elif [ $# -eq 1 ]; then
   dir="$1"
elif [ $# -eq 2 ]; then
   if [ $1 == "-a" ]; then
      echo "[Desktop Entry]
Type=Application
Name=slideshow
Exec=/bin/bash -c \"$(realpath $0) $(realpath $2)\"" > $HOME/.config/autostart/slideshow.desktop
   fi

else
   # More than one argument: show usage help
   echo "Usage: $0 [directory]"
   echo "If no directory is provided, it uses the default."
   exit 1
fi

# Run slideshow through Gnome Image Viewer if directory exists
if [ -n "$dir" ]; then
   if [ -d "$dir" ]; then
      eog --slide-show "$dir"
   else
      echo "Directory not found: $dir"
      exit 1
   fi
fi
