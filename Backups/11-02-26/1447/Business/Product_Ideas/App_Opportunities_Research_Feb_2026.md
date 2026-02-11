# App Opportunities Research - Feb 2026

**Research Date:** February 5, 2026  
**Objective:** Identify high-demand desktop app categories aligned with privacy-first, offline-first, local-only principles

---

## Timeline Clarification

**"2-3 months effort" = My development time**
- I'm a coding agent that works 24/7
- I can build full apps in days/weeks, not months
- Timeline includes: MVP → testing → polish → launch
- Human review/feedback cycles add time

**Realistic timeline with me building:**
- Simple app: 3-7 days
- Medium app: 1-2 weeks  
- Complex app: 2-4 weeks

---

## 🥇 #1: Local-First Bookmark Manager
**Score: 9/10 — HIGHEST OPPORTUNITY**

### Overview
Desktop app that saves bookmarks locally + auto-archives webpages for offline reading. Full-text search, tags, browser extension — all without cloud.

### The Problem
- Links rot (404s) — average webpage lifespan is 100 days
- Pocket/Raindrop = subscriptions + your reading history in their cloud
- Privacy-conscious users don't want their reading tracked
- No good offline alternative exists

### Market Signal
- Only **94 products** on Gumroad (underserved!)
- ArchiveBox: **15k+ GitHub stars** (proves demand)
- r/selfhosted: Regular "bookmark manager" recommendation threads

### Effort: Medium (5-10 days)
- SQLite + Tauri/Electron
- Browser extensions (Chrome/Firefox)
- Single-file webpage archival
- Full-text search

### Price: $29-99

### Competitors & Examples

| Tool | URL | What They Do | Why They Suck |
|------|-----|--------------|---------------|
| **ArchiveBox** | https://archivebox.io | Self-hosted web archiving | Requires server, complex setup |
| **Pocket** | https://getpocket.com | Cloud bookmarking + read later | Subscription, Mozilla owns your data |
| **Raindrop** | https://raindrop.io | Cloud bookmark manager | $3/mo subscription, cloud only |
| **Linkding** | https://github.com/sissbruecker/linkding | Self-hosted bookmark manager | Requires server technical knowledge |
| **Wallabag** | https://wallabag.it | Self-hosted read-later | Self-hosted complexity |
| **Pinboard** | https://pinboard.in | Simple bookmarking | $22/year, no archival, dated UI |

### Our Angle
- Desktop app = no server needed
- Auto-archival = every bookmark saved as single-file HTML
- Full-text search = find any word in any saved page
- Single purchase = no subscription

---

## 🥈 #2: Distraction-Free Writing Studio with Offline AI
**Score: 8/10 — HIGH OPPORTUNITY**

### Overview
Minimalist writing app with **on-device AI** (grammar, style, summarization). No cloud, no subscriptions, 100% offline.

### The Problem
- Writers want AI help but don't want work sent to OpenAI servers
- Grammarly = cloud-only, privacy nightmare
- Ulysses = Mac-only, $40/year subscription
- No tool combines: offline + local AI + beautiful UI + single purchase

### How Offline AI Works

**The AI Stack:**
1. **llama.cpp** or **Ollama** — run LLMs locally on CPU/GPU
2. **Tiny models** (1B-3B parameters) — small enough for consumer laptops
3. **Specific tasks** — grammar checking, style suggestions, summarization

**Example Models:**
- **Phi-2/Phi-3** (Microsoft) — 2.7B params, runs on any modern laptop
- **Llama 3 8B** — larger but powerful, needs 8GB+ RAM
- **Qwen 2.5** — 3B version excellent for writing tasks
- **Mistral 7B** — higher quality, needs more RAM

**How It Works:**
1. User downloads AI model once (~2-5GB file)
2. Model loads into memory when app starts
3. All AI processing happens on-device
4. Zero network calls = zero privacy risk

**What the AI Does:**
- Grammar/spelling correction
- Style suggestions ("make this more concise")
- Tone adjustments ("make this more professional")
- Summarization of selected text
- Continuation suggestions (writer's block help)

### Market Signal
- 1,743 writing tools on Gumroad (high demand)
- Growing "AI privacy" movement
- Local LLM tools (Ollama) trending on GitHub

### Effort: Complex (2-3 weeks)
- Rich text editor
- Local LLM integration
- AI model management (download/cache)
- UI for AI suggestions

### Price: $39-149

### Competitors & Examples

| Tool | URL | What They Do | Why They Suck |
|------|-----|--------------|---------------|
| **Ulysses** | https://ulysses.app | Mac writing app | $40/year, Mac only, cloud sync |
| **iA Writer** | https://ia.net/writer | Minimalist writing | Limited AI, no offline AI features |
| **Grammarly** | https://grammarly.com | AI writing assistant | Cloud-only, privacy risk, subscription |
| **Notion AI** | https://notion.so | AI in Notion | Cloud-only, requires Notion subscription |
| **Obsidian** | https://obsidian.md | Markdown notes | AI requires plugins, not built-in |
| **MiaoYan** | https://github.com/tw93/MiaoYan | Chinese Markdown editor | No AI, basic features |
| **MarkText** | https://github.com/marktext/marktext | Markdown editor | No AI, maintenance mode |

### Our Angle
- First writing app with **built-in offline AI**
- Grammar/style/summarization without sending data to cloud
- Beautiful focus mode with typewriter scrolling
- Single purchase, own forever

---

## 🥉 #3: Visual PKM (Infinite Canvas)
**Score: 7/10 — MEDIUM-HIGH**

### Overview
Heptabase-style infinite canvas for visual thinking + note-taking, but local-first. Spatial organization, bidirectional linking, embed anything.

### The Problem
- Heptabase = $10/month subscription
- Figma/Miro = cloud-only, expensive
- Obsidian Canvas = clunky, not the primary focus
- No local alternative exists

### Market Signal
- Heptabase consistently trending on Product Hunt
- 730+ Notion templates on Gumrad (PKM demand)
- r/Notion: Regular complaints about privacy/offline

### Effort: Complex (3-4 weeks)
- Canvas rendering engine (Pixi.js or custom)
- Infinite zoom performance
- File format design (portable)
- Rich embedding system

### Price: $49-199

### Competitors & Examples

| Tool | URL | What They Do | Why They Suck |
|------|-----|--------------|---------------|
| **Heptabase** | https://heptabase.com | Visual knowledge base | $10/mo subscription, cloud sync |
| **Figma** | https://figma.com | Design tool | Cloud-only, not for notes |
| **Miro** | https://miro.com | Whiteboard tool | Expensive subscriptions |
| **Obsidian Canvas** | https://obsidian.md | Canvas in Obsidian | Clunky, limited features |
| **Excalidraw** | https://excalidraw.com | Sketching tool | Web-based, no persistent storage |
| **Scrintal** | https://scrintal.com | Visual note-taking | Subscription, cloud-only |
| **Kosmik** | https://kosmik.app | Visual workspace | Subscription, cloud-only |

### Our Angle
- Heptabase power with local-first architecture
- Everything in a folder of files you own
- No subscription, no cloud required
- SVG export = future-proof

---

## Quick Comparison

| App | Effort | Price | Competition | Risk | My Pick |
|-----|--------|-------|-------------|------|---------|
| Bookmark Manager | 5-10 days | $29-99 | Very Low | Low | **#1** |
| Writing Studio | 2-3 weeks | $39-149 | Medium | Medium | #2 |
| Visual PKM | 3-4 weeks | $49-199 | Medium | Higher | #3 |

---

## Recommendation

**Build #1: Bookmark Manager first**

**Why:**
- Fastest to market (1 week)
- Least competition
- Universal need (everyone has broken links)
- Clear technical differentiation
- Proves concept before bigger investments

**Then:** #2 Writing Studio (reuse infrastructure)

---

## Research Sources

- GitHub: github.com/topics/local-first (770+ repos)
- GitHub: github.com/topics/offline-first (1,472+ repos)
- Gumroad Discover: gumroad.com/discover
- Reddit: r/selfhosted, r/privacy, r/productivity
- Product Hunt: producthunt.com

---

*Next step: Pick one and I'll start building the MVP.*
