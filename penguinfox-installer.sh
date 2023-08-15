#!/usr/bin/env bash

# penguinFox
# Author: Khanh Hien Hoang (p3nguin-kun)
# GitHub: p3nguin-kun

CRE=$(tput setaf 1)
CYE=$(tput setaf 3)
CGR=$(tput setaf 2)
CBL=$(tput setaf 4)
BLD=$(tput bold)
CNC=$(tput sgr0)

backup_folder=~/.penguinFox-Backup
date=$(date +%Y%m%d-%H%M%S)

logo() {

	local text="${1:?}"
	echo -en "                                 
  	penguinFox Installer (Librewolf ver.)\n\n"
	printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}"
}

# Intro
clear
logo "Welcome!"
printf '%s%sThis script will automatically install penguinFox - my Firefox config to your system %s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
	read -rp " Do you want to continue? [y/n]: " yn
	case $yn in
	[Yy]*) break ;;
	[Nn]*) exit ;;
	*) printf "Just write 'y' or 'n'\n\n" ;;
	esac
done
clear

# Backup config files
logo "Backing-up your config files"
printf "Backup files will be stored in %s%s%s/.penguinFox-Backup%s \n\n" "${BLD}" "${CRE}" "$HOME" "${CNC}"

if [ ! -d "$backup_folder" ]; then
	mkdir -p "$backup_folder"
fi

for folder in chrome; do
	if [ -d "$HOME"/.librewolf/*.default-default/$folder ]; then
		mv "$HOME"/.librewolf/*.default-default/$folder "$backup_folder"/${folder}_$date
		echo "$folder folder backed up successfully at $backup_folder/${folder}_$date"
	else
		echo "The folder $folder does not exist in $HOME/.librewolf/"
	fi
done

for file in user.js; do
	if [ -e "$HOME"/.librewolf/*.default-default/$file ]; then
		mv "$HOME"/.librewolf/*.default-default/$file "$backup_folder"/${file}_$date
		echo "$file file backed up successfully at $backup_folder/${file}_$date"
	else
		echo "The file $file does not exist in $HOME/.librewolf/"
	fi
done

# Installing dotfiles
logo "Installing penguinFox..."
printf "Copying files to respective directories..\n"

for archivos in ~/penguinFox-Librewolf/*; do
	cp -R "${archivos}" ~/.librewolf/*.default-default/
	if [ $? -eq 0 ]; then
		printf "%s%s%s folder copied succesfully!%s\n" "${BLD}" "${CGR}" "${archivos}" "${CNC}"
	else
		printf "%s%s%s failed to been copied, you must copy it manually%s\n" "${BLD}" "${CRE}" "${archivos}" "${CNC}"
		sleep 1
	fi
done

# Removing unused files
logo "Removing unused files..."
rm -rf ~/.librewolf/*.default-default/.git ~/.librewolf/*.default-default/.github ~/.librewolf/*.default-default/penguinfox-librewolf.sh ~/.librewolf/*.default-default/README.md

logo "Done!"
printf "Completed penguinFox installation, now open Librewolf and enjoy!"
