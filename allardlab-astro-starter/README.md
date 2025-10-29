# Allard Lab — Astro Starter

A minimal Astro starter tailored to text, images, and links, with a dark CyPu theme and an optional Bluesky feed.

## Quick start

```bash
npm create astro@latest -- --template .
npm install
npm run dev
```

## Deploy to GitHub Pages

This repo already includes `.github/workflows/deploy.yml` using `withastro/action`.

- Ensure Pages is set to "GitHub Actions" in your repo settings.
- Push to `main` and the Action will build and deploy to the `gh-pages` branch automatically.

## Bluesky feed options

- **Single post embeds (official):** Paste their embed HTML into any page.
- **Timeline widget (third‑party):** Use `BlueskyTimeline.astro` component to inject a drop‑in script.
- **Build‑time feed (zero 3rd‑party JS):** Replace the component with a build script (TODO in comments).

## Structure

- `src/layouts/BaseLayout.astro` — shared head, meta, layout, and nav
- `src/components/Nav.astro` — top navigation for the six sections
- `src/components/BlueskyTimeline.astro` — quick timeline embed (swappable for build‑time approach)
- `src/styles/_colors.scss` and `src/styles/global.scss` — CyPu palette + global styles
- `src/pages/` — six site pages
