# i_am_Hicks Product Strategy

**Date:** 13-02-2026  
**Status:** Active Development  
**Owner:** Pete + Kai

---

## 3-Product Strategy

### Overview
Three distinct products targeting different user segments while maintaining flexibility to merge or evolve based on market feedback.

```
┌─────────────┬─────────────┬─────────────────────────────┐
│   MIND      │    FLOW     │    MIND+FLOW (Unified)      │
│  ($29)      │  ($29)      │    ($49)                    │
├─────────────┼─────────────┼─────────────────────────────┤
│ Solo        │ Power       │ Pro Users /                 │
│ knowledge   │ users /     │ Teams                       │
│ workers     │ OpenClaw    │                             │
├─────────────┼─────────────┼─────────────────────────────┤
│ • Notes     │ • Mission   │ • Unified                   │
│ • AI Chat   │   Control   │   Knowledge Graph           │
│ • Offline   │ • Real-time │ • Seamless                  │
│   First     │   Sync      │   Note↔Task↔Chat            │
│ • Simple    │ • OpenClaw  │ • Complete                  │
│   Single    │   Integration│  Ecosystem                 │
│   File      │ • Task      │                             │
│             │   Management│                             │
└─────────────┴─────────────┴─────────────────────────────┘
```

---

## Product 1: MIND (Current)

### Target User
- Solo knowledge workers
- Writers, researchers, students
- People who want simple, offline-first note-taking
- Users intimidated by complex setups

### Value Proposition
"Offline-first notes with AI chat. No cloud, no subscriptions, no complexity."

### Technical Approach
- Single-file architecture (`index.html`)
- localStorage persistence
- Per-note AI chat history
- Electron wrapper for desktop
- Zero dependencies

### Current Status
- ✅ Core features complete
- ✅ AI Chat working with history
- ✅ Pinned/Favorites with sorting
- ✅ Folder management
- 🔄 Final bug fixes needed
- 🔄 Website content updates

### Launch Readiness
| Item | Status |
|------|--------|
| Core functionality | ✅ Complete |
| Bug fixes | 🔄 In progress |
| Website copy | 🔄 Pending |
| Payment/Gumroad | ⏳ Setup needed |
| Demo video | ⏳ Optional |

---

## Product 2: FLOW v2 (In Development)

### Target User
- OpenClaw community
- Power users, automation nerds
- Developers, AI enthusiasts
- People who want "mission control" for their digital life

### Value Proposition
"Human-AI task collaboration. Your entire workflow in one dashboard."

### Technical Approach
- Node.js server (`server.js`)
- JSON file-based data storage
- Real-time sync across modules
- OpenClaw gateway integration
- Modular architecture

### Modules
1. **Kanban** — Drag-drop task management
2. **Activity** — Real-time AI action log
3. **Memory** — Shared context between human & AI
4. **Deliverables** — File/asset management
5. **Chat** — Unified messaging (Telegram, WebChat, etc.)
6. **Kai Profile** — Edit SOUL.md, IDENTITY.md, etc.
7. **Skills Browser** — View 50+ installed skills
8. **System Dashboard** — Gateway status, cron jobs
9. **Schedule & Heartbeat** — Daily rhythm, health checks

### Current Status
- ✅ All 9 modules built
- ✅ Real-time chat sync working
- ✅ Server API complete
- 🔄 Module interconnection needed
- 🔄 UI polish

### Next Steps
1. Ensure all modules can communicate
2. UI consistency pass
3. Test with OpenClaw community
4. Gather feedback

---

## Product 3: MIND+FLOW (Unified) — Future

### Target User
- Pro users / consultants
- Small teams
- People who want "everything in one place"
- Power users who outgrow individual apps

### Value Proposition
"Complete knowledge + task ecosystem. Everything connected."

### Technical Approach
**Option A: Central Brain (Kai Core)**
```
┌──────────────────────────────────────────┐
│           KAI CORE (Local AI)            │
│  ┌─────────────┐    ┌─────────────────┐ │
│  │  Memory     │    │  Context Engine │ │
│  │  Store      │←──→│  (RAG + Graph)  │ │
│  │  (SQLite)   │    │                 │ │
│  └─────────────┘    └─────────────────┘ │
└──────────────────────────────────────────┘
        ↑                    ↑              ↑
   ┌────┴────┐          ┌────┴────┐   ┌────┴────┐
   │  MIND   │          │  FLOW   │   │ Telegram│
   │  App    │          │  App    │   │  (etc)  │
   └─────────┘          └─────────┘   └─────────┘
```

**Option B: Shared Storage Bridge**
```
Knowledge/
├── conversations/     # All chats, tagged
├── tasks/            # FLOW kanban data
├── notes/            # MIND notes
├── decisions/        # Key choices
└── index.json        # Searchable graph
```

### Key Features
- Universal message bus (all channels feed into knowledge graph)
- Smart linking (auto-detect relationships between notes, tasks, chats)
- Cross-app search (find anything from anywhere)
- Context-aware AI (I know what you're working on regardless of app)

### Trigger for Development
- Strong demand for MIND+FLOW integration
- Users asking for "more connections"
- Revenue from MIND + FLOW justifies investment

---

## Go-to-Market Timeline

| Phase | Timeline | Action |
|-------|----------|--------|
| **1** | Now | MIND: Final bug fixes |
| **2** | +1 week | MIND: Website content, Gumroad setup |
| **3** | +2 weeks | MIND: Launch ($29) |
| **4** | +3 weeks | FLOW: UI polish, module interconnection |
| **5** | +5 weeks | FLOW: Test with OpenClaw community |
| **6** | +6 weeks | FLOW: Launch ($29) |
| **7** | +2 months | Evaluate: Build MIND+FLOW? ($49) |

---

## Bundle Pricing

| Combo | Price | Savings |
|-------|-------|---------|
| MIND only | $29 | — |
| FLOW only | $29 | — |
| MIND+FLOW | $49 | Save $9 |
| All three | $69 | Save $17 |

---

## Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| Maintenance burden | Keep MIND frozen post-launch (security only) |
| Code duplication | Share CSS/themes, keep logic separate |
| User confusion | Clear positioning on website |
| Scope creep | Launch MIND first, then FLOW, then evaluate unified |

---

## Unified App Architecture (Future Reference)

### Core Concept
Break down silos between apps — unified context across entire ecosystem.

### Current State (Silos)
```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   MIND      │      │    FLOW     │      │  Telegram   │
│  (Notes)    │      │  (Tasks)    │      │  (Chat)     │
│   Isolated  │      │   Isolated  │      │   Isolated  │
│   Context   │      │   Context   │      │   Context   │
└─────────────┘      └─────────────┘      └─────────────┘
```

### Target State (Unified)
```
┌─────────────────────────────────────────────────────────┐
│              UNIFIED KNOWLEDGE GRAPH                     │
├─────────────┬─────────────┬─────────────────────────────┤
│   MIND      │    FLOW     │    All Channels             │
│  (Notes)    │  (Tasks)    │    (Telegram, etc.)         │
│             │             │                             │
│ • Note A    │ • Kanban    │ • Messages tagged by topic  │
│   ├ Chat 1 ←┼→ linked to │   ├ Auto-linked to notes    │
│ • Note B    │   Task #42  │   ├ Auto-linked to tasks    │
│   ├ Chat 2 ←┼→ linked to │                             │
│             │   Project X │                             │
└─────────────┴─────────────┴─────────────────────────────┘
```

### Implementation Phases

**Phase 1: Shared Storage**
Both apps read/write to `~/Documents/Kai/Knowledge/`
- FLOW writes conversations to `Knowledge/conversations/`
- MIND reads them — shows "Related Conversations" in each note
- Tag messages with note IDs when relevant

**Phase 2: Context-Aware AI**
When user messages from anywhere:
1. Check: What's the current active note in MIND?
2. Check: What's the active task in FLOW?
3. Check: Recent conversation context
4. Respond with full context

**Phase 3: Proactive Linking**
- "You mentioned 'pricing' in Telegram — want me to add that to the 'Business Model' note in MIND?"
- "This task in FLOW relates to yesterday's chat about API design — link them?"

---

## Notes

- MIND stays simple (single-file, offline-first)
- FLOW becomes power-user tool (server-based, integrated)
- Unified version only if demand justifies development
- Each product must stand alone (no forced upgrades)

---

*Last updated: 13-02-2026 by Kai*  
*Next review: After MIND launch*
