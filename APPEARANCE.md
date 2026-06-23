# Rendered Site Appearance (Desktop)

Reasoned description of how the site renders on a desktop browser after the Phase 2 UI modernization. Derived from the layouts, includes, SCSS, and page sources.

## Frame around every page

- **Sticky top nav bar (`.site-nav`)** in navy `#1D3038` with a subtle drop shadow. White uppercase links, ~15px. On desktop: left side `Home · Science · People · Software · Publications`; `Contact` pushed to the right via a flex `margin-left: auto`. The current page is rendered in cyan `#45B29D` and underlined by a 2px cyan accent below the text. Hover/focus tints links cyan with a faint translucent-white background. Focused links carry a visible 2px cyan outline.
- **Masthead (`.site-masthead`)** directly under the nav: white panel ~192–256px tall depending on viewport, with a thin cyan accent line along its bottom edge that bridges the white block into the dark body. Three centered lines of `supria-sans` bold black text — `ALLARD LAB @ UC IRVINE` (fluid clamp ~24–32px), then `FOR MATHEMATICAL AND COMPUTATIONAL MODELING OF` (small caps tracking), then `CELL AND BIOMOLECULAR MECHANICS` (mid-sized). The whole block is one anchor to `/`; hovering it shifts the title to a deeper cyan.
- **Body** below is navy `#1D3038` with light grey `#E4E4E4` text, `supria-sans` everywhere. Inline links are cyan with a 1px dotted underline; hover swaps to a 1px solid underline. Body content sits inside a max-width container (768px / 1024px / 1280px depending on the layout) with comfortable side padding.
- **Footer (`.site-footer`)** at the bottom is the same navy (so it visually continues), with a top-link (`↑ Top`) on the left and the Jekyll / Feeling Responsive credits on the right (centred and stacked on mobile). Smaller `0.875rem` text, with grey-muted credits and cyan-on-hover links.

Because body and footer share the navy, the page reads as one continuous dark canvas, broken only by the white masthead band with its cyan underline and the navy-with-shadow sticky nav.

## Home (`/`)

`layout: page-wide`, so the content sits in a `.container-wide` (~1024px) main with vertical `stack` spacing.

- A justified paragraph (hyphenated): "Cells are nanometer-scale problem solving machines…"
- A responsive full-width photo of the lab.
- A paragraph listing UCI affiliations — each affiliation is a cyan link.
- A short call to prospective grad students and postdocs, with a cyan link to the MCSB program.

## Science (`/science/`)

`layout: page`, ~768px container, vertical stack.

- The page is wrapped in `.text-justify` so paragraphs are justified with auto hyphens on desktop and left-aligned on mobile.
- Sequence of short prose sections about biopolymers, the lab's mission, multi-scale modeling.
- Three Bluesky embeds floated alternately right / left / right inside `.embeddedright` / `.embeddedleft` containers (300px wide); body text wraps around them. The embeds render after JS loads; the static fallback block (a styled blockquote) is what's served from disk.

## People (`/people/`)

`layout: page-extrawide`, the widest container on the site (~1280px). The page uses `.split-1-1` so on desktop the roster sits in the left half and the photo gallery in the right half. On mobile, the columns collapse to one.

**Left column — people roster:**
- `PEOPLE` H1 in white, followed by a stack of `.peoplewrapper` rows. Each row is a CSS grid (`8rem 1fr`) with a circular photo on the left (object-fit: cover, soft shadow) and the person's name (bold) plus role on the right. A hairline border between rows.
- Current members: Jun Allard, Brady Berg, Katie Bogue, Jack Corrette, Austin Marcus.
- `PAST MEMBERS` H1 below in the same grid format.
- A nested bullet list of post-docs and rotation students.

**Right column — photo gallery:**
- Featured hero photo at top (`allardlab_and_friends2024.jpg`), full-width with rounded corners and a stronger shadow.
- Year sections (`2024`, `2023`, `2022`, `2019`, `Earlier Years`) headed by an uppercase white h3 with a cyan underline.
- Each year a CSS Grid `repeat(auto-fit, minmax(12rem, 1fr))` with photos that lift slightly on hover. `.photo-wide` items span two columns.
- On mobile, the gallery moves below the roster and the photo min-width drops to 9rem.

## Software (`/software/`)

`layout: page`, ~768px container, content centred.

- A GitHub-cards widget for the org `allardlab`.
- An H1 `SOFTWARE`.
- A vertical stack of GitHub repo cards: LibsmolWE, ForminKineticModel, WavingCrawling, EntropicMultisiteIntegrative, Motor-Cargo-Simulator, IntrinsicDisorderTCRModel.

The cards are rendered by `cdn.jsdelivr.net/github-cards/latest/widget.js` — an old, possibly stale CDN — so this page may look empty if the widget fails to load. The cards' light "default" theme also clashes visually with the navy body. Both are TODO items.

## Publications (`/publications/`)

`layout: page`, ~768px container.

- One opening line with two inline links: Google Scholar and PubMed.
- A `<ul class="publist">` with no list-style. Each `<li>` is a flex item with a hairline bottom border, padding-block of `0.75rem`, line-height `1.6`. Inside each: authors, then the paper title in white at weight 600 on its own line, then journal/year, then optional BioRXiv links.

## Contact (`/contact/`)

`layout: page`, ~768px container. The content uses `.split-7-5` so on desktop the contact details get 7/12 and the UCI photos get 5/12 of the width; stacked on mobile.

- **Left:** `CONTACT` H1, email + LinkedIn + GitHub, PI office, lab office, mailing address, and a small-font Rowland Hall historical note.
- **Right:** three centred UCI campus photos stacked vertically.

## Mobile rendering (< 40em)

- Nav bar shows the lab name on the left as a brand link and a `Menu` toggle button on the right; the menu collapses behind `aria-expanded="false"` until tapped.
- White masthead is hidden (the brand in nav takes its place).
- All split-* and grid-* containers collapse to a single column.
- Justified text falls back to left-aligned (no rivers, no broken hyphenation).
- Photo gallery uses a tighter `9rem` minimum and reduced gaps.

## Overall visual impression

A dark, modern academic site: navy body, supria-sans throughout, cyan as the single accent color. A white masthead "card" provides brand identity, bridged to the dark body by a cyan accent strip. Content sits in centered max-width containers with generous breathing room. Two-column page layouts (People, Contact) use CSS Grid splits that collapse cleanly on mobile. Visible focus rings on all interactive elements.

## Known caveats

- The masthead text depends on Adobe Typekit (`zom0olg.css`) loading — without it, the fallback is `-apple-system`, then Arial.
- The Science Bluesky embeds and the Software GitHub cards are JS-dependent and may render late or fail silently if the CDN is unreachable.
