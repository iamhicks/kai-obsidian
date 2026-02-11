# Development Procedure - Mandatory Checklist

**Applies to:** Every code change, bug fix, or feature deployment

## Step 0: User Intent Capture (CRITICAL)

**Before writing any code:**
- [ ] **Confirm understanding** - Restate what the user asked for
- [ ] **Log the request** - Add to `memory/pending-requests.md` immediately
- [ ] **Self-check** - Ask: "Is this what they actually asked for, or what I think needs fixing?"

**When user mentions:**
- Styling/UI/visual changes → STOP and capture intent
- Copy X to Y → Confirm source and target explicitly
- "Like [other thing]" → Reference that thing directly

## File Structure Rules (NON-NEGOTIABLE)

### Single-File Limit
**Apps > 500 lines MUST be split into modules:**
```
app-name/
├── index.html          # Main HTML shell
├── styles.css          # All styles
├── app.js              # Main application logic
├── components/         # Reusable UI components
│   ├── header.js
│   ├── sidebar.js
│   └── editor.js
└── utils/              # Helper functions
    ├── storage.js
    └── helpers.js
```

**Why:** Single files > 500 lines are unmaintainable, error-prone, and break in subtle ways

**Current apps requiring split:**
- MIND: 57KB single file → MUST split
- FLOW: Single file → MUST split

### Before Creating Any New App
- [ ] Check if existing app needs splitting first
- [ ] Plan file structure on paper/comment
- [ ] Get user approval on structure if > 3 files

## Pre-Deployment Checklist

- [ ] **1. Identify the scope** - What exactly am I changing?
- [ ] **2. Backup current working version** - Never overwrite without a rollback path
- [ ] **3. Make changes in isolation** - Work on a copy, not the live file
- [ ] **4. Test locally first** - Verify the fix works before pushing
- [ ] **5. Check for regressions** - Does it break anything else?
- [ ] **6. Stage and review diff** - Look at what I'm actually changing
- [ ] **7. Deploy to production** - Only after steps 1-6 pass
- [ ] **8. Verify in production** - Open the live site, test the fix
- [ ] **9. Keep backup until verified** - Don't delete rollback option for 24h

## Specific to MIND/Website Changes

- [ ] Check browser console for JS errors
- [ ] Test on mobile viewport (if responsive)
- [ ] Verify all buttons/interactions work
- [ ] Hard refresh to clear cache (`Ctrl+Shift+R` or `Cmd+Shift+R`)

## If I Skip Any Step

**STOP.** If I can't complete a step, I must:
1. Explain why in the commit message
2. Get explicit user approval to proceed anyway
3. Document the risk

## Post-Mortem Rule

If a deployment breaks something:
1. **Immediately rollback** (don't try to fix forward)
2. **Document what went wrong** in LESSONS.md
3. **Update this checklist** to prevent recurrence

---

*This is mandatory. No exceptions.*
