# Unified App Architecture (MIND + FLOW)

**Status:** Future / Planning Phase  
**Trigger:** Strong demand from MIND + FLOW users  
**Target Price:** $49 (bundle)

---

## Problem Statement

Current apps are siloed:
- **MIND:** Notes + AI chat (isolated per note)
- **FLOW:** Tasks + System + Chat (unified but separate from MIND)
- **Telegram/Discord/etc.:** Conversations lost in chat history

User has to remember where information lives.

---

## Solution: Unified Knowledge Graph

All conversations, notes, and tasks feed into a single searchable, context-aware knowledge graph.

### User Experience

**Scenario 1: Cross-Reference**
```
User in Telegram: "Working on the MIND license bug"

→ FLOW: Auto-creates task "Fix MIND license bug"
→ MIND: Links to "License System" note
→ Unified Search: "license bug" finds:
    - Telegram conversation
    - FLOW task
    - MIND note with related code
```

**Scenario 2: Context-Aware AI**
```
User in FLOW Chat: "What did we decide about pricing?"

→ Kai searches:
    - Telegram messages (yesterday)
    - MIND note "Business Model"
    - FLOW task "Pricing Strategy"
→ Unified answer with sources
```

**Scenario 3: Proactive Linking**
```
Kai: "You mentioned 'pricing' in Telegram — want me to 
       add that to the 'Business Model' note in MIND?"

Kai: "This task in FLOW relates to yesterday's chat about 
       API design — link them?"
```

---

## Architecture Options

### Option A: Central Brain (Kai Core)

```
┌──────────────────────────────────────────┐
│           KAI CORE (Local AI)            │
│  ┌─────────────┐    ┌─────────────────┐  │
│  │  Memory     │    │  Context Engine │  │
│  │  Store      │←──→│  (RAG + Graph)  │  │
│  │  (SQLite)   │    │                 │  │
│  └─────────────┘    └─────────────────┘  │
└──────────────────────────────────────────┘
        ↑                    ↑              ↑
   ┌────┴────┐          ┌────┴────┐   ┌────┴────┐
   │  MIND   │          │  FLOW   │   │ Telegram│
   │  App    │          │  App    │   │  (etc)  │
   └─────────┘          └─────────┘   └─────────┘
```

**Pros:**
- One source of truth
- Any new app just plugs in
- Local LLM for privacy (no API costs)
- Semantic search across everything

**Cons:**
- Complex to build
- SQLite dependency
- Higher resource usage

---

### Option B: Shared Storage Bridge

Simple file-based approach:

```
~/Documents/Kai/Knowledge/
├── conversations/          # All chats, tagged
│   ├── 2026-02-13/
│   │   ├── telegram_001.json
│   │   ├── flow_001.json
│   │   └── mind_001.json
│   └── index.json          # Searchable metadata
├── tasks/                  # FLOW kanban data
│   └── flow_tasks.json
├── notes/                  # MIND notes
│   └── mind_notes/
├── decisions/              # Key choices made
│   └── decisions.json
└── graph.json              # Relationships between items
```

**Message Format:**
```json
{
  "id": "msg_001",
  "channel": "telegram",
  "channelName": "Telegram DM",
  "sender": "Pete",
  "senderType": "human",
  "text": "Working on the license bug",
  "timestamp": "2026-02-13T09:30:00Z",
  "tags": ["mind", "license", "bug"],
  "links": {
    "notes": ["note_license_system"],
    "tasks": ["task_fix_license"]
  }
}
```

**Pros:**
- Simple, file-based
- Human-readable
- Easy to backup/version
- Low resource usage

**Cons:**
- Slower search (file traversal)
- No advanced queries
- Manual relationship mapping

---

### Option C: Hybrid (Recommended)

Best of both worlds:

```
┌─────────────────────────────────────────┐
│          KNOWLEDGE BRIDGE               │
│  (Lightweight sync layer)               │
├─────────────────────────────────────────┤
│  File Storage (JSON)  │  SQLite Index   │
│  - Conversations      │  - Full-text    │
│  - Notes              │    search       │
│  - Tasks              │  - Relationships│
│  - Raw content        │  - Metadata     │
└─────────────────────────────────────────┘
                    ↓
        ┌───────────┴───────────┐
        │    Context Engine     │
        │  (Local LLM optional) │
        └───────────────────────┘
```

**How it works:**
1. All apps write to JSON files (human-readable)
2. Background process indexes to SQLite
3. Context engine queries SQLite
4. Optional: Local LLM for semantic understanding

---

## Implementation Phases

### Phase 1: Shared Storage (MVP)
**Duration:** 2-3 weeks

- Create `~/Documents/Kai/Knowledge/` structure
- Modify FLOW to write conversations there
- Modify MIND to read/show related conversations
- Add "Save to MIND Note" button in FLOW Chat

**Deliverable:** Basic cross-app linking

---

### Phase 2: Context-Aware AI
**Duration:** 3-4 weeks

- Build SQLite index of all content
- Add search API
- Modify AI to query across sources
- Show "Related Items" in both apps

**Deliverable:** AI knows context from any app

---

### Phase 3: Proactive Linking
**Duration:** 2-3 weeks

- Auto-detect topics/entities in messages
- Suggest links between items
- Build knowledge graph visualization
- Relationship inference

**Deliverable:** Self-organizing knowledge base

---

### Phase 4: Unified Interface (Optional)
**Duration:** 4-6 weeks

- Single app combining MIND + FLOW
- Seamless note ↔ task ↔ chat flow
- Unified search across everything
- Custom dashboards

**Deliverable:** True unified product

---

## Technical Considerations

### Data Privacy
- Everything stays local (no cloud)
- User owns all data
- Easy export (JSON files)

### Performance
- Indexing happens in background
- Lazy loading for large datasets
- Optional: Compress old conversations

### Backwards Compatibility
- MIND can still run standalone
- FLOW can still run standalone
- Unified layer is additive, not required

### Migration Path
```
User has MIND + FLOW separately
                ↓
Install "Knowledge Bridge" add-on
                ↓
Apps start syncing to shared storage
                ↓
User gets unified search/context
                ↓
(Optional) Upgrade to unified app
```

---

## User Journeys

### Journey 1: Research Project
1. **MIND:** Create note "Project X Research"
2. **Telegram:** Chat with Kai about findings
3. **FLOW:** Create task "Compile research"
4. **Unified Search:** "Project X" finds all three
5. **MIND:** Note shows linked chat + task

### Journey 2: Bug Fix
1. **Telegram:** "Found bug in license system"
2. **FLOW:** Auto-creates task, links to chat
3. **MIND:** User adds technical details to note
4. **FLOW:** Task shows note + chat context
5. **Done:** Complete task, archive conversation

### Journey 3: Decision Tracking
1. **FLOW:** Discuss options with Kai
2. **MIND:** Create decision log entry
3. **Unified:** "Why did we choose X?" → Shows reasoning

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Cross-app searches/day | > 10 per user |
| Linked items per conversation | > 1 |
| User retention (unified vs separate) | +20% |
| Time to find information | -50% |

---

## Open Questions

1. **Local LLM?** Use Ollama for semantic search or stick to SQLite?
2. **Conflict resolution?** How handle simultaneous edits?
3. **Mobile?** How sync to mobile devices?
4. **Teams?** Multi-user support or stay personal?

---

## Decision Log

| Date | Decision | Reason |
|------|----------|--------|
| 13-02-2026 | Start with 3 separate products | Flexibility, learning |
| 13-02-2026 | Build unified only if demand | Avoid over-engineering |
| — | — | — |

---

*Document status: Planning*  
*Next action: Wait for MIND + FLOW launch feedback*
