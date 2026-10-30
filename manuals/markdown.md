# Markdown basics

## Text formating

| You write                         | You get                                   |
|-----------------------------------|-------------------------------------------|
| `# Chapter title`                 | chapter (exactly one per file, at the top) |
| `## Section`                      | section                                   |
| `### Subsection`                  | subsection                                |
| empty line                        | new paragraph                             |
| `*italic*`, `**bold**`            | *italic*, **bold**                        |
| `` `B501` ``                      | `monospace` (room numbers, codes…)        |
| `- item` (each on its own line)   | bullet list                               |
| `1. item`                         | numbered list                             |

Chapters are ordered by their file name: `1.md`, `2.md`, …, `10.md`, … and then
the appendices `A.md`, `B.md`, … To add a chapter, just create the next file.
Numbers of chapters are assigned automatically, never write them into titles.

## Links

* **Web page:** `[text of the link](https://example.com/page)`.
  In the PDF, the address is automatically added as a footnote – do not write
  it there yourself.
* **Address shown as is:** `<https://example.com>` or `<kr@listopad.koleje.cuni.cz>`.
* **Another place in the guidebook:** `[Cyklostezka](#cyklostezka)` – works
  across chapters too. The part after `#` is the heading text in lowercase,
  without diacritics, spaces replaced by `-`, punctuation removed:
  `## Studovna na A / Počítačová laboratoř (Lab)` →
  `#studovna-na-a-pocitacova-laborator-lab`.
* `[](#cyklostezka)` (empty text) is replaced by the heading title,
  `[#](#jidlo-piti-a-obchody)` by the number of the chapter (`10`) or appendix
  (`A`). Use it for "see chapter 10" so the number never gets out of date:
  `viz kapitola [#](#jidlo-piti-a-obchody)`.
* If a heading appears twice, the second one gets `-1` appended
  (`#menza-1`). You can also give a heading a fixed name:
  `## Menza {#menza-oteviraci-doba}`.
* A broken internal link is reported as a warning during the build.

## Footnotes

```markdown
I přes tvrdé a krvavé boje[^1], které …

[^1]: Text of the footnote, may contain [links](https://example.com).
```

Write the footnote text anywhere in the same file (usually at its end). Labels
(`1`, `2`, `note`…) only need to be unique within one file; numbering is done
automatically.

## Tables

```markdown
| Co        | Kde          | Za kolik        |
|-----------|--------------|-----------------|
| Vysavač   | Vrátnice A, B | 5 Kč / 30 min  |
```

A table without a header: leave the first row empty (`|   |   |`).
Columns don't need to be aligned.

## Pictures

```markdown
![Plánek buňky](images/bunka.svg)
```

Put the file into `cs/images/` or `en/images/`. SVG is best (sharp in print),
PNG/JPG work too. Add `{width=60%}` after the picture to make it smaller.

## Title page and date

Title, intro bullets, QR codes and the "last updated" date are in
`cs/metadata.yaml` / `en/metadata.yaml`. If you comment out the `date:` line, the
date of the build is used.
