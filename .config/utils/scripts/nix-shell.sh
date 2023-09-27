#!/usr/bin/zsh

nix-shell() {
    NIX_SHELL_PRESERVE_PROMPT=1 command nix-shell
}
