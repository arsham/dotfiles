# Dotfiles

This repository holds my dotfiles. This setup is only testes on Arch Linux.

This setup uses GNU's [stow](https://www.gnu.org/software/stow/) for managing
the symlinks.

If you need only the `nvim` setup:

```bash
stow nvim
```

## Polybar

![Polybar](./polybar/.config/polybar/images/polybar.laptop.1.png?raw=true "Polybar")

I've tried to make this work on my laptop, which has a HiDPI setup, and on my
desktop. They share most of the setup, however they come with specific
configurations.

## Nvim

Almost everything is setup with lua. The aim to have a fast start-up time and
provide the functionalities I need for day-to-day tasks. At the moment it takes
about 20ms to start.

You can read more about it [here](./nvim/.config/nvim/README.md).

## Tmux

Nothing special [here](./tmux/.tmux.conf), just is functional with my vim
setup.

## Kitty

I have disabled a few of the default key bindings because I wanted full control
to what I can do with vim.

## Sublime text

I have been using ST for years and I absolutely love it. But I have stopped
using it as I found myself more productive with vim.
