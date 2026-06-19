# Refactor + UI Overhaul Plan

Two-phase work on branch `refactor-and-ui-overhaul`.

**Phase 1 (refactor)** changes structure without changing what users see. It puts the codebase in a state where Phase 2's UI changes are easy and consistent.

**Phase 2 (UI)** changes the visible site to follow current best practices — responsive, accessible, performant.

Each phase is broken into checkpoints. Verify the rendered output (locally with `bundle exec jekyll serve`) before crossing a checkpoint boundary, and commit at each checkpoint so progress is bisectable.

---

## PHASE 1 — Refactor (no visible change)

Goal: every styling rule lives in `_sass/`, every layout rule lives in `_layouts/`, and `pages/*.md` files contain only content. Dead theme code is removed. The masthead, fonts, and config are deduplicated. After Phase 1, opening any page should look pixel-identical to `main`.

### 1.1 Repo hygiene
- Untrack `.DS_Store` (`git rm --cached .DS_Store` at root and any subdir copies); confirm it's already in `.gitignore`.
- Delete the masthead SVG draft pasted into `README.md` lines 22–36.
- Document `_config_dev.yml` in `README.md` with the exact dev-vs-prod command (`bundle exec jekyll serve --config _config.yml,_config_dev.yml`).
- Delete `jekyll-theme-feeling-responsive.gemspec` (theme is vendored, gemspec is unused).

### 1.2 Delete dead theme leftovers
Drop unused files so future readers don't have to grep them:
- `_layouts/frontpage.html` and `_includes/_frontpage-widget.html` (home now uses `page-wide`).
- `_includes/_pagination.html`, `_sidebar.html`, `next-previous-post-in-category`, `list-collection`, `list-posts`, `gallery`, `alert`, `sitemap_collection.xml`.
- **Asciidoc (confirmed remove):** delete `_sass/_10_asciidoc.scss`, the conditional `@import` of it in `assets/css/styles_feeling_responsive.scss`, the `jekyll-asciidoc` / `asciidoctor` / `coderay` gems from `Gemfile`, the `asciidoctor-enabled` and `asciidoctor:` blocks from `_config.yml`, and the Font Awesome CDN `<link>` in `_includes/_head.html:31-33` that's gated on `site.asciidoctor-enabled`.
- **Twitter (confirmed remove):** delete the commented-out Twitter timeline in `pages/pages-root-folder/index.md` lines 63–70, the `jekyll-twitter-plugin` gem and its commented config line, and the `socialmedia.twitter` Open Graph / Twitter Card scaffolding in `_includes/_head.html:72-80` if it's only sitting there for a now-dormant account (keep if `@allardlab` is still active — confirm before deleting).
- Verify with `grep` that each file is unreferenced before deleting.

### 1.3 SCSS deduplication and structure
- Remove duplicate `@import` lines in `assets/css/styles_feeling_responsive.scss` (`top-bar`, `grid` are imported twice).
- Create `_sass/_08_pages.scss` and move *all* page-level styles out of `pages/*.md`:
  - From `people.md`: `.peoplewrapper`, `.peoplephoto`, `.photo-gallery`, `.photo-grid`, `.photo-item`, `.photo-item.featured`, `.photo-item.photo-wide`, and the `@media (max-width: 600px)` block.
  - From `publications.md`: `.publist`, `.paper-title` rules and the mobile media query.
  - From `science.md`: `.embeddedright`, `.embeddedleft` and their mobile media queries.
- Delete the now-duplicate `.peoplewrapper`/`.peoplephoto` block at the bottom of `_sass/_07_layout.scss` (lines 406–418) — superseded by the new `_08_pages.scss` definitions.
- Replace inline `style="text-align:justify"` / `style="text-align:center"` attributes scattered across `pages/*.md` with class hooks (`.text-justify`, `.text-center`) defined in `_sass/_08_pages.scss`. Foundation already ships `.text-center`; check before adding duplicates.
- Add `@import "08_pages.scss";` to `assets/css/styles_feeling_responsive.scss` after `09_elements.scss`.
- After this checkpoint, `pages/*.md` files should have **zero `<style>` blocks** and minimal inline `style=` attributes.

### 1.4 Masthead consolidation
- Replace hardcoded "ALLARD LAB @ UC IRVINE / FOR MATHEMATICAL... / CELL AND BIOMOLECULAR MECHANICS" in `_includes/_masthead.html:12-14` with Liquid references to `site.title`, `site.slogan`, and a new `site.description_short` (or split `site.slogan` into two lines). Update `_config.yml` accordingly so the masthead text is now driven by one source.
- Leave the rendered output identical at this checkpoint — verify the three lines still come out byte-for-byte the same.

### 1.5 File and asset reorganization
- Move stray PNGs out of `pages/` (`figBottles.png`, `figDashboard.png`, `figliterature.png`, `figThreeWindows.png`, `figTimeline.png`) into `images/`. Update any references in `pages/blog_how_I_organize2025.md` with `grep` first.
- **Keep `pages/blog_how_I_organize2025.md` and any other unlinked pages as-is.** They're intentionally not in `_data/navigation.yml` because they're shared quasi-privately by URL. Do not delete, do not link from nav. Just preserve their permalinks across any restructuring.
- **Flatten `pages/pages-root-folder/`** (confirmed): move `index.md`, `404.md`, `humans.txt`, `robots.txt`, `sitemap.xml` to repo root. URLs stay the same because each file has an explicit `permalink:`. Verify by hitting `/`, `/404`, `/robots.txt`, `/sitemap.xml` locally after the move.

### 1.6 Font loader cleanup
- **Remove the Google WebFontLoader entirely** (confirmed): delete `_includes/_head.html:37-48` (the `<script>` block and the `<noscript>` fallback) and remove `Lato` from the serif fallback chain in `_02_settings_typography.scss:26`. `Volkhov` was already unreferenced.
- **Keep Adobe Typekit `supria-sans`** (confirmed) — leave the `<link rel="stylesheet" href="https://use.typekit.net/zom0olg.css">` in `_includes/_head.html:25` in place.
- After this, the only external font dependency is Typekit. One request instead of three.

### 1.7 Documentation refresh
- Update `STYLE.md`'s "Configuration Files" section to mention `_08_pages.scss`.
- Update `README.md` with a short "Repo layout" section pointing at `STATUS.md` (architecture) and `APPEARANCE.md` (rendered description).
- Delete `TODO.md` items that Phase 1 has closed; move the rest into Phase 2 of this plan.

### Phase 1 checkpoints (recommended commits)
1. Repo hygiene (1.1 + 1.2): "remove dead theme leftovers and tracked .DS_Store".
2. SCSS consolidation (1.3): "centralize page styles into _sass/_08_pages.scss".
3. Masthead + font cleanup (1.4 + 1.6): "drive masthead from _config.yml; drop unused web fonts".
4. File reorganization (1.5): "move stray assets into images/; flatten pages-root-folder".
5. Documentation (1.7): "sync STYLE/README with refactored layout".

### Phase 1 acceptance criteria
- `bundle exec jekyll serve` builds with no warnings.
- Visual diff (sampling: `/`, `/science/`, `/people/`, `/software/`, `/publications/`, `/contact/`) shows no rendered differences from `main` at any of the four Foundation breakpoints.
- `grep -r "<style" pages/` returns nothing.
- `grep -r 'style="' pages/` returns only the dynamic Liquid-driven `style="..."` attributes (e.g. masthead background colors), if any.
- All deleted files are confirmed unreferenced.

---

## PHASE 2 — UI improvements

Now that the codebase is clean, change the visible UI. The order below is roughly "biggest payoff, lowest risk" first. Each subsection is independent — pick and ship in any order — but **finish Phase 1 first**, because Phase 2 assumes centralized styles and no inline overrides.

### 2.1 Modernize the layout shell

The current shell uses Foundation 5 (≈2014). Three options, in increasing scope:

- **A. Stay on Foundation 5, modernize patterns.** Lowest risk. Keep the grid; replace the masthead/nav/footer with cleaner markup; tighten spacing tokens. Recommended starting point.
- **B. Replace Foundation grid with CSS Grid + Flexbox.** Cuts ~80% of `_sass/foundation-components/`. Medium risk, big payoff in maintainability.
- **C. Adopt a modern framework (Tailwind, or just utility-first vanilla CSS).** Big rewrite. Only if you want a long-term overhaul.

Recommend A → B over two iterations, never C unless you want a different look.

### 2.2 Responsive / mobile-first

- Audit every page at 375px, 768px, 1024px, 1440px widths.
- Convert the People page two-column desktop layout to **roster-only on mobile**, with the photo gallery moving below (already half-done by `large-6`).
- Make the Science page Bluesky embed stack above body text on mobile instead of `float:right`.
- Ensure justified text (`text-align: justify`) doesn't produce ugly rivers on narrow viewports — switch to `text-align: left` on mobile or globally.
- Verify the white masthead doesn't dominate the viewport on phones (currently 200px on small, which is a lot of vertical space for a phone).

### 2.3 Masthead and navigation

- Replace the hardcoded white-rectangle masthead with something that feels like part of the page: a tighter banner with the lab name, possibly a faint background image or gradient, that doesn't fully break the navy theme. Keep the same text content.
- Make the navigation collapse cleanly on mobile (currently `toggle-topbar menu-icon` Foundation pattern works but feels dated).
- Add a visible "current page" indicator beyond just color (e.g. an underline) — color-only state is an accessibility miss.

### 2.4 Home page

- Add a clear value proposition above the fold (one sentence summarizing the lab's research).
- Add internal links/CTAs to key pages (Publications, People, Open positions).
- Replace the lone full-width photo with a responsive `<picture>` using multiple sources (already in TODO.md).
- Consider a "recent news" or "recent papers" snippet pulled from `_data/` (one-time setup, easy maintenance).

### 2.5 Publications page

- Group entries by year, with sticky year headers on scroll.
- Style preprints vs. published papers differently (badge or color).
- Highlight the most recent N papers above the fold.
- Add a year/keyword filter (client-side only — no backend).
- Ensure all paper links open consistently (target, rel="noopener").
- Pull from `_data/publications.yml` instead of a hand-maintained `<ul>` so each entry is structured (title, authors, venue, year, links). This is a one-time migration but pays off forever.

### 2.6 People page

- Convert the manually-maintained list to `_data/people.yml` with `current: true|false`, `photo`, `bio`, `links`. Render with a Liquid loop.
- Add hover effects on people cards (subtle lift, link to a personal page if provided).
- Ensure each photo has a meaningful `alt` (currently empty/absent for several).
- Drop placeholder favicon images; use a styled initials avatar when no photo exists.

### 2.7 Software page

- Replace the brittle `cdn.jsdelivr.net/github-cards` widget with static cards rendered server-side from `_data/software.yml` (or built at deploy time from the GitHub API). The current page can render empty if the CDN goes down — already noted in APPEARANCE.md.
- Restyle cards to fit the dark theme so they stop visually clashing.

### 2.8 Science page

- Restructure long justified paragraphs into shorter sections with subheadings.
- Add real H1 to the page (currently the layout's `{{ page.title }}` is blank because no `title:` is set in front matter).
- Replace the JS Bluesky embed with a static screenshot+link fallback; or load the embed lazily so it doesn't block render.

### 2.9 Contact page

- Add a map/embed of Rowland Hall location (optional, can be a static image).
- Make office locations and email links more visually distinct.

### 2.10 Accessibility pass

- Run axe or Lighthouse on every page.
- Add `alt` attributes to every `<img>`.
- Verify navy + light-grey body text meets WCAG AA contrast (currently #E4E4E4 on #1D3038 is ≈11:1, passes — but verify against any new accent colors).
- Add ARIA labels to social icons and breadcrumb.
- Make keyboard navigation work end-to-end; check focus rings aren't hidden by the navy background.
- Add `lang="en"` is already present — also add page-level metadata.

### 2.11 Performance

- Optimize images: convert `.jpg`/`.png` to `.webp` with `.jpg` fallback via `<picture>`. Many of the photos under `images/` are >500KB.
- Defer non-critical JS (Modernizr, github-cards widget, Bluesky embed).
- Add `loading="lazy"` to non-critical images.
- Audit external dependencies: Typekit, Google WebFontLoader (if kept), GitHub-cards CDN, Bluesky embed CDN. Each is a third-party request and a single point of failure.
- Subset the Typekit font if possible, or self-host a modern alternative.

### 2.12 Maintenance niceties

- Add a GitHub Action that runs `bundle exec jekyll build` on every PR and posts the link to a preview deploy (Netlify, Cloudflare Pages, or GitHub Pages preview).
- Add a `.editorconfig` for consistent whitespace.
- Add an HTML proofer step to catch broken links in CI.

### Phase 2 acceptance criteria
- Every page passes Lighthouse Accessibility ≥95.
- Every page passes Lighthouse Performance ≥85 on simulated mobile.
- Visual review across 4 breakpoints shows no horizontal scroll, no text overflowing containers, no broken images.
- All content lives in `_data/` or `pages/*.md`; no hand-written `<li>` lists of publications or people remain.

---

## Decisions on file

User-confirmed before starting Phase 1:

1. **Asciidoc**: remove entirely (gem, SCSS partial, config blocks, Font Awesome CDN link).
2. **Twitter plugin**: remove entirely (gem, commented timeline). Confirm `@allardlab` Twitter Card metadata in `_head.html` separately before deleting it.
3. **Unlinked pages** (`pages/blog_how_I_organize2025.md` and any future siblings): **keep and do not link from nav** — these are shared by URL quasi-privately. Preserve their permalinks across any restructuring.
4. **`pages-root-folder/`**: flatten to repo root. Permalinks make this URL-safe.
5. **Google WebFontLoader**: remove entirely (script + noscript + `Lato` fallback).
6. **Adobe Typekit `supria-sans`**: keep.

Still open, but deferred until after Phase 1 ships:

7. **Foundation 5**: keep (Phase 2 option A), replace the grid with CSS Grid (option B), or full rewrite (option C)? Recommend deciding after seeing the cleaned-up codebase.
