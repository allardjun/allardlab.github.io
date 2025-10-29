# Allard Lab Website Style Guide

This document describes the design system, color palette, typography, and styling architecture of the Allard Lab website.

## Design Philosophy

The website employs a **modern academic aesthetic** with a distinctive dark theme that balances professionalism with visual interest. The design emphasizes readability, accessibility, and a clean, contemporary feel appropriate for a research laboratory.

## Color Palette

### Primary Colors (CyPu Theme)

The site uses a custom "Cyan-Purple" (CyPu) color scheme defined in `_sass/_01_settings_colors.scss`:

| Color Name | Hex Code | SCSS Variable | Usage |
|------------|----------|---------------|--------|
| Navy Blue | `#1D3038` | `$juns-CyPu-Navy` | Primary background, navigation, footer |
| Turquoise/Cyan | `#45B29D` | `$juns-CyPu-Cyan` | Primary accent, links, highlights, hover states |
| Red | `#BE1E2D` | `$juns-CyPu-Red` | Alerts, warnings, emphasis |
| Gold | `#FEEB7C` | `$juns-CyPu-Gold` | Success messages, info highlights |

### Theme Colors

The site uses a **dark theme** approach:

- **Background**: Navy (#1D3038)
- **Text**: Light Grey (#E4E4E4)
- **Highlights**: Cyan (#45B29D)
- **Masthead**: White (#FFFFFF)

### Grey Scale

A comprehensive grey scale is defined for subtle variations:
- `$grey-1` through `$grey-16` ranging from #E4E4E4 (lightest) to #0B0B0B (darkest)

## Typography

### Font Family

**Primary Font**: `"supria-sans"`
- Fallbacks: Arial, sans-serif
- Used for all text: headers, body, navigation
- Defined in `_sass/_02_settings_typography.scss`

### Font Sizes

- **Base**: 16px
- **Line Height**: 1.5
- **Headers** (using modular scale):
  - H1: 2.2em
  - H2: 1.953em
  - H3: 1.563em
  - H4: 1.25em
  - H5: 1.152em
- **Small text**: 0.8em

### Font Weights

- **Normal**: 400 (regular)
- **Bold**: 700

## Layout Components

### Masthead

Located in `_sass/_07_layout.scss`:

- **Background**: White (#FFFFFF)
- **Height**: 175px (adjusts responsively)
- **Title Font**: supria-sans, bold, 22.9pt, black
- **Subtitle Font**: supria-sans, bold, 10pt, black
- **Description Font**: supria-sans, bold, 14.9pt, black
- **Layout**: Centered, table-cell vertical alignment

### Navigation

Defined in `_sass/_01_settings_colors.scss` (lines 94-123):

- **Background**: Navy (`$juns-CyPu-Navy`)
- **Link Color**: White
- **Hover Color**: Cyan (`$juns-CyPu-Cyan`)
- **Active State**: Cyan with navy background
- **Text Transform**: Uppercase
- **Font Size**: 15px (rem-calc)
- **Visual Effect**: Subtle box shadow (0 2px 3px rgba(0,0,0,.2))

### Footer

- **Background**: Navy (`$darktheme-background`)
- **Text Color**: White
- **Link Color**: Grey-8 (#7E7E7E)
- **Header Style**: Uppercase, letter-spacing: 1px
- **Subfooter**: Same navy background with grey text

### Social Icons

- **Size**: 36px circular
- **Font Size**: 23px (rem-calc)
- **Background**: Grey on navy
- **Hover**: Navy on white

## Configuration Files

The styling system is organized in a modular SCSS architecture:

### Core Settings Files

1. **`_sass/_01_settings_colors.scss`**
   - All color variables
   - Custom CyPu palette definitions
   - Theme color assignments (dark/light)
   - Component-specific colors (topbar, footer, code highlighting)

2. **`_sass/_02_settings_typography.scss`**
   - Font family declarations
   - Font size variables
   - Modular scale definitions
   - Base typography settings

3. **`_sass/_03_settings_mixins_media_queries.scss`**
   - Media query breakpoints
   - Responsive design mixins

4. **`_sass/_04_settings_global.scss`**
   - Foundation framework settings
   - Global component configurations
   - Border radius, spacing units
   - Component overrides for tables, buttons, forms, etc.

### Layout & Components

5. **`_sass/_07_layout.scss`**
   - Masthead styles and responsive variants
   - Navigation layout
   - Footer and subfooter
   - Breadcrumb navigation
   - Utility margin/padding classes
   - Custom grid layouts (e.g., `.peoplewrapper`)

6. **`_sass/_06_typography.scss`**
   - Typography implementation
   - Text styling classes

7. **`_sass/_09_elements.scss`**
   - HTML element base styles

8. **`_sass/_11_syntax-highlighting.scss`**
   - Code block syntax highlighting

## Foundation Framework

The site is built on the **Zurb Foundation** framework with extensive customization:

- Grid system: 12 columns
- Responsive breakpoints: small, medium, large, xlarge
- Components customized: buttons, forms, tables, navigation, panels, etc.

## Responsive Design

### Breakpoints

The site adapts to different screen sizes with these masthead adjustments:

- **Small only**: 200px height, logo hidden
- **Medium only**: 280px height
- **Large only**: 310px height
- **XLarge and up**: 380px height

## Custom Components

### People Grid

Defined in `_sass/_07_layout.scss` (lines 406-418):

```scss
.peoplewrapper {
    display: grid;
    grid-template-columns: 1fr 2fr;
    align-items: center;
    grid-gap: 1em;
    row-gap: 1em;
    padding-bottom: 1em;
}
```

## Utility Classes

Margin and padding utilities defined in `_sass/_07_layout.scss`:

- **Top margins**: `.t10` through `.t90`
- **Bottom margins**: `.b15` through `.b60`
- **Left/Right margins**: `.l15`, `.r15`
- **Padding**: `.pl20`, `.pr5`, `.pr10`, `.pr20`

## Best Practices

### When Adding New Styles

1. **Colors**: Add new color variables to `_sass/_01_settings_colors.scss`
2. **Typography**: Modify font settings in `_sass/_02_settings_typography.scss`
3. **Layout Components**: Add to `_sass/_07_layout.scss`
4. **Use Variables**: Always reference SCSS variables rather than hardcoding colors
5. **Follow Naming**: Use descriptive variable names following existing patterns

### Maintaining Brand Consistency

- **Primary Accent**: Always use `$juns-CyPu-Cyan` (#45B29D) for interactive elements
- **Backgrounds**: Use `$juns-CyPu-Navy` (#1D3038) for dark sections
- **Typography**: Stick to supria-sans for brand consistency
- **Contrast**: Maintain high contrast for accessibility (light text on dark backgrounds)

## Jekyll Configuration

Font and theme settings are also referenced in `_config.yml`:

- Site title, slogan, and descriptions
- Base URL configuration
- SASS compilation settings (compressed output)

## Browser Support

The design uses modern CSS features:
- CSS Grid (for people wrapper)
- Flexbox
- rem units for scalable typography
- CSS variables via SCSS preprocessing

---

**Last Updated**: 2025-10-26
**Maintained By**: Allard Lab
**Framework**: Jekyll + Foundation 5 + Custom SCSS
