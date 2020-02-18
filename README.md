# LaTeX Template
Boilerplate for LaTeX Projects

These are a good number of the things I usually end up with in LaTeX projects
so I have thrown them together so I can fork this instead of starting from
scratch each time.

Essentially, run `make show` to build and look at the PDF.

Dynamically-generated plots are in `./plots`. The `Makefile` there controls
how they are built. If `mklatex` finds that some plot is missing, the rules to
create it are deferred to that `Makefile` from the main one.

There are also a few tools included to make editing a bit less awful. They are
generally intended to be used with Vim, but they are usable from the command
line as well. `source env.sh` to add them to the path. To use them from Vim,
start with `-S` as its last argument to have it parse `Session.vim`, which has
appropriate shortcuts defined.

`bin/edit-in-lyx` will allow editing some bit of LaTeX code in LyX. It's most
useful for graphical equation editing or manipulating more complex tables.
That is, highlighting a few lines in Vim, then pressing `<leader>L` (usually
`\L`) or `<leader>l<return>`will pop up LyX with those lines imported.

`bin/texpreview` will pop up an HTML preview of some arbitary bit of TeX. It
can be used to preview portions of the docunt in isolation. `<leader>p` to
access.

`bin/gscholar` will look up BibTeX references from Google Scholar. This one
might be easier to use interactively outside of Vim, but `<leader>gX<return>`
will replace the current line in vim with the first `X` results of that line
formatted for BibTeX.
