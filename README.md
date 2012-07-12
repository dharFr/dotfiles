My own custom dotfiles
======================

"Githubed" dotfiles seems to be a good idea. Let try this...

If this looks interesting to you too, you probably want to read http://dotfiles.github.com/

The core logic (mainly `bootstrap.sh`) came from [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), 
as well as the *Installation* doc bellow. 

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/mathiasbynens/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
./bootstrap.sh -f
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/mathiasbynens/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

To update later on, just run that command again.