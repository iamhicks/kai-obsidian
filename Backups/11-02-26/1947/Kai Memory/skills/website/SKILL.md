# Website Codebase Documentation

**Status:** ✅ Active  
**URL:** iamhicks.com  
**Hosting:** GitHub Pages  
**Location:** `~/Documents/Kai/Repos/website/`

---

## Structure

```
website/
├── index.html              # Homepage
├── about/
│   └── index.html          # About page
├── mind-demo/              # ← MOVE TO mind/demo/ (deprecated location)
│   └── index.html
├── flow-demo/              # ← MOVE TO flow/demo/ (deprecated location)
│   └── index.html
├── edge-demo/              # Edge product demo
├── mission-control/        # OpenClaw monitoring dashboard
├── CNAME                   # Custom domain config
└── .git/                   # GitHub repo
```

---

## Homepage (index.html)

**What:** Marketing site for i_am_Hicks product suite  
**Tech:** Static HTML/CSS, GitHub Pages  
**Design:** Monochrome (v2)

### Design System
- **Colors:** #F1F1F1 (off-white), #1B1B1D (dark)
- **Typography:** Fraunces (headings), Inter (body)
- **Buttons:** Flat, no gradients
- **Dividers:** Static waves (removed animations)
- **No animations** — Prevents rendering issues

### Products Listed
| Product | Status | Price |
|---------|--------|-------|
| Mind | ✅ Available | $29 |
| Flow | 🚫 Coming soon | $29 |
| Edge | 🚫 Coming soon | TBD |
| Bundle | ✅ Available | $49 |

---

## Critical Rules

### DO:
- Keep monochrome design (no color creep)
- Use cache-busting on all CSS/JS changes (`?v=2`)
- Test on mobile (responsive breakpoints)
- Commit and push after every change
- Update CNAME if domain changes

### DO NOT:
- Add animations (performance issues)
- Use gradients (violates design system)
- Add external tracking scripts (privacy)
- Change hosting without redirects

---

## Deployment

```bash
cd ~/Documents/Kai/Repos/website/
git add -A
git commit -m "Description of changes"
git push origin main
# GitHub Pages auto-deploys from main branch
# Add ?v=2 to any changed asset URLs to bust cache
```

---

## Cache Issues

**Problem:** GitHub Pages CDN caches aggressively  
**Solution:** Add version query to changed files

```html
<!-- Before -->
<link rel="stylesheet" href="styles.css">

<!-- After -->
<link rel="stylesheet" href="styles.css?v=2">
```

---

## Mission Control

**What:** Dashboard for monitoring OpenClaw  
**Status:** ✅ Working  
**Features:**
- Token usage display
- Gateway status
- Cron job list
- Session history

**Access:** iamhicks.com/mission-control/  
**Security:** Password protected (check MEMORY.md)

---

## Cleanup Needed

### Deprecated Folders (to be removed):
- `website/mind-demo/` → Use `mind/demo/` instead
- `website/flow-demo/` → Use `flow/demo/` instead
- `website/mind/` → Empty, delete
- `website/flow/` → Empty, delete
- `website/mind-tauri/` → Use `mind/app/` instead

### Keep in website/:
- `index.html` (homepage)
- `about/` (about page)
- `mission-control/` (dashboard)
- `CNAME` (domain config)

---

## Stability

- ✅ **Homepage:** Battle-tested, works reliably
- ✅ **GitHub Pages:** Stable hosting
- ⚠️ **Mission Control:** New, monitor for issues
- ❌ **Demos in website/:** Deprecated, move to proper repos

---

## Next Steps

- [ ] Remove deprecated demo folders from website/
- [ ] Update homepage with latest product status
- [ ] Add download links for MIND desktop app (when ready)
- [ ] SEO optimization (meta tags, descriptions)

---

*Last updated: 09-02-2026*
