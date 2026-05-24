# TGEnv Documentation

This directory contains the [MkDocs](https://www.mkdocs.org/) site (using the
[Material theme](https://squidfunk.github.io/mkdocs-material/)) that powers the
public TGEnv documentation hosted on GitHub Pages.

## Requirements

- Python 3.x
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)

```bash
pip install mkdocs-material
```

## Local Development

```bash
cd docs
mkdocs serve
```

The dev server starts at `http://localhost:8000` with live reload.

## Build

```bash
mkdocs build
```

The static site is emitted under `docs/site/`.

## Deployment

Deployment is automated by `.github/workflows/deploy-docs.yml`. Every push to
`main` that touches the `docs/` directory builds the site and publishes it to
GitHub Pages at `https://tgenv.github.io/tgenv/`.

To trigger a manual deploy from your workstation (requires push permission on
the repository), run:

```bash
mkdocs gh-deploy --force
```

## Authoring Content

- Documentation pages live under `docs/`.
- The site structure and navigation are declared in `mkdocs.yml`.
- The logo is `static/img/logo.png`.

All written content must stay in English (`en-US`) and avoid emojis.
