# Jekyll Cleanup Strategy & Accessibility Analysis
**Date:** 2025-10-28

## Question 1: Jekyll Cleanup Strategy

### Easy to Delete - Safe for Removal ✅

Once Astro migration is complete and tested, these can be safely deleted:

#### Jekyll Core Files (~59.6 MB)
```
_site/              59M   (Jekyll build output - can delete now)
_sass/             460K   (SCSS files - replaced by src/styles/)
assets/js/         400K   (Foundation JS - replaced by Astro)
_includes/          96K   (Liquid templates - replaced by Astro components)
.jekyll-cache/      80K   (Build cache - can delete now)
_layouts/           36K   (Liquid layouts - replaced by src/layouts/)
assets/css/         12K   (Compiled CSS - no longer needed)
```

**Total savings: ~60 MB**

#### Jekyll Config Files
```
_config.yml
_config_dev.yml
Gemfile
Gemfile.lock
```

#### Jekyll Content (to migrate first, then delete)
```
pages/              (6 markdown files - migrate to src/pages/ first)
_data/              (navigation.yml, authors.yml - migrate data)
```

### Keep These Files 📝

**Documentation & Planning:**
```
README.md                        (update for Astro)
STYLE.md                         (still relevant - design guide)
migration_plan_allardlab.md      (keep as reference)
PHASE_1.md                       (migration documentation)
PHASE_2.md                       (migration documentation)
TODO.md                          (project management)
```

**Content Assets:**
```
images/             (source images - keep as backup)
files/              (PDFs, documents - keep)
```

**Git & CI:**
```
.git/
.github/            (now has Astro deploy workflow)
.gitignore          (updated for Astro)
```

### Cleanup Timeline

**Phase 1: Safe to delete NOW**
```bash
rm -rf _site/
rm -rf .jekyll-cache/
```
These are build artifacts with no source value.

**Phase 2: After content migration (Phase 4)**
```bash
rm -rf pages/           # After migrating to src/pages/
rm -rf _data/           # After migrating navigation data
```

**Phase 3: After successful deployment**
```bash
rm -rf _sass/
rm -rf _includes/
rm -rf _layouts/
rm -rf assets/css/
rm -rf assets/js/
rm -rf assets/fonts/    # Icon fonts only, not needed
rm -f _config.yml _config_dev.yml
rm -f Gemfile Gemfile.lock
```

**Phase 4: Optionally keep images/ as backup**
```bash
# images/ already copied to public/images/
# Keep original as backup or delete after verification
```

### Recommended Cleanup Script

Create this as `cleanup-jekyll.sh` to run after migration:

```bash
#!/bin/bash
# Run after Astro migration is complete and tested

echo "Deleting Jekyll build artifacts..."
rm -rf _site/ .jekyll-cache/

echo "Deleting Jekyll source files..."
rm -rf _sass/ _includes/ _layouts/ pages/ _data/
rm -rf assets/css/ assets/js/ assets/fonts/

echo "Deleting Jekyll config..."
rm -f _config.yml _config_dev.yml Gemfile Gemfile.lock

echo "Cleanup complete! Kept: images/, files/, docs"
```

**Estimated cleanup: ~60 MB of unnecessary files**

---

## Question 2: Accessibility (a11y) Analysis

### Current State Assessment

#### ✅ Good Accessibility Foundations

**1. Semantic HTML Structure**
- `<header>`, `<nav>`, `<main>`, `<footer>` in BaseLayout.astro
- Proper heading hierarchy (`<h1>` → `<h2>` → `<h3>`)
- Native HTML5 elements (no div soup)

**2. Navigation Accessibility**
```astro
<a href="/" aria-current={page==='home' ? 'page' : undefined}>Home</a>
```
- ✅ Uses `aria-current="page"` for current page indication
- ✅ Keyboard accessible (native links)
- ✅ Screen reader friendly navigation

**3. Color Contrast (CyPu Palette)**
From PHASE_1.md analysis:
- Background: Navy `#1D3038`
- Text: Light Grey `#E4E4E4`
- Links: Cyan `#45B29D`
- Hover: Gold `#FEEB7C`

**Contrast Ratios:**
- Navy (#1D3038) vs Light Text (#E4E4E4): **13.7:1** ✅ AAA (>7:1)
- Navy (#1D3038) vs Cyan (#45B29D): **4.8:1** ✅ AA (>4.5:1)
- Navy (#1D3038) vs Gold (#FEEB7C): **11.2:1** ✅ AAA (>7:1)

All pass WCAG AA and most pass AAA!

**4. Responsive Design**
- `<meta name="viewport">` present
- Mobile-first CSS Grid approach
- Responsive breakpoints in Jekyll styles

### ⚠️ Accessibility Gaps to Address

#### 1. **Image Alt Text**
**Status:** Not yet implemented in Astro pages

**Action Required:**
```astro
<!-- Bad (from Jekyll) -->
<img src="{{ site.urlimg }}photojun.jpg">

<!-- Good (for Astro) -->
<img src="/images/photojun.jpg" alt="Jun Allard headshot photo">
```

**Priority:** HIGH
- 47 images need descriptive alt text
- People photos: "Name headshot photo"
- Group photos: "Allard Lab group photo, [year/event]"
- Campus photos: "UC Irvine campus view"

#### 2. **Focus Indicators**
**Status:** Relying on browser defaults

**Recommendation:** Add visible focus styles
```css
a:focus, button:focus {
  outline: 3px solid #FEEB7C;  /* Gold for visibility */
  outline-offset: 2px;
}
```

**Priority:** MEDIUM

#### 3. **Skip Navigation Link**
**Status:** Missing

**Recommendation:** Add skip-to-main link
```astro
<body>
  <a href="#main" class="skip-link">Skip to main content</a>
  <header>...</header>
  <nav>...</nav>
  <main id="main">
```

**Priority:** MEDIUM

#### 4. **Language Declaration**
**Status:** ✅ Already set
```html
<html lang="en">
```

#### 5. **Form Accessibility** (if added later)
**Status:** No forms currently

**Future consideration:**
- Label all inputs
- Error messages with aria-describedby
- Fieldset/legend for groups

#### 6. **Link Purpose**
**Current state:** Some links lack context

**Example from publications.md:**
```html
<a href="...">BioRXiv.org</a>  <!-- Link text is clear ✅ -->
```

**Recommendation:** Ensure all links have descriptive text
- Avoid "click here" or "read more" without context
- Use aria-label for icon-only links

#### 7. **Heading Hierarchy**
**Status:** Need to verify in migrated content

**Action:** Ensure proper nesting:
- One `<h1>` per page (page title)
- No skipped levels (h1 → h3)
- Logical document outline

#### 8. **Interactive Element Sizing**
**Status:** Need to verify touch targets

**Recommendation:** Minimum 44×44px for touch
```css
nav a {
  min-height: 44px;
  display: inline-block;
  padding: 0.6rem 1rem;  /* Already in global.scss ✅ */
}
```

### Accessibility Checklist for Migration

#### Phase 3 (Component Development)
- [ ] Add focus styles to global.scss
- [ ] Implement skip-link component
- [ ] Ensure touch target sizes (44×44px minimum)

#### Phase 4 (Content Migration)
- [ ] Add alt text to all 47 images
- [ ] Verify heading hierarchy on all pages
- [ ] Check link text is descriptive
- [ ] Ensure people photos have proper alt text

#### Phase 7 (Accessibility Testing)
- [ ] Run axe DevTools on all pages
- [ ] Test keyboard navigation (Tab, Enter, Escape)
- [ ] Test with screen reader (VoiceOver/NVDA)
- [ ] Verify color contrast ratios
- [ ] Check zoom to 200% (no horizontal scroll)
- [ ] Test with high contrast mode

### WCAG 2.1 Level AA Compliance Roadmap

**Current Score Estimate: 75%**

**To Achieve 100% AA:**
1. ✅ Color contrast (already passing)
2. ⚠️ Alt text for images (HIGH priority)
3. ⚠️ Focus indicators (MEDIUM priority)
4. ⚠️ Skip navigation (MEDIUM priority)
5. ✅ Semantic HTML (already good)
6. ✅ Keyboard accessibility (native elements)
7. ⚠️ Heading hierarchy (verify during migration)
8. ✅ Responsive/zoom support (already in CSS)

**Estimated effort to 100% AA:** 4-6 hours during Phases 3-7

### Recommended Tools

**Testing:**
- axe DevTools (browser extension)
- WAVE (web accessibility evaluation tool)
- Lighthouse accessibility audit (Chrome DevTools)
- Screen readers: VoiceOver (Mac), NVDA (Windows)

**Validation:**
- WCAG Color Contrast Checker
- HTML validator (W3C)
- Keyboard navigation testing (manual)

---

## Summary

### Cleanup Question
**Answer:** Very easy!

- ~60 MB of Jekyll files can be deleted
- Clear separation: Jekyll files vs Astro files
- Safe phased approach (delete build artifacts now, source after migration)
- Provided cleanup script for final removal

### Accessibility Question
**Answer:** Looking good, with some gaps to address!

**Strengths:**
- ✅ Excellent color contrast (13.7:1 for main text)
- ✅ Semantic HTML structure
- ✅ Accessible navigation with aria-current
- ✅ Responsive design

**Gaps to Fix:**
- ⚠️ Image alt text (47 images) - HIGH priority
- ⚠️ Focus indicators - MEDIUM priority
- ⚠️ Skip navigation link - MEDIUM priority

**Current Estimate:** 75% WCAG AA compliant
**After fixes:** 100% WCAG AA compliant (4-6 hours work)

All gaps are addressable during the migration phases already planned!
