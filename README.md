# allardlab.github.io

Our website!

## Repo layout

- [`STATUS.md`](STATUS.md) — source-of-truth vs compiled, frameworks in use, where styles come from.
- [`APPEARANCE.md`](APPEARANCE.md) — desktop-rendered description of every page.
- [`PLAN.md`](PLAN.md) — refactor + UI overhaul plan currently in progress.
- [`STYLE.md`](STYLE.md) — design system reference (colors, typography, components).

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

---

Forked from the theme *Feeling Responsive* — see [documentation][1] and [license][2].

 [1]: http://phlow.github.io/feeling-responsive/documentation/
 [2]: https://github.com/Phlow/feeling-responsive/blob/gh-pages/LICENSE