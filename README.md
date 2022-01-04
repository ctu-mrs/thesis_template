# Bachelor / Master / Ph.D. Thesis template [![Build Status](https://github.com/ctu-mrs/thesis_template/workflows/CI/badge.svg)](https://github.com/ctu-mrs/thesis_template/actions)

## Editing the templates

**Please read this!!**
If you wish to edit the templates, please, **edit the files in the Devel branch**.
The **devel** branch contains more general structure with symlinks, which is not ideal for students.
The CI job on Github takes care of repacking everything nicely into what you see in the **master** branch.
The job takes approx. 5 minutes to run after you push to **devel**, so be patient.
See the [.ci/build.sh](.ci/build.sh) for more details.

### Bachelor

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/master/.fig/bachelor_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/master/bachelor_thesis_template.pdf)

### Master

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/master/.fig/master_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/master/master_thesis_template.pdf)

### Dissertation

[![This should be a thumbnail](https://github.com/ctu-mrs/thesis_template/raw/master/.fig/phd_thesis_thumbnail.jpg)](https://github.com/ctu-mrs/thesis_template/raw/master/phd_thesis_template.pdf)

## Linux dependencies for building LaTeX

```bash
sudo apt install texlive texlive-latex-extra texlive-lang-czechslovak texlive-science texlive-pstricks latexmk texmaker texlive-font-utils texlive-fonts-extra texlive-bibtex-extra biber okular pdf-presenter-console dvipng sketch
```

## Build using supplied Makefile

Build the pdf by running
```bash
make
```
in the thesis's folder.
The build is facilitated via `latexmk`.
The output will appear in the `build` subfolder.

## Switching between print and screen versions

The template supports outputting of two different versions of the thesis.

The **print** version has assymetric margins to compensate for the spine of the thesis.
Moreover, the **print** version adds white pages whenever neccessary (new chapters and standalone pages, e.g., before the copyright notice).

The **screen** version has symmetric margins and no filler white pages.

The print version is enabled by uncommenting the first line in the `main.tex` document:
```latex
\newcommand*{\printversion}{}%
```
