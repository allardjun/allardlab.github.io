# Website Improvement TODO

Phase 1 (refactor) is complete on branch `refactor-and-ui-overhaul`. Open visible-change work is consolidated into Phase 2 of [`PLAN.md`](PLAN.md). The items below are the open user-facing changes; cross-reference Phase 2 of `PLAN.md` for the structured rollout.

## Home page (`index.md`)

- Responsive image handling on `PXL_20230221_052352091~2.jpg` (srcset, sizes, aspect ratio, object-fit).
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

- Replace the brittle `cdn.jsdelivr.net/github-cards` widget with static cards rendered from `_data/software.yml` (or built at deploy time from the GitHub API). Restyle to match dark theme.

## Science page (`science.md`)

- Add an H1 (page front matter currently has no `title:`, so the layout's `{{ page.title }}` renders blank).
- Break long justified paragraphs into shorter sections with subheadings.
- Lazy-load or fallback for the Bluesky embed.

## Cross-page

- Mobile-first audit at 375 / 768 / 1024 / 1440 widths.
- Image optimisation: convert large jpg/png to webp with jpg fallback via `<picture>`; add `loading="lazy"`.
- Accessibility pass: axe / Lighthouse, alt text everywhere, ARIA labels on icons and breadcrumb, visible focus rings, no color-only state.
- CI: GitHub Action that runs `bundle exec jekyll build` on every PR.
- Decide on the Foundation 5 path forward (keep / replace grid with CSS Grid / full rewrite) — Phase 2 item 7 in `PLAN.md`.
