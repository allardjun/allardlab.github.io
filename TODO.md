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

- ✅ Added an `<h1>` ("Research", via `title:` front matter).
- ✅ Replaced the verbose justified filler with an alternating "zigzag" layout: each paper's Bluesky card pairs with a short research blurb (`.science-row` / `.science-row--flip` in `_08_pages.scss`).
- ✅ Deduped the Bluesky `embed.js` to a single `async` `<script>` at the end of the page (was one per card).
- The three blurbs (`Reading the immune signal`, `Building the cell's skeleton`, `The physics of DNA`) are first-draft copy — have Jun review/replace, especially the DNA one (written from the paper's venue, not its abstract).
- Optional: truly lazy-load the embeds with an IntersectionObserver so `embed.js` only fetches when a card scrolls into view.
- When the Publications data migration lands, consider sourcing these cards from a `_data/*.yml` "recent papers" list instead of hand-pasting blockquotes.

## Cross-page

- Mobile-first audit at 375 / 768 / 1024 / 1440 widths in a real browser.
- Image optimisation: convert large jpg/png to webp with jpg fallback via `<picture>`. `loading="lazy"` is already on all gallery + content `<img>`s.
- Lighthouse pass: Accessibility ≥ 95, Performance ≥ 85 on simulated mobile.
- Fix the pre-existing Sass `/` division deprecation warnings in `_sass/_functions.scss` (replace `/` with `math.div`). They don't fail the build today but will break under Dart Sass 2.0.

## CI / CD

**Current state (the thing to fix).** There is no GitHub Action — `allardlab/main` has no `.github/workflows/`. PRs are not validated before merge. Deployment is GitHub Pages' legacy "Deploy from a branch" builder, which runs automatically on push to the publishing branch using the `github-pages` gem's **pinned Jekyll (~3.10.x) in safe mode** — *not* your Gemfile. We develop locally on **Jekyll 4.3.3**, so local ≠ prod: a page can pass `jekyll serve` and still render differently (or fail) once deployed. Both plugins (`jekyll-gist`, `jekyll-paginate`) are on the Pages allowlist, so the gap is purely the Jekyll version.

**Plan (single workflow, fork → PR as usual):**

1. Add `.github/workflows/deploy.yml` with two jobs:
   - **build** — runs on `pull_request` *and* `push` to `main`: `bundle exec jekyll build` with `JEKYLL_ENV=production` against the committed `Gemfile.lock` (Jekyll 4.3.3). Fails the check on any build error. Fork PRs run this with a read-only token / no secrets — fine for a build check.
   - **deploy** — runs only on `push` to `main`: uploads the built `_site` via `actions/upload-pages-artifact` + `actions/deploy-pages`. This makes **prod build with our bundle (4.3.3), killing the version drift.**
2. (Optional, can be a follow-up) add an HTMLProofer step to the build job to catch broken internal links / missing images / missing PDFs.

**Manual steps — org admin only, not doable from the repo (record who/when done):**

- **Settings → Pages → Source: change "Deploy from a branch" → "GitHub Actions".** Until this is flipped, the new `deploy` job will not actually publish (and the legacy builder keeps running). Do this *after* the workflow's `build` job has passed green at least once.
- **Settings → Branches → branch-protection rule on `main`:** require the `build` check to pass before merge. (Makes CI gate merges instead of merely advising.)

**⚠️ Reversion plan — if the 3.10.x → 4.3.3 switch breaks the build or the live site:**

The risk is that something the legacy Jekyll 3.10 builder tolerated breaks under our Jekyll 4.3.3 (or vice-versa) — e.g. Sass `/`-division (see the deprecation item above), a Liquid filter behaving differently, or a plugin mismatch. To roll back to the known-good legacy builder:

1. **Settings → Pages → Source: switch back to "Deploy from a branch"** (select `main` / root). GitHub immediately resumes the legacy ~3.10.x build from the branch — no code change required, and it's the exact pipeline running today. This alone restores the site.
2. Disable or delete the Actions deploy so it stops failing: either revert the PR that added `.github/workflows/deploy.yml`, or comment out its `deploy` job (keep the `build` job — a red build check on PRs is still useful and harmless to the live site).
3. If a specific page regressed rather than the whole build, the deployed `_site` from the last good legacy build is still what's served until the next branch push, so there's no rush.
4. Then fix forward locally (most likely the Sass `math.div` change) and re-attempt the Actions deploy.

Key point: the legacy builder is **always available as a fallback** and is selected purely by the Pages "Source" toggle, so reversion is a settings change, not a redeploy.

## Don't-lose-these footguns

If anyone refactors the SCSS again:

- The `body { background; color; … }` block in `_sass/_09_elements.scss` is what gives the site its dark theme. Foundation used to provide this; now we own it. Deleting it would silently regress the site to light mode (the symptom we saw immediately post-Phase-2.E).
- The masthead's `22.9pt / 10pt / 14.9pt` font sizes are manually tuned so the three rows render at approximately equal pixel width in supria-sans. Don't replace with a scaled type-scale or `clamp()` ranges without re-checking visual balance.
