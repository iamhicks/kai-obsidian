# MIND Codebase Documentation

**Status:** ✅ Active  
**Product:** AI-powered notes & knowledge  
**Price:** $29 one-time  
**Location:** `~/Documents/Kai/Repos/mind/`

---

## Structure

```
mind/
├── demo/           # Web demo (iamhicks.com/mind-demo/)
│   └── index.html  # Single 7,355-line file
└── app/            # Tauri desktop app (downloadable)
    ├── Cargo.toml
    ├── tauri.conf.json
    ├── index.html  # Copied from demo
    └── src/
        └── main.rs
```

---

## Demo (`demo/`)

**What:** Web-based demo for website  
**Tech:** Vanilla HTML/CSS/JS (single file)  
**Size:** ~7,355 lines, ~335KB  
**Deploy:** GitHub Pages (iamhicks.com/mind-demo/)

### Key Features
- Notion-inspired UI (light/dark themes)
- Folder hierarchy with drag-and-drop
- WYSIWYG editor with markdown support
- Tag system with autocomplete
- Version history
- AI integration (via Ollama)
- LocalStorage persistence (demo only)

### Architecture
- **Single file architecture** — Everything in index.html
- **No build step** — Direct file deployment
- **State management:** LocalStorage (demo), file system (app)
- **AI:** WebLLM (abandoned) → Ollama local API

### Stability
- ✅ **Battle-tested:** Core note-taking works reliably
- ⚠️ **Fragile:** AI integration needs Ollama running
- ⚠️ **Mobile:** Basic responsive CSS, not optimized
- ❌ **Offline sync:** No cloud backup (by design)

---

## App (`app/`)

**What:** Desktop application (Tauri wrapper)  
**Tech:** Tauri (Rust) + same HTML frontend  
**Platforms:** macOS (.dmg), Windows (.exe), Linux  
**Status:** ⚠️ Not built yet (setup exists, needs compilation)

### Key Differences from Demo
- **No CORS** — Direct Ollama localhost:11434 access
- **File system** — Native file operations (not LocalStorage)
- **Native feel** — Desktop window, menu bar

### Build Requirements
- Rust (1.70+)
- Tauri CLI (`cargo install tauri-cli`)
- Command: `cargo tauri build`

### Stability
- ⚠️ **Unbuilt:** Folder exists but no binaries
- ⚠️ **Outdated:** index.html copied from Feb 8, missing recent fixes
- ❌ **Needs update:** Should rebuild from latest demo before release

---

## Critical Rules

### DO NOT:
- Split into modular files (tried 3x, failed 3x, stick to single file)
- Use WebLLM (storage issues, abandoned)
- Integrate Ollama with OpenClaw system (corrupted config before)
- Add cloud sync (violates offline-first principle)

### DO:
- Keep single-file architecture for demo
- Update `app/index.html` from `demo/` before building
- Test thoroughly after any change (7,355 lines = easy to break)
- Use cache-busting (`?v=2`) on deploy
- Backup before any edit (STANDING_ORDERS.md)

---

## Deployment

### Demo (Website)
```bash
cd ~/Documents/Kai/Repos/website/mind-demo/
# Edit index.html
git add -A && git commit -m "Description"
git push origin main
# Wait for GitHub Pages (add cache-busting ?v=2)
```

### App (Desktop)
```bash
cd ~/Documents/Kai/Repos/mind/app/
# First: copy latest demo/index.html to app/
cp ~/Documents/Kai/Repos/mind/demo/index.html .
cargo tauri build
# Binaries in src-tauri/target/release/
```

---

## Dependencies

### Demo
- Phosphor Icons (CDN: unpkg.com)
- No build dependencies

### App
- Tauri v1.x
- Rust 1.70+
- Ollama (running locally for AI)

---

## Known Issues

1. **GitHub Pages caching** — Deploys don't show immediately (use cache headers)
2. **Ollama CORS** — Web demo can't access Ollama (desktop app fixes this)
3. **Mobile UX** — Touch interactions need work
4. **File size** — 7,355 lines is unwieldy but stable

---

## Next Steps

- [ ] Update `app/index.html` from latest demo
- [ ] Build Tauri binaries (macOS first)
- [ ] Test AI features with local Ollama
- [ ] Code signing for macOS (notarization)
- [ ] Create download page on website

---

*Last updated: 09-02-2026*
