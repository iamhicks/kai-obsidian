# i_am_Hicks Codebase Index

**Organization:** i_am_Hicks  
**Products:** Mind, Flow, Edge  
**Principles:** Offline-first, one-time purchase, local AI, simplicity

---

## Repository Map

```
~/Documents/Kai/Repos/
├── website/                    # Marketing site
│   ├── index.html              # Homepage
│   ├── about/                  # About page
│   └── mission-control/        # OpenClaw dashboard
│
├── mind/                       # Mind product
│   ├── demo/                   # Web demo (iamhicks.com/mind-demo/)
│   │   └── index.html
│   └── app/                    # Desktop app (Tauri)
│       ├── Cargo.toml
│       ├── tauri.conf.json
│       └── src/main.rs
│
├── flow/                       # Flow product (planned)
│   ├── demo/                   # Web demo (empty)
│   └── app/                    # Desktop app (empty)
│
└── edge/                       # Edge product (planned)
    └── (structure TBD)
```

---

## GitHub Repos

Should be organized as:

```
i_am_Hicks/
├── website/              # GitHub Pages (iamhicks.com)
├── mind/
│   ├── demo/             # Web demo
│   └── app/              # Tauri desktop
├── flow/
│   ├── demo/             # Web demo
│   └── app/              # Tauri desktop
└── edge/                 # Future product
```

**Current:** Everything mixed under `hellokaibot-alt/website`

**TODO:** Migrate to proper `i_am_Hicks` org structure

---

## Backup Structure

```
~/Documents/Kai/Backup/
├── OpenClaw/
├── Obsidian/
├── Website/
├── MIND/
│   ├── demo/
│   └── app/
└── FLOW/
    └── (when ready)
```

---

## Shared Patterns

### Design System (All Products)
- Monochrome palette: #F1F1F1, #1B1B1D
- Typography: Fraunces + Inter
- Flat buttons, no gradients
- Static wave dividers

### Architecture (All Products)
- Single-file HTML demos
- Tauri wrappers for desktop
- Ollama for local AI
- No cloud dependencies

### Pricing (All Products)
- $29 per product
- $49 bundle
- One-time purchase
- No subscriptions

---

## Cross-Repo Dependencies

| From | Uses | Notes |
|------|------|-------|
| mind/demo | Phosphor Icons (CDN) | External dependency |
| mind/app | mind/demo/index.html | Copy before build |
| website | mind/demo (currently) | Should be separate |

---

## Development Workflow

1. **Edit demo** (`mind/demo/` or `flow/demo/`)
2. **Test locally** (open index.html in browser)
3. **Deploy demo** (GitHub Pages)
4. **Copy to app** (`cp demo/index.html app/`)
5. **Build desktop** (`cargo tauri build`)
6. **Update website** (download links, screenshots)

---

## Skills Documentation

| Product | Skill File | Status |
|---------|------------|--------|
| Mind | `skills/mind/SKILL.md` | ✅ Complete |
| Website | `skills/website/SKILL.md` | ✅ Complete |
| Flow | `skills/flow/SKILL.md` | 🚫 Not started |
| Edge | `skills/edge/SKILL.md` | 🚫 Not started |

---

## Critical Reminders

1. **Never split MIND into modules** — Tried 3x, failed 3x
2. **No Ollama-OpenClaw integration** — Corrupted config before
3. **No cloud features** — Violates core principles
4. **Cache-bust on deploy** — Add `?v=2` to assets
5. **Backup before edits** — STANDING_ORDERS.md

---

*Last updated: 09-02-2026*
