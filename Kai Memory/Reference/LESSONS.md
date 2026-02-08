# Lessons Learned — Mind App Rebuild

## CRITICAL POST-MORTEM: 05/02/2026 - The Git Checkout Disaster

### What Went Catastrophically Wrong

**Root Cause: Working on the wrong file for 8+ commits**

The polished working version was at:
- `/Users/peteroberts/Documents/Kai/KnowledgeBase/index.html` (root)
- Commit: `0a56d9a`
- Size: 5736 lines

I was "fixing" and deploying:
- `/Users/peteroberts/Documents/Kai/KnowledgeBase/mind-demo/index.html` 
- Broken version
- Size: ~1600 lines

**Why this happened:**
1. Multiple index.html files in different directories
2. GitHub Pages configured to serve from `/mind-demo/` folder
3. I assumed the deployed file was the source of truth
4. Never checked if root index.html was the polished version

**The cascade of failures:**
- Made 15+ "fixes" to the wrong file
- Each "fix" made the UI worse
- Committed and pushed broken versions repeatedly
- Wasted 2+ hours debugging cache issues when the file itself was wrong
- User frustration escalated because the polished UI existed but was inaccessible

### How I Finally Found It

```bash
# Showed commits to root index.html (not mind-demo/)
git log --all --oneline -- index.html

# Found 0a56d9a with 5736 lines - the polished version
git show 0a56d9a:index.html | wc -l
```

### Prevention Measures — NEVER AGAIN

**Rule 1: ALWAYS verify which file is the source of truth**
```bash
# Before touching ANY file, ask:
# - Where is the deployed version coming from?
# - Which file has the most recent "good" commit?
# - What's the line count? (polished version was 3x larger)

# Check all candidate files
ls -la */index.html 2>/dev/null
find . -name "index.html" -type f -exec wc -l {} \;
```

**Rule 2: Use automated cache-busting for GitHub Pages**
```bash
# Always add version query string on deploy
VERSION=$(date +%s)
sed -i '' "s/?v=[0-9]*/?v=$VERSION/g" index.html

# Or use the deploy script: ~/deploy-mind.sh
```

**Rule 3: Check git history BEFORE making changes**
```bash
# Show ALL commits to ANY index.html
git log --all --oneline -- "**/index.html"

# Compare line counts across commits
git show COMMIT:path/to/file | wc -l
```

**Rule 3: When user says "it looks broken," check file size first**
```bash
# Polished version: 5736 lines
# Broken versions: ~1600 lines
# Difference is obvious — should have checked immediately
```

**Rule 4: Never assume — verify with data**
- Don't assume the file in `/mind-demo/` is what's deployed
- Don't assume GitHub Pages is caching (it was serving the wrong file)
- Don't assume "fixes" are improving things (measure with screenshots)

**Rule 5: When lost, ask for help earlier**
- Should have asked: "Which commit had the polished UI?"
- Should have asked: "Show me a screenshot of what it should look like"
- Instead of guessing for 2 hours

### Correct Workflow for Next Time

**When restoring a broken app:**

1. **Find the good version:**
   ```bash
   git log --all --oneline -- "**/*.html" | head -20
   # Look for commit messages mentioning "polish," "UI," "design"
   ```

2. **Compare candidates:**
   ```bash
   for commit in c1 c2 c3; do
     echo "$commit: $(git show $commit:file.html | wc -l) lines"
   done
   ```

3. **Verify visually before deploying:**
   ```bash
   git show GOOD_COMMIT:file.html > /tmp/test.html
   open /tmp/test.html  # Test locally first
   ```

4. **Deploy ONLY after confirmation**

### Emergency Recovery Protocol

**If user says "nothing works":**
1. Stop making new commits
2. Find last known good commit
3. Deploy that exact commit
4. Verify with user
5. Only THEN add features back one by one

### Today's Lessons in One Line

**"When everything is broken, stop fixing and start bisecting."**

---

---

## Lesson: 08/02/2026 - Modular File Rule Not Enforced

### What Went Wrong

**I documented a rule in MEMORY.md but didn't make it mandatory in DEV_PROCEDURE.md**

Feb 5: I wrote "MIND app architecture: Modular files prevent single-point-of-failure issues" in MEMORY.md
Feb 8: Working on MIND/FLOW again, created single files because the rule wasn't in my procedure checklist

**The mistake:** Documentation ≠ Enforcement
- MEMORY.md is reference material (I might read it)
- DEV_PROCEDURE.md is mandatory steps (I must follow it)
- Rules only work if they're in the procedure I follow every session

### The Fix (Done)

Added to DEV_PROCEDURE.md:
- **File Structure Rules (NON-NEGOTIABLE)** section
- Single-file limit: Apps > 500 lines MUST be split
- Mandatory checklist item before creating any new app
- List of current apps requiring split (MIND, FLOW)

### Prevention

**Never assume "I wrote it down somewhere" means "I will follow it"**
- If it's important enough to document, it belongs in DEV_PROCEDURE.md
- Procedure checklist items get checked every session
- Memory items get forgotten

---

## Session: 05/02/2026 (Original Lessons)

### What Went Wrong

**File corruption from multiple overwrites**
- Working versions scattered across git commits
- b66bf50 had bookmarks but no AI
- c770a32 had AI but no bookmarks
- Lesson: Commit every 15-30 minutes, never use `cp` blindly, always verify with `git diff`

**Folder drag-and-drop issues (past sessions)**
- Didn't use proper `dataTransfer` with note IDs
- Handled folders and notes together, causing conflicts
- Didn't prevent dropping on self/children, causing infinite loops
- Lesson: Handle drag separately for folders vs notes; show clear drop zones

### What Went Right

**Fresh rebuild approach**
- Started clean instead of patching broken files
- Single file architecture is maintainable
- Phosphor Icons work consistently

**Git workflow discipline**
- Commit after every major feature addition
- Pushed frequently to avoid local-only work
- Clear commit messages for rollback if needed

### Technical Lessons

**Single-file architecture**
- ✅ Self-contained, deploys anywhere
- ✅ No build step needed
- ⚠️ Can get large; keep JS modular within file
- ⚠️ No hot reload; test locally before every push

**LocalStorage persistence**
- ✅ Works offline, zero backend needed
- ⚠️ 5MB limit — compress images, don't store binaries
- ⚠️ Demo mode needs auto-reset to prevent bloat

**Drag and drop implementation**
```javascript
// Correct approach:
1. Use dataTransfer.setData('noteId', id) / getData('noteId')
2. Check e.target.closest('.folder-header') for drop target
3. Prevent drop on self: if (draggedId === targetFolderId) return
4. Prevent drop on children: recursive check of folder.children
5. Visual feedback: add .drag-over class on dragover, remove on dragleave
```

### Git Workflow Rules

1. **Commit every 15-30 minutes** — not hours
2. **Never use `cp` to overwrite files blindly** — use `git checkout` or merge properly
3. **Always verify with `git diff` before push**
4. **Test locally before every deploy** — `open index.html` in browser
5. **Feature branches for major work** — don't develop on main

### Feature Implementation Checklist

When adding new features, verify:
- [ ] HTML structure in correct location
- [ ] CSS styles added to `<style>` block
- [ ] Event listeners registered in `setupEventListeners()`
- [ ] State management in `KnowledgeBase` class
- [ ] Persistence via `saveData()` / `loadData()`
- [ ] Mobile responsive (test in dev tools)
- [ ] Works in both light/dark themes

### Code Organization Patterns

**Inside KnowledgeBase class:**
```javascript
// Constructor: initialize state
// init(): load data, setup listeners, render
// Data methods: loadData(), saveData(), createX(), deleteX()
// Render methods: render(), renderSidebar(), renderTabs()
// Feature methods: toggleBookmark(), clipWebpage(), etc.
// Utility: escapeHtml(), helpers
```

### Testing Checklist Before Deploy

- [ ] Create new note
- [ ] Edit note title and content
- [ ] Add/remove tags
- [ ] Create folder
- [ ] Move note to folder
- [ ] Bookmark/unbookmark note
- [ ] Open note from bookmarks
- [ ] Switch themes
- [ ] Search notes
- [ ] Mobile layout (sidebar, tabs, editor)
- [ ] Tabs: open, switch, close
- [ ] Import (if applicable)
- [ ] AI features (if applicable)

### Future Improvements

- Add Jest tests for core logic
- Consider splitting JS into modules with import maps
- Add service worker for offline PWA
- IndexedDB instead of LocalStorage for >5MB storage

---

*Last updated: 05/02/2026 by Kai*

---

## Memory File Sync Process

**Obsidian Vault Location:** `/Users/peteroberts/Documents/Kai/Kai_Obsidian/Kai/Kai Memory/`

**Sync Command:**
```bash
cd /Users/peteroberts/.openclaw/workspace && ./sync-to-obsidian.sh
```

**Files Synced:**
- `MEMORY.md` — curated long-term memory
- `SOUL.md` — identity and principles  
- `AGENTS.md` — workspace protocols
- `USER.md` — user preferences
- `IDENTITY.md` — self-identity
- `TOOLS.md` — local tool notes
- `memory/2026-*.md` — daily notes
- `memory/LESSONS.md` — lessons learned

**When to Sync:**
- After ANY `.md` file update
- Before ending a session
- After significant feature completions
- When adding new lessons learned

---
