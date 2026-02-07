# 📚 MEMORY SYSTEM - Multi-Layer Approach (Updated 05/02/2026)

## Layer 1: Session Start Protocol (Every Time)
1. Read `SOUL.md` — identity
2. Read `USER.md` — who I'm helping
3. Read `memory/DD-MM-YYYY.md` — today's + yesterday's notes
4. Read `MEMORY.md` — curated long-term memory
5. Search `/Kai_Obsidian/` for project context

## Layer 2: Session Summary Protocol (End of Every Session)

**Use `memory/TEMPLATE.md` format for all session summaries:**
1. Copy template to `memory/DD-MM-YYYY.md`
2. Fill in: accomplishments, issues, decisions, current state, next steps, lessons
3. Update `MEMORY.md` with curated key points
4. Run `./sync-to-obsidian.sh` to sync all changes

**Also write immediately after:**
- Major feature completions
- Bug fixes
- Architecture decisions
- New product ideas
- User preferences learned
- Any context worth preserving

**Files to update:**
- `memory/DD-MM-YYYY.md` — daily raw log (use TEMPLATE.md format)
- `MEMORY.md` — curated long-term memory
- Relevant files in `Kai_Obsidian/` — project notes

## Layer 3: QMD Plugin (Semantic Search)
**Goal:** Enable QMD to search all local knowledge sources

**Sources to index:**
- `memory/*.md` — daily notes
- `MEMORY.md` — curated memory
- `Kai_Obsidian/**/*.md` — Obsidian vault
- Project docs in `/docs/`

**Benefits:**
- Survives crashes (reads from disk)
- Pulls only relevant context
- 60-97% token savings
- No context overflow

## Current Project Context (Auto-Loaded)

### 4-Product Suite: i_am_Hicks
**Parent Brand:** "Define yourself"

| Product | Brand | Price | Location |
|---------|-------|-------|----------|
| Trading Journal | EDGE — i am Trading | $49 | `/TradingJournal/` |
| TaskMaster | FLOW — i am Focus | $29 | `/TaskMaster/` |
| Finance Tracker | VAULT — i am Wealth | $29 | `/FinanceTracker/` |
| Knowledge Base | MIND — i am Clear | $29 | `/KnowledgeBase/` |
| **Bundle** | **i_am Complete** | **$99** | — |

### Deployed
- `iamhicks.com` — Main landing page (EDGE/FLOW/VAULT/MIND marketing)
- `iamhicks.com/mind-demo/` — MIND auto-resetting demo

### TBD
- Deploy EDGE, FLOW, VAULT demos
- Tauri desktop versions
- Gumroad launch

## Key Lessons & Decisions

### February 2026
- **MIND app architecture:** Modular files (HTML/CSS/JS) prevent single-point-of-failure issues
- **GitHub Pages deployment:** Use cache-busting (`?v=2`) for static assets to avoid stale files
- **WebLLM vs Ollama:** Skip WebLLM (storage limits); use Ollama for AI features
- **Backup strategy:** Multiple backup locations (local + GitHub) prevent data loss

### Product Suite Status
| Product | Status | Priority |
|---------|--------|----------|
| MIND | ✅ Working, needs Ollama | Medium |
| EDGE | 🚫 Not started | High |
| FLOW | 🚫 Not started | High |
| VAULT | 🚫 Not started | High |
