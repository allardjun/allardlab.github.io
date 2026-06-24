# Website Improvement TODO

Phase 1 (refactor) and Phase 2 (UI modernization) are both done on the `refactor-and-ui-overhaul` branch. The items below are the visible-change items that did not make it into Phase 2 — they are deliberately scoped out because each is a meaningful feature on its own. The Foundation-vs-CSS-Grid question is resolved: the site is on CSS Grid + Flexbox, no framework.

## Home page (`index.md`)

- Responsive image handling on `PXL_20230221_052352091~2.jpg` (`srcset`, `sizes`, aspect ratio, `object-fit`).
- Add a clear value-proposition line above the fold and CTAs to key pages (Publications, People, open positions).
- Visual hierarchy and visible separators between sections.

## Publications page (`publications.md`)

- Migrate the hand-maintained `<ul class="publist">` into structured `_data/publications.yml`.
- Group entries by year with sticky year headers.
- Style preprints vs. journal papers distinctly.
- Client-side year/keyword filter.
- Highlight recent / featured publications above the fold.

## People page (`people.md`)

- Migrate the hand-maintained list to `_data/people.yml` with `current`, `photo`, `bio`, `links`.
- Real `alt` text on every photo; styled initials avatar when no photo exists (drop favicon placeholders).
- Hover state on people cards.

## Software page (`software.md`)

- Replace the brittle `cdn.jsdelivr.net/github-cards` widget with static cards rendered from `_data/software.yml` (or built at deploy time from the GitHub API). Restyle to match the dark theme.

## Science page (`science.md`)

- Add an H1 (page front matter currently has no `title:`, so the layout's `{{ page.title }}` would render blank — the layout already guards against the empty `<h1></h1>` but the page has no heading at all).
- Break long justified paragraphs into shorter sections with subheadings.
- Lazy-load or fallback for the Bluesky embeds (they currently load via the `embed.bsky.app` script on every page view).

## Cross-page

- Mobile-first audit at 375 / 768 / 1024 / 1440 widths in a real browser.
- Image optimisation: convert large jpg/png to webp with jpg fallback via `<picture>`. `loading="lazy"` is already on all gallery + content `<img>`s.
- Lighthouse pass: Accessibility ≥ 95, Performance ≥ 85 on simulated mobile.
- CI: GitHub Action that runs `bundle exec jekyll build` on every PR.
- Fix the pre-existing Sass `/` division deprecation warnings in `_sass/_functions.scss` (replace `/` with `math.div`). They don't fail the build today but will break under Dart Sass 2.0.

## Don't-lose-these footguns

If anyone refactors the SCSS again:

- The `body { background; color; … }` block in `_sass/_09_elements.scss` is what gives the site its dark theme. Foundation used to provide this; now we own it. Deleting it would silently regress the site to light mode (the symptom we saw immediately post-Phase-2.E).
- The masthead's `22.9pt / 10pt / 14.9pt` font sizes are manually tuned so the three rows render at approximately equal pixel width in supria-sans. Don't replace with a scaled type-scale or `clamp()` ranges without re-checking visual balance.
