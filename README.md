# J-unicode-conceal
Conceal J code with unicode characters.

A unicode-supporting font is required to view the document j.vim correctly,
as well as code written using this conceal library.

## Steps
- Install a unicode font like Iosevka.
- Use https://github.com/guersam/vim-j for basic J highlighting.

- Also set
```
setlocal conceallevel=2
set concealcursor=ncv
```
in your vimrc file to conceal the characters with their unicode equivalent.

- Finally, place `j.vim` in your `~/.config/nvim/after/syntax/` directory,
assuming neovim (or equivalent for vim).
