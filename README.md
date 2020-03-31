# GitHub Pages Site Rebuilder

This program triggers rebuilds of a GitHub pages website at 01:00,
05:00, 09:00, 13:00, 17:00 and 21:00 local time.


## Configuration

 - Generate a token at https://github.com/settings/tokens/new
 - Tick the `public_repo` scope under `repo`.
 - Click _Generate_ and make note of the token provided.
 - Copy `config-skeleton` to `config`.
 - Edit `config` and fill in the required values.

## Installation

### Vagrant VM

 - Run `vagrant up`

### Standalone

 - Run `make install`


## Removal

### Vagrant VM

 - Run `vagrant destroy -f`

### Standalone

 - Run `make uninstall`
