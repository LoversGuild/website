This repository contains the source for the Lovers' Guild's website.

All contents are licensed under a [Creative Commons Attribution-NonCommercial-Share-Alike 4.0 International License][by-nc-sa-4].

[by-nc-sa-4]: http://creativecommons.org/licenses/by-nc-sa/4.0/

The site will be published at https://rakastajienkilta.fi (Finnish) and https://loversguild.org (English).

# Building

This site is built using a custom static site generator.
It is based on a library called [LoveGen][lovegen-repo].
To build the generator, run `cabal build generator` in the root directory of this repository.
To rebuild the website contents, run the script called `build` in the root of this repository.
The later command will also build the generator as needed.

[lovegen-repo]: https://github.com/LoversGuild/lovegen

# Editing the site

All site contents are in the `pages/`, `static/` and `templates/` directories within this repository.

Page contenst are written in the Markdown documentation format.
We use [Pandoc][pandoc] for rendering the page contents.
See [the Pandoc User's Guide][pandoc-guide] for details about Pandoc's extended Markdown syntax.

[pandoc]: https://pandoc.org/
[pandoc-guide]: https://pandoc.org/MANUAL.html

For page templates, we use Pandoc's templates.
These are also documented in Pandoc's manual.

Metadata for template substitution is partially autogenerated by LoveGen.
Most of the metadata is stored in YAML format in content pages' YAML metadata block.
Every subdirectory (under `pages/`) may also contain a `meta.yaml` file.
These files can be used to provide default template values for all pages in their directory and its subdirectories.
Metadata values in `meta.yaml` files deeper in directory hierarchy override values in parent `meta.yaml` files.
Metadata in content files overrides all values provided by `meta.yaml` files.

An exception to this overriding rule is that mapping values in metadata are combined and lists are concatenated to each other.


Rendered site is written to the `output/` directory.
LoveGen generates a hierarchical menu for every page.
Page hierarchy in the generated site is determined from the directory hiearchy of the original contents.
Every `pages/.../pagename.md` file is translated to HTML and written to `output/.../pagename/index.html`.

# Generatig the site

See instructions for generating the site in [LoveGen's repository][lovegen-repo].
