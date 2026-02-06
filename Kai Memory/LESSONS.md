# Lessons Learned — Mind App Rebuild

## Session: 2026-02-05

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

*Last updated: 2026-02-05 by Kai*
