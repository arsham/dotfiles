# Dotfiles

This repository holds my dotfiles. This setup is only testes on Arch Linux.

This setup uses GNU's [stow](https://www.gnu.org/software/stow/) for managing
the symlinks.

If you need only the `nvim` setup:

```bash
stow nvim
```

## Nvim

Almost everything is setup with lua. The aim to have a fast start-up time and
provide the functionalities I need for day-to-day tasks. At the moment it takes
about 20ms to start.
