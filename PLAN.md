# Refactor + UI Overhaul Plan

Two-phase work on branch `refactor-and-ui-overhaul`. Both phases are now complete; this document records what was done at each checkpoint and what remains for follow-on work.

## STATUS: Phase 1 ✅  Phase 2 ✅  (remaining items in `TODO.md`)

---

## PHASE 1 — Refactor (no visible change)

Goal: every styling rule lives in `_sass/`, every layout rule lives in `_layouts/`, and `pages/*.md` files contain only content. Dead theme code removed. Masthead, fonts, and config deduplicated. After Phase 1, every page renders pixel-identically to `main`.

### Checkpoints (commit per checkpoint, bisectable)

- **1.1 + 1.2** — Repo hygiene + dead theme leftovers. Untracked `.DS_Store`, removed the masthead SVG draft from `README.md`, deleted the unused gemspec, removed unused layouts (`frontpage.html`), unused includes (`_frontpage-widget.html`, `_pagination.html`, `_sidebar.html`, `alert`, `gallery`, `list-posts`, `list-collection`, `next-previous-post-in-category`, `__INSTRUCTIONS.md`), the asciidoc partial + plugin + config, the Twitter plugin gem + commented timeline, and the dead RSS/Atom XSLT scaffolding.
- **1.3** — SCSS consolidation. Created `_sass/_08_pages.scss` with all `<style>` blocks moved out of `pages/people.md`, `publications.md`, `science.md`. Deduplicated `.peoplewrapper`/`.peoplephoto` and the doubled Foundation `@import`s.
- **1.4 + 1.6** — Masthead + font cleanup. Masthead text now driven from `site.masthead.{title,subtitle,description}` in `_config.yml`. Google WebFontLoader + Lato fallback removed; Adobe Typekit retained.
- **1.5** — File reorganization. Moved stray PNGs from `pages/` into `images/`; flattened `pages/pages-root-folder/` to repo root. Unlinked pages (`blog_how_I_organize2025.md`) kept by design.
- **1.7** — Documentation refresh. Updated `STYLE.md` and `TODO.md`.

Decisions baked in at Phase 1 start (recorded for posterity):
- Remove asciidoc, Twitter plugin, Google WebFontLoader.
- Keep unlinked pages as-is (quasi-private URL sharing).
- Keep Adobe Typekit (`supria-sans`).
- Flatten `pages-root-folder/`.

---

## PHASE 2 — UI modernization (Option B: replace Foundation with CSS Grid + Flexbox)

Goal: drop the Foundation 5 framework entirely, replace its grid + top-bar with modern CSS Grid + Flexbox primitives consuming a CSS-custom-property design-token layer, and apply visible polish.

### Checkpoints

- **2.A** — Design tokens + modern layout primitives. New partials `_sass/_12_tokens.scss` (CSS custom properties for color, type, spacing, container widths, radius, shadow) and `_sass/_13_layout_modern.scss` (composable `.container*`, `.stack*`, `.cluster`, `.grid*`, `.split-*`, `.text-*`, `.visually-hidden`). Wired into the main stylesheet; no markup changes yet.

- **2.B** — Migrate page layouts and masthead off Foundation grid. Rewrote `_includes/_masthead.html` from a 5-deep `<div>` table-cell nest to a single `<header class="site-masthead">` with a flexbox-centred anchor. Dropped the five unused masthead branches (`header.title`, `header.image_fullwidth`, `header.pattern`, `header.background-color`, `header == false`). Rewrote `_layouts/page.html`, `page-wide.html`, `page-extrawide.html` to use `<main class="container[…] stack">` instead of `.row` + `.columns` + `.medium-offset-N`. Tuned `--container-*` widths to 36 / 48 / 64 / 80 rem.

- **2.C** — Replace navigation; introduce site-footer; drop Foundation top-bar. Rewrote `_includes/_navigation.html` with semantic `<nav>`, `aria-current="page"` on the active link, and an inline 5-line script that toggles `aria-expanded` for the mobile menu. Rewrote `_includes/_footer.html` (which previously emitted an orphan `</footer>` close tag) with a proper `<footer>` element. Added the `_sass/_14_chrome.scss` partial styling both, with sticky nav, hamburger toggle, focus-visible outlines, hover/active states.

- **2.D** — Migrate content pages to modern utilities. Replaced every `.row` / `.columns` / `.small-N` / `.medium-N` / `.large-N` wrapper in `index.md`, `pages/science.md`, `pages/people.md`, `pages/software.md`, `pages/contact.md` with the new layout primitives. Added `alt=` and `loading="lazy"` to gallery and content images. Layouts now skip the article `<header>` entirely if `page.title` / `page.subheadline` / `page.image.title` are all unset, removing empty `<h1></h1>` elements.

- **2.E** — Strip unused Foundation, dead includes, legacy JS. Deleted `_sass/foundation-components/` (39 partials), `_sass/_03_settings_mixins_media_queries.scss`, `_sass/_04_settings_global.scss`. Moved the one still-used variable, `$global-radius`, into `_sass/_02_settings_typography.scss`. Stripped the `$topbar-*` and `$footer-*` / `$subfooter-*` blocks from `_sass/_01_settings_colors.scss`. Rewrote `_07_layout.scss` to masthead-only, rewrote `_06_typography.scss` and `_09_elements.scss` to only their actually-used rules (drops `@font-face` iconfont, `.icon-*`, `.alert-box`, `.button`, `.side-nav`, `.accordion`, `.lazy`, `.big-teaser`, `.sans`, `.serif`, `.t10`–`.pr20`). Deleted the dead includes (`_breadcrumb.html`, `_comments.html`, `_meta_information.html`, `_google_search.html`, `_improve_content.html`, `_footer_scripts.html`), the dead conditionals in page layouts, the Modernizr script from `_head.html`, the Twitter Card meta block, and the defaults block + socialmedia entry from `_config.yml`. Deleted `assets/js/javascript.{js,min.js}` (jQuery 2.1.1 + Foundation), `assets/js/modernizr*.js`, `assets/mediaelement_js/`, `assets/fonts/` (the iconfont set).

  Net effect: compiled stylesheet drops from ~270KB to ~15KB; no JS ships on any page except the 5-line inline menu toggle.

- **2.F** — Visible polish. Smaller masthead heights (12/14/16rem at the breakpoints, down from 280/310/380px), inset cyan accent at the bottom edge, fluid `clamp()` typography. Cyan underline accent under the active nav link on tablet+. `.text-justify` now uses `hyphens: auto` on desktop and falls back to left-align on mobile. People photos are circular avatars with shadows. Publications list uses border-hairlines instead of margin gaps. Photo gallery year-headers redesigned with cyan underline. Body links have explicit cyan color and visible focus-visible outlines.

- **2.G** — Refresh documentation. Updated `STATUS.md`, `APPEARANCE.md`, `STYLE.md`, this `PLAN.md` to reflect the post-Foundation state.

### Acceptance criteria (met)

- `bundle exec jekyll build` builds with no errors (Foundation Sass division deprecation warnings are pre-existing in `_functions.scss` and only emit warnings, not failures).
- No `class="row"`, `.columns`, `.small-N`, `.medium-N`, `.large-N` in any rendered HTML.
- No `<style>` blocks in any `pages/*.md`.
- Every page renders correctly at the three responsive breakpoints (mobile, tablet, desktop).
- Visible focus rings on all interactive elements.
- `aria-current="page"` on active nav link, `aria-expanded` on the mobile menu button, `aria-label` on the nav and the masthead anchor.

---

## REMAINING WORK (not in scope for this branch)

Tracked in `TODO.md`. The biggest pending items:

- Migrate `pages/people.md`, `pages/publications.md`, `pages/software.md` data into `_data/*.yml` so the markup can be templated and the lists can grow without hand-editing.
- Replace the brittle `cdn.jsdelivr.net/github-cards` widget on the Software page with server-side cards from `_data/software.yml`.
- Sticky year headers / client-side filter / preprint badges on Publications.
- Optimise photos to webp; add `<picture>` with multiple sources.
- CI: GitHub Action that runs `bundle exec jekyll build` on every PR.
- Fix the pre-existing Sass `/` division deprecation warnings in `_functions.scss` (replace with `math.div`).
