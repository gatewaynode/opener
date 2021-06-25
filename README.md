# opener
A simple bash script designed for use with `fzf` preview but maybe useful in other ways?

Instead of showing the usual directory error with the fancy `bat` preview in `fzf` this checks if the finding is a directory and calls the `tree` command with a depth of 3.

**Prerequisites**

`tree`

```bash
sudo apt update; sudo apt install -y tree
```

## Usage

```bash
alias fz="find . -maxdepth 1 | fzf --preview './opener.bash {}'"
```
