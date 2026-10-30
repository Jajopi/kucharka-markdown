# Kolejní kuchařka / Dormitory Guidebook

Public markdown version of Dormitory guidebook of 17. listopadu dormitory in Prague.

## Live view

The HTML version is currently published at <https://1011439.xyz/kucharka/>.

To see the current PDF version, look into "Releases" (<https://github.com/Jajopi/kucharka-markdown/releases/tag/latest>).

Both versions are rebuilt at every change in the main branch of this repository.

## Sources

The content here comes from original Kuchařka (version from 2025-10)
which can be found on the
[17. listopadu dormitory council website](https://listopad.koleje.cuni.cz/dokumenty/kucharka.pdf).

Only automatic grammar corrections have been applied so far.
However, there is a list of [possible issues](./issues.md) in the text which are waiting to be corrected.
They have been identified using LLM, so some of them may be false positives.

## Contributing

If you want to propose specific changes, you can fork the repository, make the changes there and open a Pull request.
There is a [picture manual for contributing](./manuals/contributing.md) with more details.

If you find an error which you do not want to correct yourself, you can open an Issue
(navigate to the Issues in the top bar, use a green button "New issue").
The first option is highly prefered, though.

## Editing the text

You can edit the files directly on GitHub (pencil icon) – no installation needed.
It is also possible to preview the text while editing.
Once you commit the changes (green button), the new PDF and HTML appears in the `latest` release,
usually within a few minutes.

There is also a [short manual for editing the text in the Markdown format](./manuals/markdown.md).

## Structure

```
cs/               Czech version
  metadata.yaml     title page, date…
  1.md … 14.md      chapters
  A.md … D.md       appendices
  images/           pictures
en/               English version
  ...               ...
templates/        pandoc templates, styles and filters
Makefile          build commands
.github/          automatic release configs
```

Every push to `master` builds everything and publishes it as the
[`latest` release](../../releases/tag/latest); every pushed tag (e.g. `v2025-10`)
creates a release of its own.

## Building the files locally

Requirements (see `.github/workflows/build.yml` for the exact list used in CI):

* [pandoc](https://pandoc.org/installing.html) ≥ 3.1.2
* XeLaTeX with KOMA-Script, `qrcode`, `footnotebackref`, Czech hyphenation and
  Latin Modern fonts
  (Debian/Ubuntu: `texlive-xetex texlive-latex-extra texlive-lang-czechslovak fonts-lmodern`;
  Arch: `texlive-xetex texlive-latexextra texlive-langczechslovak texlive-fontsrecommended`)
* `rsvg-convert` (package `librsvg2-bin` / `librsvg`) for SVG pictures in the PDF
* `zip` and `make`

```sh
make            # everything into build/
make pdf        # build/kucharka-cs.pdf, build/kucharka-en.pdf
make html       # build/kucharka-cs.html, build/kucharka-en.html (single file)
make chunked    # build/html-cs/, build/html-en/ (one page per chapter)
make cs-pdf     # just one language and format (also en-pdf, cs-html, …)
make clean      # remove build/ and temporary files
```
