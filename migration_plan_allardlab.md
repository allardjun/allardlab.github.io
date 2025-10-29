# Allard Lab Website Migration & Modernization Plan
**Date:** 2025-10-27
**Updated:** 2025-10-28

## Goals
- Keep the site's focus on text, images, links.
- Preserve the **CyPu dark academic** aesthetic (navy background, cyan accents, light text)【21†Allard Lab Website Style Guide†L12-L31】.
- Embed a **Bluesky feed** (start with a turnkey script; later, consider build‑time static feed).
- Improve performance, accessibility, SEO, and GitHub Pages deployment.

## Phase 1 — Prep (Jekyll freeze)
1. Freeze Jekyll site (branch `jekyll-freeze`) so you can roll back anytime.
2. Inventory assets and content:
   - **Pages:** Home, Contact, Science, People, Publications, Software (1:1 mapping) — matches current navigation.
   - **Images:** 48 content images in `/images/` directory (group photos, campus photos, favicons).
   - **Custom CSS components:** `.peoplewrapper` grid (1fr 2fr), `.paper-title` styling, photo gallery responsive grids.
   - **Third-party widgets:** GitHub Cards on software page (needs replacement strategy).
   - **Font files:** supria-sans in `/assets/fonts/` — decide on self-hosting vs CDN.
   - **Inline styles:** Science page has embedded `<style>` tags that need extraction.
3. Extract style tokens from existing SCSS (already ported in starter):
   - **Colors:** Navy `#1D3038`, Cyan `#45B29D`, Red `#BE1E2D`, Gold `#FEEB7C`, Light text `#E4E4E4`【21†Allard Lab Website Style Guide†L12-L31】.
   - **Typography:** primary font `"supria-sans", Arial, sans-serif`【21†Allard Lab Website Style Guide†L33-L42】.
   - Maintain the masthead white background for contrast on top section【21†Allard Lab Website Style Guide†L20-L31】【21†Allard Lab Website Style Guide†L44-L57】.

## Phase 2 — Astro scaffold & font setup
1. Move starter contents to root directory (or work in subdirectory and swap when ready).
2. Run `npm install` and test dev server with `npm run dev`.
3. **Font implementation:** Implement supria-sans loading strategy:
   - Option A: Self-host font files from `/assets/fonts/` → copy to `/public/fonts/` and add `@font-face` declarations.
   - Option B: Use CDN (if available) with proper `<link rel="preload">` for performance.
4. Set the site URL in `astro.config.mjs` to `https://www.allardlab.com` for correct canonical links and sitemap.
5. **Important:** Verify custom domain `www.allardlab.com` is configured in GitHub repo settings and add `CNAME` file to `/public/` directory.
6. Test that `site` variable is available in Astro templates for image paths (replacement for Jekyll's `{{ site.urlimg }}`).

## Phase 3 — Component development & theming ✅ COMPLETE
1. **Base styles** (already in `src/styles/global.scss`):
   - Color palette in `src/styles/_colors.scss` ✓
   - Link/hover states using Cyan (`#45B29D`) and Gold (`#FEEB7C`) ✓
   - Masthead as white with bold titles ✓
2. **Build custom components:** ✓
   - `.peoplewrapper` — CSS Grid with `grid-template-columns: 1fr 2fr`, centered alignment, 1em gap. ✓
   - Photo gallery grid — responsive columns (3-4 on desktop, 2 on tablet, 1 on mobile) with hover effects. ✓
   - `.paper-title` styling for publication list items. ✓
   - `.embeddedright`/`.embeddedleft` for Bluesky embeds extracted from science.md. ✓
3. **Add missing utility classes:** ✓
   - Additional margin utilities: `.t40`-`.t90`, `.l15`, `.r15` ✓
   - Padding utilities: `.pl20`, `.pr5`, `.pr10`, `.pr20` ✓
   - All components use CSS variables from CyPu palette ✓
4. **Font configuration:** ✓
   - Adobe Typekit link added for supria-sans font ✓
   - sass-embedded dependency installed ✓

## Phase 4 — Content migration ✅ COMPLETE
Migrate content from Jekyll Markdown to Astro pages (all located in `pages/` directory):

1. **Home** (`pages/pages-root-folder/index.md`) → `src/pages/index.astro` ✓
   - Mission statement and intro text migrated ✓
   - Group photo included ✓
   - Links to UC Irvine affiliations ✓
   - Graduate program information ✓

2. **Science** (`pages/science.md`) → `src/pages/science.astro` ✓
   - Research overview text migrated ✓
   - Bluesky embeds preserved (3 posts with embed script) ✓
   - Inline `<style>` blocks removed (styles in global.scss) ✓
   - Liquid variables replaced (`{{ site.urlimg }}` → `/images/`) ✓

3. **People** (`pages/people.md`) → `src/pages/people.astro` ✓
   - `.peoplewrapper` grid component used for team bios ✓
   - Photo gallery with responsive grid (2024, 2023, 2022, 2019, Earlier Years) ✓
   - All images have descriptive `alt` text ✓
   - Current members: Jun, Brady, Katie, Jack, Austin ✓
   - Past members with subsequent positions ✓
   - Two-column layout: people list + photos ✓

4. **Publications** (`pages/publications.md`) → `src/pages/publications.astro` ✓
   - Complete chronological citation list (50+ papers) ✓
   - Links to Google Scholar and PubMed ✓
   - Individual paper links (BioRXiv, PubMed, journals) ✓
   - `.paper-title` styling applied ✓
   - PhD and MSc theses included ✓

5. **Software** (`pages/software.md`) → `src/pages/software.astro` ✓
   - GitHub Cards widget replaced with direct links (Option A) ✓
   - 6 repositories with descriptions ✓
   - Clean, centered layout ✓

6. **Contact** (`pages/contact.md`) → `src/pages/contact.astro` ✓
   - Two-column layout (text + campus photos) ✓
   - Email, LinkedIn, GitHub links ✓
   - Office locations and mailing address ✓
   - UCI campus photos (3 images) ✓
   - Sheri Rowland building note ✓

7. **Asset migration:** ✓
   - 47 images copied to `/public/images/` ✓
   - 3 PDF files copied to `/public/files/` (CV and theses) ✓

## Phase 5 — Bluesky feed integration
**Recommended approach: Option A (turnkey widget for initial launch)**
- Use `<BlueskyTimeline handle="@YOUR_HANDLE" />` component (already implemented in starter).
- Update handle in home page and science page as needed.
- Test that widget loads correctly with dark theme.

**Future enhancement: Option C (build-time static feed, zero JS)**
- Defer to post-launch improvements.
- Add Node script in `scripts/` that calls Bluesky API during CI.
- Wire into GitHub Action before Astro build step.
- Outcome: static HTML posts with no third-party runtime JS.

## Phase 6 — Image optimization & performance
1. **Image processing (48 content images):**
   - Copy all images from `/images/` to `/public/images/`.
   - Convert large JPGs/PNGs to WebP format (keep originals for fallback).
   - Priority: Group photos, campus photos (skip favicons).
   - Use Astro's `<Image>` component for automatic optimization where possible.

2. **Responsive images:**
   - Add `loading="lazy"` to all content images.
   - Specify `width` and `height` attributes to prevent layout shift.
   - Generate srcset attributes for different screen sizes.

3. **Performance optimizations:**
   - Remove Foundation 5 JavaScript bundle (~200KB) - replaced by Astro's minimal output.
   - Minimize third-party scripts (only Bluesky widget for initial launch).
   - Test page load times with Lighthouse.

## Phase 7 — Accessibility & testing
- **Color contrast:** Verify text on Navy `#1D3038` remains above WCAG AA (light grey `#E4E4E4` is acceptable)【21†Allard Lab Website Style Guide†L20-L31】.
- **Heading hierarchy:** Use headings in order (h1→h2→h3) across all pages.
- **Unique page metadata:** Each page should have unique `<title>` and `<meta name="description">`.
- **Alt text:** All images must have descriptive alt text.
- **Keyboard navigation:** Test all interactive elements are keyboard accessible.
- **Cross-device testing:** Test on mobile, tablet, desktop.

## Phase 8 — SEO & metadata
- **Astro sitemap integration:** Install `@astrojs/sitemap` and configure in `astro.config.mjs`.
- **robots.txt:** Create in `public/robots.txt` with appropriate crawl directives.
- **Canonical URL:** Ensure all pages reference `https://www.allardlab.com` as canonical.
- **Structured data:** Consider adding JSON-LD for Organization/Person schemas (optional).
- **Analytics:** Optional privacy-respecting analytics (Plausible/GoatCounter).
- **404 page:** Create `src/pages/404.astro` with helpful navigation.

## Phase 9 — GitHub Pages deployment
1. **Workflow verification:**
   - Confirm `.github/workflows/deploy.yml` is in place (already in starter).
   - Verify workflow deploys to `gh-pages` branch.
   - Test build process locally with `npm run build`.

2. **GitHub repository settings:**
   - Settings → Pages → "Build and deployment: GitHub Actions".
   - Configure custom domain `www.allardlab.com` in Pages settings.
   - Enable "Enforce HTTPS".

3. **First deployment:**
   - Push to `main` branch to trigger build.
   - Monitor GitHub Actions tab for build success.
   - Verify site loads at custom domain.

## Phase 10 — Post-launch validation
- **HTML validation:** Run through W3C validator.
- **Lighthouse audit:** Score all pages for performance, accessibility, SEO, best practices (target 90+ in all categories).
- **Cross-browser testing:** Test in Chrome, Firefox, Safari, Edge.
- **Mobile responsiveness:** Test on actual mobile devices and tablets.
- **Link checking:** Verify all internal and external links work.
- **Search console:** Submit sitemap to Google Search Console.

## Future enhancements (optional)
- **Build-time Bluesky feed:** Implement Option C from Phase 5 for zero-JS static feed.
- **RSS feed:** Add `rss.xml` for announcements (generated at build with Astro integration).
- **News archive:** Add `/news/` page that lists built-time-fetched Bluesky posts.
- **Math/notebooks:** If needed, add as separate section (Quarto-built pages can be linked in).
- **Image optimization pipeline:** Automate WebP conversion in build process.

---

## Migration Summary

### Key Challenges Addressed
1. ✅ **Foundation 5 replacement:** Starter provides minimal custom CSS, eliminating 41 subdirectories of framework code.
2. ✅ **Component extraction:** Plan includes specific tasks for `.peoplewrapper`, photo gallery, and publication styling.
3. ✅ **Font loading:** Phase 2 addresses supria-sans implementation strategy.
4. ✅ **Third-party widgets:** GitHub Cards replacement strategy defined in Phase 4.
5. ✅ **Image optimization:** Detailed plan for 48 images in Phase 6.
6. ✅ **Liquid templating:** Content migration phase addresses Jekyll variable replacement.

### Estimated Timeline
- **Phase 1-2 (Prep & Setup):** 4-6 hours
- **Phase 3 (Component Development):** 6-8 hours
- **Phase 4 (Content Migration):** 8-10 hours
- **Phase 5 (Bluesky Integration):** 1-2 hours
- **Phase 6-7 (Optimization & Testing):** 6-8 hours
- **Phase 8-10 (SEO, Deploy, Validation):** 4-6 hours

**Total estimated effort:** 30-40 hours (~1 week of focused work)

### Prerequisites
- [ ] Custom domain `www.allardlab.com` DNS configured
- [ ] Bluesky handle confirmed for feed integration
- [ ] Decision on font hosting strategy (self-host vs CDN)
- [ ] GitHub Cards widget replacement approach selected

### Success Criteria
- All 6 pages migrated with content intact
- Lighthouse scores 90+ in all categories
- CyPu aesthetic preserved (navy background, cyan accents, white masthead)
- Mobile-responsive across all devices
- Fast page loads (<2s on 3G)
- WCAG AA accessibility compliance

---

**Style references used:** CyPu palette, dark theme, masthead white, supria-sans typography, and SCSS organization from the current style guide【21†Allard Lab Website Style Guide†L12-L31】【21†Allard Lab Website Style Guide†L33-L42】【21†Allard Lab Website Style Guide†L44-L57】.
