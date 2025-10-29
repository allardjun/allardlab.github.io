# Phase 2 — Astro Scaffold & Font Setup
**Started:** 2025-10-28

## Objectives
1. Move Astro starter to root directory
2. Install dependencies and test dev server
3. Implement supria-sans font loading
4. Configure site URL and custom domain
5. Set up image path handling

---

## Progress Log

### Step 1: Move Astro Starter to Root Directory

**Files Copied:**
- ✅ `src/` directory (layouts, components, pages, styles)
- ✅ `public/` directory (static assets)
- ✅ `package.json` (dependencies)
- ✅ `astro.config.mjs` (Astro configuration)
- ✅ `.github/workflows/deploy.yml` (deployment workflow)

**Status:** Astro project structure now in root directory

---

### Step 2: Install Dependencies


**npm install completed successfully!**

Dependencies installed:
- astro ^4.0.0

---

### Step 3: Test Development Server


---

### Step 5: Configure astro.config.mjs

✅ **Already configured!**

```javascript
site: 'https://www.allardlab.com',
output: 'static',
```

---

### Step 6: Create CNAME File

✅ **Created:** `public/CNAME`

Content:
```
www.allardlab.com
```

This file will be copied to the build output and tells GitHub Pages to use the custom domain.

---

### Step 7: Image Path Strategy

**Jekyll approach:**
```liquid
{{ site.urlimg }}photojun.jpg
```

**Astro approach:**
```astro
/images/photojun.jpg
```

**Implementation:**
- Copy all images from `/images/` to `/public/images/`
- In Astro templates, reference as `/images/filename.jpg`
- At build time, Astro copies `/public/*` to build output
- No `site` variable needed for static assets

**Astro.site usage:**
- Available as `Astro.site` in components
- Used for canonical URLs and sitemaps
- NOT needed for local image paths


---

### Step 8: Copy Images to Public Directory

✅ **Copied:** 47 images from `/images/` to `/public/images/`

All content images are now available for the Astro build.

---

## Phase 2 Summary & Checklist

### ✅ Completed Tasks

- [x] Created PHASE_2.md for progress tracking
- [x] Copied Astro starter files to root directory
  - src/ (layouts, components, pages, styles)
  - public/ (static assets)
  - package.json, astro.config.mjs
  - .github/workflows/deploy.yml
- [x] Installed npm dependencies
  - astro ^4.0.0
  - sass-embedded (SCSS preprocessor)
- [x] Tested dev server successfully
  - Running on http://localhost:4322/
  - Astro v5.15.2
- [x] Implemented supria-sans font loading
  - Adobe Typekit kit ID: zom0olg
  - Added to BaseLayout.astro
  - Preconnect for performance
- [x] Verified astro.config.mjs configuration
  - site: 'https://www.allardlab.com' ✓
  - output: 'static' ✓
- [x] Created CNAME file
  - public/CNAME with www.allardlab.com
- [x] Documented image path strategy
  - Jekyll: {{ site.urlimg }} → Astro: /images/
  - Copied 47 images to public/images/

### 🎯 Key Achievements

1. **Astro environment operational** - Dev server running with SCSS support
2. **Font loading solved** - Adobe Typekit supria-sans configured
3. **Custom domain ready** - CNAME file in place for GitHub Pages
4. **Images migrated** - All 47 content images copied to public directory
5. **Build pipeline ready** - GitHub Actions workflow in place

### 📝 Configuration Summary

**Astro Config:**
```javascript
site: 'https://www.allardlab.com'
output: 'static'
```

**Font Loading:**
```html
<link rel="preconnect" href="https://use.typekit.net" crossorigin>
<link rel="stylesheet" href="https://use.typekit.net/zom0olg.css">
```

**Image Paths:**
- Source: `images/`
- Build: `public/images/`
- Reference in templates: `/images/filename.jpg`

### 🚀 Ready for Phase 3

**Prerequisites Met:**
- ✅ Astro development environment functional
- ✅ Font loading implemented
- ✅ Build configuration complete
- ✅ Static assets in place
- ✅ Custom domain configured

**Next Steps (Phase 3):**
1. Add custom CSS components to global.scss
2. Build .peoplewrapper grid component
3. Build photo gallery component
4. Build publication list styling
5. Extract inline styles from Jekyll pages

---

**Phase 2 Complete:** 2025-10-28
