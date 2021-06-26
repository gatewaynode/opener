# opener
A simple bash script designed for use with `fzf` preview but maybe useful in other ways?

Instead of showing the usual directory error or binary file warning with the fancy `bat` preview in `fzf` this script conditionally checks the selected file and previews a tree, a highlighted text, or a hex viewer.

**Prerequisites**

This uses the programs: `bat`, for text file viewing; `tree`, for graphical dir listings; `hexyl`, for binary file viewing.

On Ubuntu based systems you can install them like so:

```bash
sudo apt update; sudo apt install -y bat tree hexyl
```

Similarly, I use this with `fzf` (fuzzy finder), which you will need to follow the usage example.

```bash
sudo apt update; sudo apt install -y fzf
```

## Usage

I like to symlink this in `~/.local/bin` as `opener`.  So checkout the repo, then:

```bash
ln -s $HOME/opener/opener.bash $HOME/.local/bin/opener
```

Then you can add this alias to make `fzf` much more useful in file system discovery..

```bash
alias fz="find . -maxdepth 1 | sed 's/^\.\///g' | fzf --preview 'opener {}'"
```

NOTE: I've only tested this on Linux, but it might work elsewhere.
