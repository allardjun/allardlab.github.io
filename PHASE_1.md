# Phase 1 — Prep (Jekyll Freeze)
**Started:** 2025-10-28

## Objectives
1. Freeze Jekyll site (branch `jekyll-freeze`) for rollback safety
2. Complete inventory of assets and content
3. Verify style tokens are ready for migration

---

## Progress Log

### Step 1: Create Jekyll Freeze Branch
✅ **Status:** Branch `jekyll-freeze` already exists
- Can rollback anytime by checking out this branch
- Current working branch: `astro-migration`

---

## Step 2: Inventory Assets and Content

### 2.1 Pages Inventory

| Page | Source File | Layout | Content Summary | Migration Notes |
|------|-------------|--------|-----------------|-----------------|
| **Home** | `pages/pages-root-folder/index.md` | `page-wide` | Mission statement, group photo, affiliation info | Uses `{{ site.urlimg }}` for images |
| **Science** | `pages/science.md` | `page` | Research overview with 3 Bluesky embeds | **Has inline `<style>` block** (lines 6-23) |
| **People** | `pages/people.md` | `page-extrawide` | Team grid + photo gallery | **Has extensive inline `<style>` block** (lines 6-86) |
| **Publications** | `pages/publications.md` | `page` | Citation list with `.paper-title` spans | **Has inline `<style>` block** (lines 7-40) |
| **Software** | `pages/software.md` | `page` | GitHub Cards widget embeds | **Uses third-party JS widget** |
| **Contact** | `pages/contact.md` | `page` | Two-column layout, address, campus photos | Uses `{{ site.urlimg }}` for images |

**Key Findings:**
- All pages use Liquid templating: `{{ site.urlimg }}` and `{{ site.urlfiles }}`
- 3 pages have embedded `<style>` blocks that need extraction
- Science page has 3 Bluesky post embeds using official embed script
- Software page uses GitHub Cards CDN widget (`cdn.jsdelivr.net/github-cards`)

---

### 2.2 Images Inventory

**Total: 47 image files** in `/images/` directory

**Categories:**

1. **People Photos (10 files)**
   - `photojun.jpg`, `brady_192px.jpg`, `austin_192px.jpg`, `jack_image0_192px.jpeg`
   - `SohyeonPark_192px.jpeg`
   - `Afavicon-192x192.png` (used as placeholder for people without photos)
   - Various past member photos

2. **Group Photos (25 files)**
   - 2024: `allardlab_and_friends2024.jpg`, `PXL_20241217_*` (5 files)
   - 2023: `PXL_20231118_212151696.jpg`
   - 2022: `PXL_20221212_*` (4 files), `PXL_20220220_*` (2 files), `PXL_20220223_*` (2 files)
   - 2019: `group19f.jpg`, `group19su.jpg`, `matt2019.jpg`, `sohyeon2019.jpg`, `img_20191126_114741.jpg`, `IMG_4706.jpg`
   - Earlier: `20180330allardgroupphoto.jpeg`, `img_20170422_153511.jpg`, `img_0064.jpg`, `allardlab2015largecropped512.jpeg`

3. **Campus Photos (3 files)**
   - `uci_campus1.jpg`, `uci_campus2.jpg`, `uci_campus3.jpg`
   - Used on contact page

4. **Software/Figures (5 files)**
   - `figBottles.png`, `figDashboard.png`, `figThreeWindows.png`, `figTimeline.png`, `figliterature.png`
   - Appear to be software screenshots/diagrams

5. **Home Page (1 file)**
   - `PXL_20230221_052352091~2.jpg` - Used on homepage

6. **Other (3 files)**
   - `AllardGroupDinnerDec2022.png`
   - `photoderekbiophys2014_390px.jpeg`, `photogroup390px.jpeg`

**Migration Tasks:**
- Copy all 47 files to Astro `/public/images/`
- Convert large JPGs to WebP (priority: group photos, campus photos)
- Skip favicon placeholder (`Afavicon-192x192.png`)
- Update all `{{ site.urlimg }}` references to `/images/` in Astro templates

---

### 2.3 Custom CSS Components

**Extracted from inline `<style>` blocks in pages:**

#### From `science.md` (lines 6-23):
```css
.embeddedright {
    float: right;
    margin: 20px;
}
.embeddedleft {
    float: left;
    margin: 20px;
}
@media (max-width: 500px) {
    .embeddedright, .embeddedleft {
        float: none;
    }
}
```
**Purpose:** Float Bluesky embeds right/left with responsive mobile behavior

#### From `people.md` (lines 7-86):
```css
.peoplewrapper {
    display: grid;
    grid-template-columns: 1fr 2fr;
    align-items: center;
    grid-gap: 1em;
    row-gap: 1em;
    padding-bottom: 1em;
}

.photo-gallery h3 {
    margin-top: 2rem;
    margin-bottom: 1rem;
    border-bottom: 2px solid #eee;
    padding-bottom: 0.5rem;
}

.photo-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.photo-item img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 6px;
    transition: transform 0.2s ease;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.photo-item img:hover {
    transform: scale(1.02);
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

.photo-item.photo-wide {
    grid-column: span 2;
}

@media (max-width: 600px) {
    .photo-grid {
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 0.5rem;
    }
}
```
**Purpose:** Two-column people grid + responsive photo gallery with hover effects

#### From `publications.md` (lines 7-40):
```css
.publist {
    line-height: 1.6;
}

.publist li {
    margin-bottom: 1.5rem;
}

.paper-title {
    font-weight: 600;
    line-height: 1.4;
    margin: 0.3rem 0;
}

.publist a {
    transition: opacity 0.2s ease;
}

.publist a:hover {
    opacity: 0.8;
}

@media (max-width: 768px) {
    .publist li {
        margin-bottom: 1.2rem;
        font-size: 0.95rem;
    }
}
```
**Purpose:** Publication list styling with responsive typography

**Migration Decision:**
- Add these to Astro `src/styles/global.scss` under a "Page-specific components" section
- All are already well-structured and use modern CSS (Grid, flexbox)
- No Foundation dependencies detected

---

### 2.4 Third-Party Widgets

#### 1. **GitHub Cards Widget**
- **Location:** `software.md`
- **Source:** `cdn.jsdelivr.net/github-cards/latest/widget.js`
- **Usage:** Displays GitHub repository cards with stars/forks/description
- **Repositories shown:**
  - allardlab (org card)
  - LibsmolWE
  - ForminKineticModel
  - WavingCrawling
  - EntropicMultisiteIntegrative
  - Motor-Cargo-Simulator
  - IntrinsicDisorderTCRModel

**Migration Options:**
- **Option A (Recommended):** Use GitHub API at build time to fetch repo metadata
- **Option B:** Direct links to GitHub repos with manual descriptions
- **Option C:** Keep widget (adds runtime JS, against performance goals)

#### 2. **Bluesky Embeds**
- **Location:** `science.md` (3 embeds)
- **Source:** `embed.bsky.app/static/embed.js`
- **Posts:**
  - `at://did:plc:rbj6reygdb6svaanpqoiw4tu/app.bsky.feed.post/3lydsavefsc2h`
  - `at://did:plc:rbj6reygdb6svaanpqoiw4tu/app.bsky.feed.post/3lyds7jhirc2h`
  - `at://did:plc:rbj6reygdb6svaanpqoiw4tu/app.bsky.feed.post/3lyds2e6fs22h`

**Migration Plan:**
- Replace individual embeds with BlueskyTimeline component from Astro starter
- Update with actual Bluesky handle: `@allardlab.bsky.social`

---

### 2.5 Font Files & Loading Strategy

**Current Implementation:**
- **Font Family:** `"supria-sans", Arial, sans-serif`
- **Defined in:** `_sass/_02_settings_typography.scss`
- **Loading Method:** Google WebFont Loader in `_includes/_head.html`

**Font Files Found:**
- `/assets/fonts/` contains **icon fonts only** (iconfont.eot, .ttf, .woff, .svg)
- **No supria-sans font files found** - suggests it's loaded from a CDN or system font

**Discovery:** Checking `_includes/_head.html`:
```javascript
WebFont.load({
    google: {
        // families configuration (not shown in excerpt)
    }
});
```

**Conclusion:** supria-sans appears to be a web font, likely from Google Fonts or Adobe Fonts

**Migration Action Required:**
1. Investigate actual font loading source (check full `_head.html` or network requests)
2. Decide: Self-host vs CDN
3. If self-host: Acquire font files with proper licensing
4. If CDN: Add appropriate `<link rel="preload">` for performance

**For Phase 2:** Research supria-sans availability and licensing

---

### 2.6 Inline Styles Summary

**Pages with embedded `<style>` blocks:**

| Page | Lines | Complexity | Components |
|------|-------|------------|------------|
| `science.md` | 6-23 | Low | `.embeddedright`, `.embeddedleft` |
| `people.md` | 6-86 | High | `.peoplewrapper`, `.photo-gallery`, `.photo-grid`, `.photo-item` |
| `publications.md` | 7-40 | Medium | `.publist`, `.paper-title` |

**Extraction Strategy:**
1. Copy all CSS to Astro `src/styles/global.scss`
2. Organize into sections:
   - Science page components
   - People page components
   - Publications page components
3. Consider creating Astro components for complex items (photo gallery)
4. Test responsive breakpoints are preserved

---

## Step 3: Verify Style Tokens in Astro Starter

### Astro Starter Analysis: `allardlab-astro-starter/src/styles/_colors.scss`

✅ **CyPu Color Palette - Fully Ported**

| Color Token | Hex | Jekyll Variable | Astro Variable | Status |
|-------------|-----|-----------------|----------------|--------|
| Navy | `#1D3038` | `$juns-CyPu-Navy` | `$navy` / `--color-bg` | ✅ |
| Cyan | `#45B29D` | `$juns-CyPu-Cyan` | `$cyan` / `--color-link` | ✅ |
| Red | `#BE1E2D` | `$juns-CyPu-Red` | `$red` / `--color-danger` | ✅ |
| Gold | `#FEEB7C` | `$juns-CyPu-Gold` | `$gold` / `--color-highlight` | ✅ |
| Light Text | `#E4E4E4` | `$grey-1` | `$text-light` / `--color-text` | ✅ |
| White | `#FFFFFF` | `#FFFFFF` | `$white` | ✅ |

**Implementation Notes:**
- Astro starter uses both SCSS variables (`$navy`) and CSS custom properties (`--color-bg`)
- Hover states correctly configured: `--color-link-hover: #FEEB7C` (gold)
- Background and text colors match Jekyll theme exactly

### Typography Verification

**Jekyll:** `"supria-sans", Arial, sans-serif`
**Astro:** `font-family: "supria-sans", Arial, sans-serif;` in `global.scss`

✅ **Font stack matches exactly**

⚠️ **Action Required:** Font loading implementation needed in Phase 2

### Layout Components in Astro Starter

**Verified in `src/layouts/BaseLayout.astro` and `src/styles/global.scss`:**

| Component | Status | Notes |
|-----------|--------|-------|
| Masthead (white) | ✅ | `background: #FFFFFF` on `.site-header` |
| Navigation (navy) | ✅ | `background: #1D3038` on `.topnav` |
| Footer (navy) | ✅ | `background: #1D3038` on `.footer` |
| Utility classes | ⚠️ | Only `.t10`-`.t30`, `.b15`-`.b60` - needs `.t40`-`.t90`, `.l15`, `.r15`, padding utils |
| People grid | ❌ | Not yet implemented - need to add from Phase 1 inventory |
| Photo gallery | ❌ | Not yet implemented - need to add from Phase 1 inventory |
| Publication styles | ❌ | Not yet implemented - need to add from Phase 1 inventory |

---

## Phase 1 Summary & Checklist

### ✅ Completed Tasks

- [x] Jekyll freeze branch verified (`jekyll-freeze` exists)
- [x] All 6 pages inventoried with migration notes
- [x] 47 images cataloged by category
- [x] Custom CSS components extracted from 3 pages
- [x] Third-party widgets documented (GitHub Cards, Bluesky embeds)
- [x] Font loading strategy analyzed (supria-sans investigation)
- [x] Inline styles summary created
- [x] Astro starter color palette verified (100% match)

### 📋 Key Findings

1. **Content Structure:** Simple, clean 6-page site with flat navigation
2. **Images:** 47 files, mostly group photos (candidates for WebP conversion)
3. **CSS Complexity:** Moderate - well-structured modern CSS (Grid, flexbox)
4. **Third-Party Dependencies:** 2 widgets (GitHub Cards, Bluesky)
5. **Font Mystery:** supria-sans not in repo, likely CDN-loaded
6. **Liquid Templating:** All pages use `{{ site.urlimg }}` and `{{ site.urlfiles }}`

### 🚀 Ready for Phase 2

**Prerequisites Met:**
- ✅ Rollback safety (jekyll-freeze branch)
- ✅ Complete asset inventory
- ✅ CSS components documented
- ✅ Style tokens verified in Astro starter
- ✅ Migration path clear

**Next Steps (Phase 2):**
1. Move Astro starter to working directory
2. Run `npm install` and test dev server
3. Investigate supria-sans font loading
4. Add CNAME file for `www.allardlab.com`
5. Configure `astro.config.mjs` with site URL

---

**Phase 1 Complete:** 2025-10-28
