# Allard Lab Website Style Guide

The design system, palette, typography, and styling architecture of the Allard Lab website. Refreshed for the post-Foundation, CSS Grid + Flexbox stack on `refactor-and-ui-overhaul`.

## Design philosophy

A modern academic aesthetic with a distinctive dark theme. Navy body + cyan accent + white masthead. Readability, accessibility, and a clean, contemporary feel appropriate for a research laboratory. Mobile-first layout with visible focus states throughout.

## Color palette

### Primary colors

Defined as SCSS variables in `_sass/_01_settings_colors.scss` and mirrored as CSS custom properties in `_sass/_12_tokens.scss`.

| Color | Hex | SCSS variable | CSS custom property | Usage |
|---|---|---|---|---|
| Navy | `#1D3038` | `$juns-CyPu-Navy` | `--color-bg` | Body, nav, footer |
| Cyan | `#45B29D` | `$juns-CyPu-Cyan` | `--color-accent` | Links, hover, active state, masthead underline |
| Red | `#BE1E2D` | `$juns-CyPu-Red` | `--color-warn` | Alerts |
| Gold | `#FEEB7C` | `$juns-CyPu-Gold` | `--color-success` | Success/info |

### Theme

- **Background:** Navy (`#1D3038`)
- **Body text:** Grey-1 (`#E4E4E4`) → `--color-fg`
- **Muted text:** Grey-5 (`#A4A4A4`) → `--color-fg-muted`
- **Accent:** Cyan (`#45B29D`)
- **Masthead surface:** White (`#FFFFFF`) → `--color-surface`

### Grey scale

`$grey-1` (#E4E4E4) through `$grey-16` (#0B0B0B) for subtle variation.

## Typography

### Font family

**Body and headings:** `"supria-sans", -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif`

Delivered via Adobe Typekit (`<link rel="stylesheet" href="https://use.typekit.net/zom0olg.css">` in `_includes/_head.html`). The native-stack fallbacks render acceptably if Typekit is unreachable.

### Sizes

- **Base:** 16px / 1.5 line height
- **Modular scale** (h1 → h5): 2.2em / 1.953em / 1.563em / 1.25em / 1.152em
- **Design-token scale** (`--text-xs` → `--text-4xl`): 0.75 / 0.875 / 1 / 1.125 / 1.25 / 1.563 / 1.953 / 2.441 rem
- **Masthead title:** fluid `clamp(1.5rem, 1.2rem + 1.5vw, 2rem)`

### Weights

400 (regular), 700 (bold).

## SCSS architecture

`assets/css/styles.scss` imports partials in this order:

1. **Settings** — `_functions.scss`, `_01_settings_colors.scss`, `_02_settings_typography.scss`, `_12_tokens.scss`.
2. **Reset** — `_05_normalize.scss` (normalize.css v3).
3. **Project styles** — `_06_typography.scss`, `_07_layout.scss`, `_08_pages.scss`, `_09_elements.scss`, `_11_syntax-highlighting.scss`.
4. **Modern layout layer** — `_13_layout_modern.scss`, `_14_chrome.scss`.

### What lives where

| Partial | Purpose |
|---|---|
| `_functions.scss` | `rem-calc()` and friends |
| `_01_settings_colors.scss` | CyPu palette + grey scale + body/theme assignments + code highlighting colors |
| `_02_settings_typography.scss` | Font families, font size scale, `$global-radius` |
| `_05_normalize.scss` | Cross-browser reset |
| `_06_typography.scss` | Links, headings, lists, figures, code, blockquote, footnotes, `.subheadline`, `.teaser` |
| `_07_layout.scss` | The `.site-masthead` block (white slab with cyan inset accent) |
| `_08_pages.scss` | Page-scoped rules: `.peoplewrapper`, `.peoplephoto`, `.photo-gallery`, `.photo-grid`, `.photo-item`, `.publist`, `.paper-title`, `.science-row` (+ `.science-row--flip`, `.science-row__text`, `.science-row__media`), `.cite` |
| `_09_elements.scss` | `html`/`body` base (applies `$body-bg`, `$body-font-color`, `$body-font-family`, `box-sizing: border-box`), anchor-target offset for sticky nav, `.shadow-*` text-shadow helpers |
| `_11_syntax-highlighting.scss` | Rouge syntax highlighting colors |
| `_12_tokens.scss` | CSS custom properties: `--color-*`, `--font-*`, `--text-*`, `--leading-*`, `--space-*`, `--container-*`, `--radius-*`, `--shadow-*` |
| `_13_layout_modern.scss` | Layout utilities: `.container*`, `.stack*`, `.cluster`, `.grid*`, `.split-*`, `.text-*`, `.visually-hidden` |
| `_14_chrome.scss` | `.site-nav` (sticky top bar + mobile menu) + `.site-footer` |

## Layout primitives

Mobile-first; all consume design tokens.

### Containers
- `.container` — max-width 48rem (~768px)
- `.container-narrow` — 36rem
- `.container-wide` — 64rem
- `.container-full` — 80rem (used by People)

### Vertical rhythm
- `.stack` — flex column with `gap: var(--space-6)`
- `.stack-sm` — gap `var(--space-3)`
- `.stack-lg` — gap `var(--space-10)`

### Two-column splits (stack on mobile, side-by-side at ≥ 64em)
- `.split-1-1` — equal halves (People)
- `.split-7-5` — 7/12 + 5/12 (Contact)
- `.split-2-1`, `.split-1-2` — 2:1 splits

### Grids
- `.grid` — bare CSS grid with `gap: var(--space-6)`
- `.grid-2`, `.grid-3` — 1 / 2 / 3 columns at breakpoints
- `.grid-auto-fit` — `repeat(auto-fit, minmax(min(100%, 14rem), 1fr))`

### Text utilities
- `.text-justify` — justified with `hyphens: auto`; falls back to left on mobile
- `.text-center`, `.text-right`, `.text-left`

## Layout components

### Masthead (`.site-masthead`, `_sass/_07_layout.scss`)

- **Background:** white surface (`var(--color-surface)`)
- **Min-height:** mobile-hidden, then 12rem / 14rem / 16rem at the 40em / 64em / 90em breakpoints
- **Centring:** flexbox (`align-items: center; justify-content: center`)
- **Title row:** `22.9pt` supria-sans bold black, `line-height: 0.7`, `margin-bottom: 0.5rem`
- **Subtitle row:** `10pt` supria-sans bold black
- **Description row:** `14.9pt` supria-sans bold black
- **Why the fixed pt sizes:** the three string lengths (22 / 46 / 31 chars) are manually balanced against these specific point sizes so the rows render at roughly equal pixel width. **Don't change without re-checking visual balance.** The `clamp()` approach used briefly during Phase 2.F broke this and was reverted.
- **Row spacing:** title carries `margin-bottom: 0.5rem` so the first→second gap is visibly looser than the second→third (which is just the flex `gap: var(--space-1)`).
- **Accent:** inset 3px cyan line along the bottom edge (bridges into the navy body)
- **Hover:** title shifts to deeper cyan
- **Mobile:** hidden — the nav's brand link shows the lab name instead

### Navigation (`.site-nav`, `_sass/_14_chrome.scss`)

- **Background:** `var(--color-bg)` (navy)
- **Position:** sticky to the top of the viewport, z-index 100
- **Mobile (< 40em):** brand link (`site.title` = "Allard Lab", with `white-space: nowrap`) + 22×16 hamburger icon button + collapsed menu. The icon is rendered as three `<span>` bars, not a font icon. Toggling uses `aria-expanded` from a 5-line inline script.
- **Tablet (40–64em):** menu inline (`flex-direction: row`), brand hidden, links use tight padding (`var(--space-2) var(--space-3)`) and 14px font so the six links + Contact's `margin-left: auto` fit comfortably down to 640px wide.
- **Desktop (≥ 64em):** same layout, links use wider padding (`var(--space-3) var(--space-4)`) and 15px font.
- **Hover/focus:** cyan text + faint white background
- **Active page:** cyan text + 2px cyan underline accent (`::after`) plus `aria-current="page"`
- **Focus visible:** 2px cyan outline

### Footer (`.site-footer`, `_sass/_14_chrome.scss`)

- **Background:** `var(--color-bg)` (continuous with body)
- **Layout:** flex column on mobile (centred), flex row with space-between on tablet+
- **Contents:** `↑ Top` link + site credits
- **Link color:** muted grey, cyan on hover

## Responsive breakpoints

Mobile-first, three breakpoints used by the chrome + page layouts:

- **Tablet:** `min-width: 40em` (~640px)
- **Desktop:** `min-width: 64em` (~1024px)
- **Wide:** `min-width: 90em` (~1440px) — used only by the masthead

## Accessibility

- `aria-current="page"` on active nav link
- 2px cyan underline accent on active nav link (active state communicated by both colour AND a non-colour cue)
- Visible `:focus-visible` outlines on nav links, masthead anchor, body links
- `aria-expanded` toggled by the menu button
- `aria-label="Primary"` on the nav
- `loading="lazy"` on all gallery images
- Page content starts at a single semantic `<main>` element
- Justified text falls back to left-align on mobile to avoid rivers

### Contrast ratios (dark theme, verified analytically)

| Pair | Ratio | WCAG |
|---|---|---|
| `#E4E4E4` body text on `#1D3038` navy | 10.6 : 1 | AAA |
| `#45B29D` cyan accent on `#1D3038` navy | 5.3 : 1 | AA (normal), AAA (large) |
| `#A4A4A4` muted text on `#1D3038` navy | 5.4 : 1 | AA |
| `#000` masthead text on `#FFF` surface | 21 : 1 | AAA |

## When adding new styles

1. **Colors:** add to `_sass/_01_settings_colors.scss` (and mirror as a `--color-*` token in `_12_tokens.scss` if you need it from CSS).
2. **Typography:** add to `_sass/_02_settings_typography.scss`.
3. **Layout utilities:** add to `_sass/_13_layout_modern.scss`.
4. **Site chrome:** add to `_sass/_14_chrome.scss`.
5. **Masthead:** add to `_sass/_07_layout.scss`.
6. **Page-scoped rules:** add to `_sass/_08_pages.scss`. Never write `<style>` blocks inside `pages/*.md`.

## Brand consistency

- **Accent:** always cyan `#45B29D` for interactive state.
- **Background:** navy `#1D3038` for surfaces continuous with body.
- **Typography:** supria-sans only.
- **Contrast:** light text on dark background; AA contrast at minimum.

---

**Last updated:** 2026-06-24
**Maintained by:** Allard Lab
**Stack:** Jekyll + Sass + custom CSS Grid / Flexbox layout (no CSS framework)
