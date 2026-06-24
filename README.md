# allardlab.github.io

Source for [allardlab.github.io](https://allardlab.github.io), the Allard Lab website. Jekyll + Sass; layout on CSS Grid + Flexbox; no CSS framework, no client JS except a five-line nav-toggle script.

## Repo layout

- [`STATUS.md`](STATUS.md) — architecture: source-of-truth vs compiled, frameworks in use, where the displayed styles come from, design tokens, layout primitives, the page → layout → container-width map, contrast ratios.
- [`APPEARANCE.md`](APPEARANCE.md) — page-by-page description of the rendered site at desktop and mobile.
- [`STYLE.md`](STYLE.md) — design system reference: colour palette, typography scale, layout components, breakpoints, accessibility.
- [`PLAN.md`](PLAN.md) — record of the Phase 1 / Phase 2 refactor + UI overhaul work that produced the current branch.
- [`TODO.md`](TODO.md) — visible-change work that was deliberately scoped out of Phase 2 (publications/people data migration, Lighthouse pass, etc.).

## Quickstart

Local build with the production config:

```
bundle exec jekyll serve
```

Local build with the development overrides in `_config_dev.yml` (use this when you want development-only Jekyll settings to apply on top of `_config.yml`):

```
bundle exec jekyll serve --config _config.yml,_config_dev.yml
```

## Troubleshooting

If the build behaves oddly, clear the cache:

```
rm -rf .jekyll-cache
```

## Photo conversion

To bulk-resize photos for the web:

```
mogrify -resize 600x -path half_res full_res/*.jpg
```
