# TGEnv Documentation

This directory contains the [Docusaurus](https://docusaurus.io/) site that
powers the public TGEnv documentation hosted on GitHub Pages.

## Local Development

```bash
cd docs
npm install
npm start
```

The dev server starts at `http://localhost:3000/tgenv/` with hot reload.

## Build

```bash
npm run build
```

The static site is emitted under `docs/build/`.

## Deployment

Deployment is automated by `.github/workflows/deploy-docs.yml`. Every push to
`main` that touches the `docs/` directory builds the site and publishes it to
the `gh-pages` branch, which GitHub Pages serves at
`https://tgenv.github.io/tgenv/`.

To trigger a manual deploy from your workstation (requires push permission on
the repository), run:

```bash
GIT_USER=<your-github-username> npm run deploy
```

## Authoring Content

- Documentation pages live under `docs/`.
- The sidebar layout is declared in `sidebars.js`.
- Theme tokens and the gradient palette are defined in `src/css/custom.css`.
- The landing page lives in `src/pages/index.js`.
- The logo is `static/img/logo.png`.

All written content must stay in English (`en-US`) and avoid emojis.
