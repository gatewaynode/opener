# opener
A simple bash script designed for use with `fzf` preview but maybe useful in other ways?

Instead of showing the usual directory error with the fancy `bat` preview in `fzf` this checks if the finding is a directory and calls the `tree` command with a depth of 3.

**Prerequisites**

This uses the program `tree` for graphical dir listings.

On Debian systems you can install it like so:

```bash
sudo apt update; sudo apt install -y tree
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
alias fz="find . -maxdepth 1 | sed 's/^\.\///g' | fzf --preview './opener.bash {}'"
```
