# Allard Lab Website Migration & Modernization Plan
**Date:** 2025-10-27

## Goals
- Keep the site's focus on text, images, links.
- Preserve the **CyPu dark academic** aesthetic (navy background, cyan accents, light text)【21†Allard Lab Website Style Guide†L12-L31】.
- Embed a **Bluesky feed** (start with a turnkey script; later, consider build‑time static feed).
- Improve performance, accessibility, SEO, and GitHub Pages deployment.

## Phase 1 — Prep (Jekyll freeze)
1. Freeze Jekyll site (branch `jekyll-freeze`) so you can roll back anytime.
2. Inventory assets and content:
   - Pages: Home, Contact, Science, People, Publications, Software (1:1 mapping) — matches current navigation.
   - Copy all images into `/public/` in the new Astro project; convert large PNGs to WebP where sensible.
3. Extract style tokens from existing SCSS:
   - **Colors:** Navy `#1D3038`, Cyan `#45B29D`, Red `#BE1E2D`, Gold `#FEEB7C`, Light text `#E4E4E4`【21†Allard Lab Website Style Guide†L12-L31】.
   - **Typography:** primary font `"supria-sans", Arial, sans-serif`【21†Allard Lab Website Style Guide†L33-L42】.
   - Maintain the masthead white background for contrast on top section【21†Allard Lab Website Style Guide†L20-L31】【21†Allard Lab Website Style Guide†L44-L57】.

## Phase 2 — Astro scaffold
1. Use the provided starter (`allardlab-astro-starter.zip`) and `npm install`.
2. Set the site URL in `astro.config.mjs` to `https://www.allardlab.com` for correct canonical links and sitemap.
3. Copy your Markdown/HTML content into the new pages located in `src/pages/` (one file per section).

## Phase 3 — Theming
1. Paste palette into `src/styles/_colors.scss` and keep global rules in `src/styles/global.scss` (already provided).
2. Ensure link/hover states use Cyan (`#45B29D`) and Gold (`#FEEB7C`) for hover/active to match the style guide【21†Allard Lab Website Style Guide†L12-L31】.
3. Preserve masthead as white with bold titles to reflect your current masthead spec【21†Allard Lab Website Style Guide†L44-L57】.

## Phase 4 — Bluesky feed
**Option A (turnkey widget now):**
- Use `<BlueskyTimeline handle="@YOUR_HANDLE" />` component (script-based).

**Option B (single post embeds):**
- Paste the official post embed HTML anywhere on a page.

**Option C (build‑time static feed, zero JS):**
- Add a small Node script in `scripts/` that calls Bluesky’s API during CI and writes `src/pages/news.astro` from a template.
- Wire it into the GitHub Action before the Astro build step.
- Outcome: static HTML posts on publish; no third‑party runtime JS.

## Phase 5 — Content & IA polish
- **People:** Ensure headshot `<img>` have descriptive `alt` text; keep names as `<h2>` for anchorability.
- **Publications:** Group by year; add compact link clusters `[PDF] [PubMed] [Code]` for each item.
- **Software:** Short list of repos with one-line descriptions; badges if desired.
- **Home:** Short mission, then Bluesky updates, then three link tiles to Science / Publications / People.

## Phase 6 — Performance & A11y
- Turn on image lazy‑loading (`<img loading="lazy">`) and width/height attributes.
- Convert large images to WebP; keep originals as fallback where needed.
- Color contrast: ensure text on Navy `#1D3038` remains above WCAG AA (current light grey `#E4E4E4` is acceptable)【21†Allard Lab Website Style Guide†L20-L31】.
- Use headings in order (h1→h2→h3), and unique page titles/`<meta name="description">`.

## Phase 7 — SEO & Analytics
- Add `sitemap.xml` (Astro integration) and `robots.txt` in `public/`.
- Ensure canonical URL is `https://www.allardlab.com` and Pages custom domain + HTTPS are enabled.
- Optional: simple privacy‑respecting analytics (Plausible/GoatCounter).

## Phase 8 — GitHub Pages deployment
- Repo settings → Pages → “Build and deployment: GitHub Actions”.
- Keep `.github/workflows/deploy.yml` as provided; pushing to `main` triggers build to `gh-pages`.
- If you use a **build‑time Bluesky** script, add it before the Astro build step.

## Phase 9 — Post‑launch checks
- Test on mobile, tablet, desktop.
- Validate HTML and check Lighthouse (performance, a11y, SEO, best practices).
- 404 page in `src/pages/404.astro` (optional nice‑to‑have).

## Future enhancements (optional)
- Add an `rss.xml` for announcements (generated at build).
- Add a `/news/` page that lists built‑time‑fetched Bluesky posts.
- If you later want math or notebooks, add them as a **separate section** (Quarto‑built pages can be linked in).

---

**Style references used:** CyPu palette, dark theme, masthead white, supria-sans typography, and SCSS organization from the current style guide【21†Allard Lab Website Style Guide†L12-L31】【21†Allard Lab Website Style Guide†L33-L42】【21†Allard Lab Website Style Guide†L44-L57】.
