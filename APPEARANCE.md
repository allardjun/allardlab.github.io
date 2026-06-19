# Rendered Site Appearance (Desktop)

Reasoned description of how the site renders on a desktop browser, derived from the layouts, includes, SCSS, and page sources.

## Frame around every page

- **Sticky top nav bar (`#navigation`)** in navy `#1D3038` with a subtle drop shadow. White uppercase links, ~15px. Left side: `Home · Science · People · Software · Publications`. Right side: `Contact`. Current page is highlighted cyan `#45B29D`; hovering any link turns it cyan.
- **Masthead** directly under the nav: a stark white panel, ~175–380px tall depending on viewport (310px on large). Centered black text, three stacked lines in `supria-sans` bold:
  - **ALLARD LAB @ UC IRVINE** (22.9pt)
  - FOR MATHEMATICAL AND COMPUTATIONAL MODELING OF (10pt)
  - **CELL AND BIOMOLECULAR MECHANICS** (14.9pt)

  The whole block is a link to `/`.
- **Body** below is navy `#1D3038` with light grey `#E4E4E4` text, `supria-sans` everywhere.
- **Footer** at the bottom is the same navy (so it visually continues), with smaller (~13px) light-weight text, white uppercase headers, and grey-8 `#7E7E7E` links. A subfooter strip beneath holds inline credits ("Created with Jekyll based on Feeling Responsive") and circular 36px social icons (Twitter `@allardlab`).

Because body and footer are the same navy, the page reads as one continuous dark canvas, broken only by the white masthead and the navy-with-shadow nav bar.

## Home (`/`)

`layout: page-wide`, so the content sits in a Foundation row with a 10-column content area (slim left/right margins on desktop).

- Justified paragraph: "Cells are nanometer-scale problem solving machines..."
- A full-width photo of the lab (`PXL_20230221_052352091~2.jpg`).
- Paragraph listing UCI affiliations — every affiliation is a cyan link (CCBS, NSF-Simons cellfate, Math, Physics, ChaMP).
- A short call to prospective grad students/postdocs, with cyan link to the MCSB program.

The commented-out Twitter sidebar means the home page is a single column — no right-side widget.

## Science (`/science/`)

`layout: page`, narrower column (Foundation `medium-8 medium-offset-2`, so wider margins than the home page).

- No H1 visible (no `title:` set in the front matter — H1 renders empty/blank).
- First justified paragraph about "Biopolymers (flexible rods), biomembranes..."
- A Bluesky post embedded in a 300px-wide box floated to the right, with body paragraphs wrapping to its left. The embed is JS-rendered, so before JS runs you'd see a fallback `<blockquote>` styled box.
- Several more justified paragraphs about the lab's mission, methods, and multi-scale modeling.

## People (`/people/`)

`layout: page-extrawide`, the widest column on the site. The page is split into **two side-by-side columns on desktop** (each `large-6`).

**Left column — people roster:**
- `PEOPLE` H1.
- A vertical stack of `.peoplewrapper` blocks. Each block is a CSS grid with **photo on the left (1/3 width), name + role on the right (2/3 width)**, vertically centered, separated by 1em.
- Photos are 192px. People who haven't supplied one show the lab "A" favicon as a placeholder.
- Current members: Jun Allard, Brady Berg, Katie Bogue, Jack Corrette, Austin Marcus.
- `PAST MEMBERS` H1 below, same grid format: Sohyeon Park, Jonathan Rodriguez, Rob Taylor, Trini Nguyen, Matt Bovyn, Lara Clemens, Kathryn Manakova, Derek Bryant.
- A nested bullet list of "Other past" — post-docs and rotation students by program.

**Right column — photo gallery:**
- Featured hero photo at top (`allardlab_and_friends2024.jpg`), full-width with rounded corners and shadow.
- Year-section headers (e.g. `2024`) with underline.
- Auto-fit photo grids beneath each header — items at minmax 200px, 1rem gap, photos object-fit cover, rounded, slight shadow, small scale-up on hover.

The two-column split holds on desktop; on phones the gallery would drop below the roster.

## Software (`/software/`)

`layout: page`, narrow column, centered text.

- A GitHub-cards widget for the org (`allardlab`).
- An H1 `SOFTWARE`.
- A vertical stack of GitHub repo cards: LibsmolWE, ForminKineticModel, WavingCrawling, EntropicMultisiteIntegrative, Motor-Cargo-Simulator, IntrinsicDisorderTCRModel.

The cards are rendered by `cdn.jsdelivr.net/github-cards/latest/widget.js` — an old, possibly stale CDN — so this page may look empty if the widget fails to load. The cards' "default" theme is light, which would visually clash with the navy body. Not flagged as a UI recommendation here, but worth knowing this page is the most fragile.

## Publications (`/publications/`)

`layout: page`, narrow column.

- One opening line with two inline links: Google Scholar and PubMed.
- A long `<ul class="publist">` of papers. Each `<li>` has 1.5rem of bottom space and 1.6 line height. Inside each entry: authors, then the paper title in a slightly heavier weight (600), then journal/year, optionally with BioRXiv links.
- No year grouping — it's one continuous list, newest at top.
- Links fade slightly on hover.

## Contact (`/contact/`)

`layout: page`, two columns on desktop (large-7 left, large-5 right).

- **Left:** `CONTACT` H1, email, LinkedIn and GitHub links, PI office, lab office, mailing address, and a small-font Rowland Hall historical note.
- **Right:** three centered UCI campus photos stacked vertically.

## Overall visual impression

A dark, minimal academic site: navy body, supria-sans throughout, cyan as the only accent color, with a single white masthead "card" near the top of every page providing brand identity. Content is mostly long-form justified paragraphs and lists, with the People page being the only one with strong two-dimensional layout. The Home and Science pages are essentially single columns; Contact and People split into two; Publications and Software are tall single columns of list-like content.

Things to be aware of when interpreting the live site:
- The masthead text depends on Adobe Typekit (`zom0olg.css`) loading — if it doesn't, you'd get Arial.
- The Bluesky embed (Science) and GitHub cards (Software) are JS-dependent and may be the dominant visual element only when those scripts succeed.
- `_layouts/page-extrawide.html` uses `large-12` after `medium-10 medium-offset-1`, which at large breakpoints overrides the offset — so the People page should run nearly full-width, while Science/Publications stay in a narrower column.
