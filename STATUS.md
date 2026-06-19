# Repository Status: Architecture & Refactor Notes

This document captures the current state of the repo: what is source-of-truth vs compiled, which frameworks are used, where styling actually comes from in the rendered HTML, and organizational refactors that would not change the visible UI. UI/best-practice recommendations are deliberately omitted here.

## Source of truth vs compiled

**Source of truth (committed):**
- `_config.yml` (+ `_config_dev.yml`) — Jekyll config
- `_data/navigation.yml`, `_data/authors.yml` — site data
- `_layouts/*.html` — Liquid page templates (`default`, `default-nocompress`, `compress`, `page`, `page-wide`, `page-extrawide`, `frontpage`)
- `_includes/*.html` — partials (`_head.html`, `_masthead.html`, `_navigation.html`, `_footer.html`, etc.)
- `_sass/*.scss` — design tokens + layout, plus `foundation-components/*.scss`
- `assets/css/styles_feeling_responsive.scss` — the single SCSS entry point that `@import`s every partial
- `pages/**/*.md` — content (home is `pages/pages-root-folder/index.md`)
- `images/`, `files/`, `assets/js`, `assets/img`, `assets/fonts`
- `Gemfile`, `Gemfile.lock`, `CNAME`, `STYLE.md`, `TODO.md`, `README.md`

**Compiled / build artifacts (in `.gitignore`):**
- `_site/` — what GitHub Pages serves (HTML + `_site/assets/css/styles_feeling_responsive.css`, `.css.map`)
- `.jekyll-cache/`, `.sass-cache/`

Note: `_site/` is present locally from `bundle exec jekyll serve` but not in the repo. `.DS_Store` is gitignored but one is still tracked (shows as modified in `git status`).

## Frameworks

- **Jekyll** (static site generator) + **Liquid** templates + **Kramdown** markdown + **Rouge** highlighting
- Theme is a vendored fork of **Feeling Responsive** (Phlow), itself built on **Zurb Foundation 5** — see `_sass/foundation-components/`
- **Sass/SCSS**, compressed (`_config.yml:213-215`)
- Plugins (`_config.yml:54-58`): `jekyll-asciidoc`, `jekyll-gist`, `jekyll-paginate` (twitter plugin commented out)
- **Adobe Typekit** for the `supria-sans` webfont (`_includes/_head.html:25`)
- **Google WebFontLoader** for `Lato` + `Volkhov` (`_includes/_head.html:37-48`) — Google fonts are loaded but barely used (`_02_settings_typography.scss:26` references `Lato` only in the serif fallback)
- **Modernizr** (`assets/js/modernizr.min.js`)
- Ruby `3.3.5` (Gemfile)

## Where displayed styles actually come from

The browser loads exactly one stylesheet: `/assets/css/styles_feeling_responsive.css`, compiled from `assets/css/styles_feeling_responsive.scss`, which is just `@import` lines for the `_sass/*` partials.

- **Body background** = `$body-bg` = `$darktheme-background` = `$juns-CyPu-Navy` = `#1D3038`, set in `_sass/_01_settings_colors.scss:50,55,68`
- **Body text color** = `$text-color` = `$darktheme-text` = `$grey-1` = `#E4E4E4`, same file lines 18,57,66
- **Body font** = `$body-font-family` = `"supria-sans", Arial, sans-serif`, in `_sass/_02_settings_typography.scss:25,29`. The font itself is delivered by the Typekit `<link>` in `_includes/_head.html:25`.
- **Masthead** is white with black text, hardcoded (not via variables) in `_sass/_07_layout.scss:71-129`. The literal title strings live in `_includes/_masthead.html:12-14`.
- **Navigation** colors in `_sass/_01_settings_colors.scss:94-122` (navy bg, white link, cyan hover/active).
- **Footer/Subfooter** colors in `_sass/_01_settings_colors.scss:125-135` and applied in `_sass/_07_layout.scss:305-375`.
- **Per-page overrides:** several content pages add their own `<style>` blocks or inline `style="..."`: `pages/people.md` (~80 lines of CSS for `.peoplewrapper`/`.photo-gallery`), `pages/publications.md` (~35 lines for `.publist`/`.paper-title`), `pages/science.md` (`.embeddedright`/`.embeddedleft`), plus scattered `style="text-align:..."` in `index.md`, `software.md`, `contact.md`.

## Organizational refactor suggestions (no visible change)

1. **Move page-level `<style>` blocks into `_sass/`.** `people.md`, `publications.md`, `science.md` each carry CSS that belongs in a partial (e.g. a new `_sass/_08_pages.scss` or appended to `_07_layout.scss`).
2. **Deduplicate `.peoplewrapper` / `.peoplephoto`.** Defined in both `_sass/_07_layout.scss:406-418` and `pages/people.md:7-19` — already drifting.
3. **Foundation imports are doubled** in `assets/css/styles_feeling_responsive.scss` (`top-bar` lines 15 + 36, `grid` lines 27 + 42). Drop the duplicates.
4. **Drive the masthead from `_config.yml`.** Lab name/slogan/description live in both `_config.yml:11-17` and as literal strings in `_includes/_masthead.html:12-14`. The masthead currently ignores `site.title`/`site.slogan`.
5. **Delete the masthead SVG draft pasted into `README.md`** (lines 22-36). README isn't a scratchpad.
6. **Delete commented-out Twitter timeline** in `pages/pages-root-folder/index.md:63-70` and the commented `jekyll-twitter-plugin` line in `_config.yml:58`. The gem is still required in `Gemfile:11`.
7. **Move stray page assets out of `pages/`.** `pages/figBottles.png`, `figDashboard.png`, `figliterature.png`, `figThreeWindows.png`, `figTimeline.png` belong under `images/` per the `urlimg: '/images/'` convention.
8. **Check whether `pages/blog_how_I_organize2025.md` is reachable.** It's not in `_data/navigation.yml`; either link it or move it out.
9. **Resolve the `pages-root-folder` indirection.** The folder only exists to keep `index.md`/`404.md`/`robots.txt`/`humans.txt`/`sitemap.xml` together — Jekyll's natural home for these is the repo root. Either flatten or rename.
10. **Prune layouts and includes that aren't used.** Home now uses `layout: page-wide`, so `_layouts/frontpage.html` + `_includes/_frontpage-widget.html` are dead. Also unused by current pages: `_includes/_pagination.html`, `_sidebar.html`, `next-previous-post-in-category`, `list-collection`, `list-posts`, `gallery`, `alert`, `sitemap_collection.xml` (all blog-theme leftovers).
11. **Prune asciidoc.** `asciidoctor-enabled: false` (`_config.yml:246`), the SCSS import is already conditional, but `Gemfile:10` still pulls `jekyll-asciidoc` and `_sass/_10_asciidoc.scss` is still in the tree. Remove if you don't plan to use it.
12. **Delete the theme `.gemspec`.** `jekyll-theme-feeling-responsive.gemspec` at the repo root is a leftover from the upstream theme package and isn't used to install this site (theme is vendored, not gem-installed).
13. **Untrack `.DS_Store`.** It's in `.gitignore` but `git rm --cached` is needed for the one still showing as modified.
14. **Document `_config_dev.yml`'s purpose** in `README.md` (i.e., when to run `bundle exec jekyll serve --config _config.yml,_config_dev.yml`).
15. **Consider whether the Google Fonts `Lato`/`Volkhov` loader is still needed.** `_includes/_head.html:37-48` loads them, but the only reference in the SCSS is `Lato` as a serif fallback in `_02_settings_typography.scss:26`. Probably dead.
