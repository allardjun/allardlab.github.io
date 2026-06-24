# Repository Status: Architecture Notes

Updated after the Phase 1 refactor and Phase 2 UI modernization on the `refactor-and-ui-overhaul` branch. This document captures the current state of the repo: what is source-of-truth vs compiled, what frameworks are in use, and where styling actually comes from in the rendered HTML.

## Source of truth vs compiled

**Source of truth (committed):**
- `_config.yml` (+ `_config_dev.yml`) — Jekyll config
- `_data/navigation.yml`, `_data/authors.yml` — site data
- `_layouts/*.html` — Liquid page templates (`default`, `default-nocompress`, `compress`, `page`, `page-wide`, `page-extrawide`)
- `_includes/*.html` — partials (`_head.html`, `_masthead.html`, `_navigation.html`, `_footer.html`, `_favicon.html`)
- `_sass/*.scss` — settings, layout, page-scoped styles, and the modern layout primitives
- `assets/css/styles_feeling_responsive.scss` — the single SCSS entry point that `@import`s every partial
- `pages/*.md` and the root pages (`index.md`, `404.md`, `humans.txt`, `robots.txt`, `sitemap.xml`)
- `images/`, `files/`, `assets/css`, `assets/img`
- `Gemfile`, `Gemfile.lock`, `CNAME`, `STYLE.md`, `TODO.md`, `README.md`, `STATUS.md`, `APPEARANCE.md`, `PLAN.md`

**Compiled / build artifacts (in `.gitignore`):**
- `_site/` — what GitHub Pages serves (HTML + `_site/assets/css/styles_feeling_responsive.css`, `.css.map`)
- `.jekyll-cache/`, `.sass-cache/`

## Frameworks

- **Jekyll** (static site generator) + **Liquid** templates + **Kramdown** markdown + **Rouge** highlighting
- **Sass/SCSS**, compressed (`_config.yml`).
- Plugins: `jekyll-gist`, `jekyll-paginate`.
- **Adobe Typekit** for the `supria-sans` webfont (`_includes/_head.html`).
- Ruby `3.3.5` (Gemfile).

The site no longer carries a CSS framework. Foundation 5 was removed in Phase 2.E; layout is implemented directly on CSS Grid and Flexbox in two small partials (`_sass/_13_layout_modern.scss` for primitives, `_sass/_14_chrome.scss` for site chrome).

No JavaScript ships on any page except a five-line inline script in `_navigation.html` that toggles the mobile menu's `aria-expanded` attribute.

## SCSS layer order

`assets/css/styles_feeling_responsive.scss` imports, in order:

1. **Settings** — `_functions.scss`, `_01_settings_colors.scss`, `_02_settings_typography.scss`, `_12_tokens.scss`.
   Colors, fonts, the `$global-radius` value, and CSS custom-property design tokens (`--color-*`, `--space-*`, `--text-*`, `--container-*`).
2. **Reset** — `_05_normalize.scss` (normalize.css v3).
3. **Project styles** — `_06_typography.scss` (links, headings, lists, figures, code, blockquote, footnotes), `_07_layout.scss` (the white masthead block), `_08_pages.scss` (people roster grid, photo gallery, publications list, science page floats), `_09_elements.scss` (`body` + `html` base rules that apply `$body-bg` / `$body-font-color`, `box-sizing: border-box` reset, anchor-target offset, text-shadow helpers), `_11_syntax-highlighting.scss` (Rouge syntax colors).
4. **Modern layout layer** — `_13_layout_modern.scss` (container/stack/cluster/grid/split utilities + text-alignment + visually-hidden), `_14_chrome.scss` (`.site-nav` + `.site-footer`).

## Where displayed styles actually come from

The browser loads exactly one stylesheet: `/assets/css/styles_feeling_responsive.css`. Total weight: ~15KB minified.

- **Body background** — `$body-bg` → `$darktheme-background` → `$juns-CyPu-Navy` = `#1D3038`. Variables defined in `_sass/_01_settings_colors.scss`; applied to the `body` element by the base block in `_sass/_09_elements.scss`. (That `body { background; color; ... }` rule used to live in Foundation's `_04_settings_global.scss`. It must be applied explicitly now that Foundation is gone — losing it once already regressed the site into light mode.)
- **Body text color** — `$text-color` → `$darktheme-text` → `$grey-1` = `#E4E4E4`, same path.
- **Body font** — `$body-font-family` → `"supria-sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif`, in `_sass/_02_settings_typography.scss`. The webfont itself is delivered by the Typekit `<link>` in `_includes/_head.html`.
- **Masthead** — `.site-masthead` rules in `_sass/_07_layout.scss`: hidden on mobile, white background with a 3px inset cyan accent at the bottom on tablet+, flexbox-centred content. The three title rows use the original `22.9pt / 10pt / 14.9pt` font sizes — tuned so they render at approximately equal width in supria-sans — plus `margin-bottom: 0.5rem` on the title to keep the first row→subtitle gap visibly looser than the subtitle→description gap. Text content lives in `_includes/_masthead.html`, driven by `site.masthead.{title,subtitle,description}` in `_config.yml`.
- **Navigation** — `.site-nav` rules in `_sass/_14_chrome.scss`: navy sticky bar, white links, cyan accent on hover/active/focus, cyan 2px underline under the active page on tablet+. Mobile collapses behind a hamburger button (a 22×16 three-bar icon, not the word "Menu"); the brand uses `site.title` ("Allard Lab", 10 chars) with `white-space: nowrap` so it never breaks the layout. Two breakpoints: 40em (tablet — inline links with tight padding + 14px font) and 64em (desktop — inline links with wider padding + 15px font). The intermediate range was added to keep Contact from overflowing on 640–1024px viewports.
- **Footer** — `.site-footer` rules in `_sass/_14_chrome.scss`: navy background continuous with body, centred on mobile and spaced on tablet+.
- **Page-scoped rules** — `.peoplewrapper` / `.peoplephoto` / `.photo-gallery` / `.publist` / `.paper-title` / `.embeddedright` / `.embeddedleft` all live in `_sass/_08_pages.scss`. No `<style>` blocks remain in `pages/*.md`.

## Design tokens (CSS custom properties)

Defined in `_sass/_12_tokens.scss` under `:root`. Highlights:

- **Color** — `--color-bg` (navy), `--color-fg` (light grey), `--color-accent` (cyan), `--color-accent-hover` (deeper cyan), `--color-warn` (red), `--color-success` (gold), `--color-surface` (white), `--color-fg-muted` (grey-5).
- **Type** — `--font-sans` (supria-sans + modern fallbacks), `--font-serif`, `--font-mono`; `--text-xs` through `--text-4xl`; `--leading-tight/snug/normal/loose`.
- **Spacing** — `--space-0` through `--space-20` on a 4px baseline.
- **Containers** — `--container-narrow` (36rem), `--container` (48rem), `--container-wide` (64rem), `--container-full` (80rem).
- **Surface** — `--radius-sm/--radius/--radius-lg`, `--shadow-sm/--shadow/--shadow-lg`.

## Modern layout primitives (`_sass/_13_layout_modern.scss`)

Composable, mobile-first utilities used by page layouts and content markup:

- `.container`, `.container-narrow`, `.container-wide`, `.container-full` — max-width, centred, padded.
- `.stack`, `.stack-sm`, `.stack-lg` — vertical flow with consistent gap.
- `.cluster` — flex row that wraps with a gap.
- `.grid`, `.grid-2`, `.grid-3`, `.grid-auto-fit` — CSS Grid templates that collapse to one column on mobile.
- `.split-1-1`, `.split-2-1`, `.split-1-2`, `.split-7-5` — two-column layouts with the given fraction weights on desktop, stacked on mobile.
- `.text-justify` (with `hyphens: auto`, falls back to `text-align: left` on mobile), `.text-center`, `.text-right`, `.text-left`.
- `.visually-hidden` for screen-reader-only content.

## Accessibility

Contrast ratios for the dark theme (verified analytically, not via tooling):

| Pair | Ratio | WCAG |
|---|---|---|
| `#E4E4E4` body text on `#1D3038` navy | 10.6 : 1 | AAA |
| `#45B29D` cyan accent on `#1D3038` navy | 5.3 : 1 | AA (normal text), AAA (large text) |
| `#A4A4A4` muted text on `#1D3038` navy | 5.4 : 1 | AA |
| `#000` masthead text on `#FFF` surface | 21 : 1 | AAA |

`aria-current="page"` is set on the active nav link, the active link also carries a 2px cyan underline accent (so the active state is not communicated by colour alone). `aria-expanded` is toggled on the mobile menu button. The nav and the masthead anchor carry visible `:focus-visible` outlines.

## Page layouts

- `_layouts/default.html` / `_layouts/default-nocompress.html` — page shell (head, nav, masthead, content, footer).
- `_layouts/page.html` — `<main class="container stack">` (~768px).
- `_layouts/page-wide.html` — `<main class="container-wide stack">` (~1024px).
- `_layouts/page-extrawide.html` — `<main class="container-full stack">` (~1280px, used by People).
- `_layouts/compress.html` — Jekyll's HTML compressor.

## Page → layout map

| Page | Layout | Container |
|---|---|---|
| `index.md` (home) | `page-wide` | 1024px |
| `pages/science.md` | `page` | 768px |
| `pages/software.md` | `page` | 768px |
| `pages/publications.md` | `page` | 768px |
| `pages/contact.md` | `page` | 768px |
| `pages/people.md` | `page-extrawide` | 1280px |
| `pages/blog_how_I_organize2025.md` | `page` | 768px |
| `404.md` | `page` | 768px |
