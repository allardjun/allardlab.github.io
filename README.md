# allardlab.github.io
Our website!


## Quickstart

To compile locally, 

```bundle exec jekyll serve```

## Troubleshooting

```rm -rf .jekyll-cache```

## Photo conversion

```mogrify -resize 600x -path half_res full_res/*.jpg```


## Draft masthead

```

						<!-- New SVG version -->
						<div style="padding: 10px; border: 1px dashed #ccc;">
							<div style="font-size: 12px; color: #666; margin-bottom: 10px;">NEW SVG VERSION:</div>
							<a href="{{ '/' | absolute_url }}" title="{{ site.title }}" style="text-decoration:none;">
								<!--<img src="{{ site.url }}{{ site.baseurl }}/assets/img/{{ site.logo }}" alt="{{ site.title }}">-->
								<svg width="500" height="75" viewBox="0 0 500 75" style="max-width:100%; height:auto;">
									<text x="250" y="22" text-anchor="middle" textLength="450" font-size="22" font-weight="bold" font-family="supria-sans" fill="black">ALLARD LAB @ UC IRVINE</text>
									<text x="250" y="42" text-anchor="middle" textLength="450" font-size="10" font-weight="bold" font-family="supria-sans" fill="black">FOR MATHEMATICAL AND COMPUTATIONAL MODELING OF</text>
									<text x="250" y="62" text-anchor="middle" textLength="450" font-size="15" font-weight="bold" font-family="supria-sans" fill="black">CELL AND BIOMOLECULAR MECHANICS</text>
								</svg>
							</a>
						</div>
```


---

Forked from the theme *Feeling Responsive* check out all the features explained in the [documentation][1] under [license][2].

 [1]: http://phlow.github.io/feeling-responsive/documentation/
 [2]: https://github.com/Phlow/feeling-responsive/blob/gh-pages/LICENSE