# PDFM - Personal Dot File Manager

##### Note: pdfm is a new and undertested project, if you encounter any bugs please open a issue.

<img src="./pdfm.svg" height="1%" width="60%" />

## Installation
As of right now the only way to install pdfm is using `git clone`:
```
$ git clone https://gitlab.com/SupremeDeity/pdfm.git
$ cd pdfm
$ sudo cp pdfm.sh /usr/local/bin/pdfm
```
This clones the project into a `pdfm` folder and copies it to `/usr/local/bin` to make it globally available.


## Usage

**Initialize pdfm and git repository:**
```bash
pdfm init
```

**Note:** This will reinitialize the git repository if it already exists. You can just create a `track.pdfm` in your git home directory instead of using the command to avoid this.

## Trackfile
The track file `track.pdfm` is basically the opposite of what a `.gitignore` file is. This file __must__ include paths to everything that needs to tracked. This automatically gets created in the git directory when you run `pdfm init`.

You can either include a single file or a whole directory:
```
./directory/
./file.sh
/dir2/file
```

## Comments
Empty lines or any lines starting with "#" are ignored as of **v0.3.0**

## Staging

To stage all tracked files run the following command:
```
pdfm add
```
