# fzf--previewer

A simple bash script designed for use with `fzf` preview but maybe useful in other ways?

`fzf --preview fzf--previewer`

Instead of showing the usual directory error or binary file warning with the fancy `bat` preview in `fzf` this script conditionally checks the selected file and previews a tree, a highlighted text, or a hex viewer.

## Prerequisites

This uses the programs: 
  * `bat`, for text file viewing
  * `tree`, for graphical dir listings
  * `hexyl`, for binary file viewing
  * `atool`, for view archive file content
  * `pdftotext` (poppler-utils), for PDF preview
  * `odt2txt`, simple converter from OpenDocument Text 
  * `catdoc` and `docx2txt`, for M\$-Office preview
  * [`ascii-image-converter`](https://github.com/TheZoraiz/ascii-image-converter) 
    for images

On Debian/Devuan based systems you can install them like so:

```bash
sudo apt update; sudo apt install -y bat tree hexyl atool poppler-utils odt2txt catdoc
```

Similarly, I use this with `fzf` (fuzzy finder), which you will need to follow the usage example.

```bash
sudo apt update; sudo apt install -y fzf
```

### Prerequisite Troubleshooting

I noticed `hexyl` is sometimes problematic to install from apt, here is a workaround to install from source.

```bash
sudo apt install build-essential
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
cargo install hexyl
```

Similarly `bat` doesn't seem to consistently install on Ubuntu/Debian, but you can install the Rust toolchain as per the previous `hexyl` workaround and:

```bash
cargo install bat
```

## Installing

I like to symlink this in `~/.local/bin` as `opener`.  So checkout the repo, then:

```bash
ln -s $HOME/opener/opener.bash $HOME/.local/bin/opener
```

Then you can add this alias to make `fzf` much more useful in file system discovery..

```bash
alias fz="find . -maxdepth 1 | sed 's/^\.\///g' | fzf --preview 'opener {}'"
```

# Usage

With the alias, running `fz` will give a searchable directory listing with a
preview for every filetype.  You should be able to use the up and down arrow
keys to navigate or just start typing and the fuzzy search will narrow down
what you want to find.  The preview is scrollable on some systems.  Hitting
`[ENTER]` will output the filename of the current selection.  Hitting
`[ESCAPE]` will exit the `curses` session.

NOTE: I've only tested this on Linux, but it might work elsewhere.
