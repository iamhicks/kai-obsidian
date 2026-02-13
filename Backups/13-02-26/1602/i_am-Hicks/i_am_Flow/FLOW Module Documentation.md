# FLOW Dashboard v2 — Module Documentation

**Version:** 2.0  
**Last Updated:** 13-02-2026  
**Status:** Active Development

---

## Overview

FLOW is a Human-AI Mission Control Dashboard that unifies task management, real-time chat, system monitoring, and memory into a single interface. It serves as the command center for OpenClaw power users.

**Core Philosophy:**
- Everything in one place
- Real-time sync across modules
- No demo data — real system integration
- Cross-module intelligence

---

## Module Directory

| Module | Purpose | Data Source | Real-Time |
|--------|---------|-------------|-----------|
| **Kanban** | Task management | `flow-data.json` | ✅ Auto-save |
| **Activity** | System event log | `data/activity.json` | ✅ 3s polling |
| **Memory** | Curated knowledge | `data/memory.json` | ✅ 5s polling |
| **Deliverables** | File/asset tracking | `data/deliverables.json` | Manual |
| **Chat** | Unified messaging | OpenClaw sessions | ✅ 3s sync |
| **Kai Profile** | Identity editor | `~/.openclaw/workspace/*.md` | Save on edit |
| **Skills Browser** | Skill catalog | `/usr/local/lib/node_modules/openclaw/skills/` | Static |
| **System Dashboard** | Gateway monitoring | OpenClaw config + API | On tab open |
| **Schedule & Heartbeat** | Rhythm & health | Config + cron | On tab open |

---

## Kanban Module

### Purpose
Drag-and-drop task management with multiple boards and customizable columns.

### Features
- **Multiple Boards:** Create unlimited project boards
- **Custom Columns:** Backlog, To Do, In Progress, Done, Archive (default)
- **Card Details:** Title, description, labels, assignees, due dates
- **Templates:** Pre-built templates ("Kai Modules", "General", "House Keeping")
- **Archive:** Move completed cards to archive instead of deleting

### Data Flow
```
User drags card → Auto-save → flow-data.json
                        ↓
                EventBus emits 'kanban:taskMoved'
                        ↓
                Activity Stream logs the move
```

### File Locations
- Data: `~/Documents/Kai/Repos/flow/flow-data.json`
- UI: `app/kanban.html` (embedded in dashboard via iframe)

### Cross-Module Integration
| Trigger | Target | Action |
|---------|--------|--------|
| Card created | Activity | Logs "Task created" |
| Card moved | Activity | Logs "Task moved to [column]" |
| Card completed | Memory | *Future: Auto-extract as milestone* |

---

## Activity Stream Module

### Purpose
Real-time log of all significant events across the system. "What just happened?"

### Event Sources
- **Chat messages** — Every message sent (all channels)
- **Kanban actions** — Task created, moved, completed
- **Kai file edits** — SOUL.md, IDENTITY.md, etc.
- **System events** — Backups, cron jobs, gateway status

### Auto-Generated Events
| Event Type | Icon | Trigger |
|------------|------|---------|
| `chat` | 💬 | New message in any channel |
| `task` | ✅ | Kanban card created |
| `task` | 📋 | Kanban card moved |
| `system` | 🌊 | Kai identity file edited |
| `milestone` | 🏆 | Manual or auto-detected |

### Data Flow
```
Event happens → EventBus.emit() → data/activity.json
                                          ↓
                              Activity tab polls every 3s
                                          ↓
                              Renders updated stream
```

### File Locations
- Data: `~/Documents/Kai/Repos/flow/data/activity.json`
- Max entries: 50 (oldest auto-pruned)

---

## Memory Module

### Purpose
Curated knowledge base extracted from daily activities and file edits. "What should we remember?"

### Auto-Extraction Sources
1. **Daily Logs** (`memory/DD-MM-YYYY.md`)
   - Parses "Key Accomplishments" → Milestones
   - Parses "Technical Decisions" → Product ideas
   - Runs every hour + on server start

2. **Kai File Edits** (Kai Profile module)
   - SOUL.md → Identity category
   - IDENTITY.md → Identity category
   - USER.md → Preference category
   - Trading files → Trading category
   - Business/strategy → Business category

3. **Future:** Tagged messages (`#memory`)

### Categories
| Category | Color | Source |
|----------|-------|--------|
| `milestone` | Red | Accomplishments |
| `product` | Purple | Technical decisions |
| `identity` | Purple | SOUL/IDENTITY edits |
| `preference` | Blue | USER.md edits |
| `trading` | Yellow | Trading files |
| `business` | Green | Strategy docs |
| `system` | Grey | Other files |

### Data Flow
```
Daily log written → parseDailyLogsForMemories() → data/memory.json
                                                         ↓
Kai file edited → extractMemoryFromFileEdit() → data/memory.json
                                                         ↓
                              Memory tab polls every 5s → UI update
```

### File Locations
- Data: `~/Documents/Kai/Repos/flow/data/memory.json`
- Max entries: 50 (oldest auto-pruned)
- Deduplication: Same file edit within 1 hour = skip

### API Endpoints
- `GET /api/memory` — Load all memories
- `POST /api/memory/refresh` — Force re-parse daily logs

---

## Deliverables Module

### Purpose
Track files, assets, and outputs created during work sessions.

### Current State
**Demo data only** — Not yet connected to real file system.

### Planned Features
- Auto-detect new files in `~/Documents/Kai/` subfolders
- Track exports from MIND/FLOW
- Version history for important files
- Status: Draft → Review → Ready → Delivered

### Categories
- `design` — UI/UX files, mockups
- `code` — Source code, scripts
- `doc` — Documentation, specs
- `asset` — Images, icons, media

---

## Unified Chat Module

### Purpose
Single view of all conversations across channels. Read-only aggregation.

### Supported Channels
- Telegram (DMs and groups)
- WebChat (browser sessions)
- Future: WhatsApp, Discord, Slack, iMessage

### How It Works
1. **Polling:** Every 3 seconds, reads OpenClaw session logs
2. **Parsing:** Extracts messages from `.jsonl` session files
3. **Deduplication:** Skips already-synced messages
4. **Display:** Shows in unified timeline with channel tags

### Important Limitations
- **Read-only:** Cannot send messages FROM FLOW
- **Telegram → FLOW:** ✅ Messages appear
- **FLOW → Telegram:** ❌ Not possible (by design)
- **Filter dropdown:** Choose which channels to display

### Data Flow
```
Telegram message → OpenClaw gateway → Session .jsonl file
                                              ↓
                              FLOW polls /api/messages
                                              ↓
                              Parses → data/messages.json
                                              ↓
                              UI renders with channel tags
```

### File Locations
- Synced data: `~/Documents/Kai/Repos/flow/data/messages.json`
- Source: `~/.openclaw/agents/main/sessions/*.jsonl`

---

## Kai Profile Module

### Purpose
Visual editor for Kai's identity and configuration files.

### Editable Files
| File | Purpose | Category |
|------|---------|----------|
| `SOUL.md` | Personality, rules, vibe | Identity |
| `IDENTITY.md` | Name, emoji, avatar | Identity |
| `USER.md` | Pete's profile, preferences | Preference |
| `AGENTS.md` | Operational rules | System |
| `MEMORY.md` | Curated long-term memory | Milestone |
| `STANDING_ORDERS.md` | Non-negotiable rules | System |
| `TOOLS.md` | Environment notes | System |
| `HEARTBEAT.md` | System checks | System |
| `DEV_PROCEDURE.md` | Development checklist | System |
| `trading_*.md` | Trading strategy | Trading |

### Features
- Syntax-highlighted markdown editor
- Save confirmation modal
- Auto-extracts memory on save (see Memory module)
- File tree sidebar for navigation

### Data Flow
```
User edits file → Save button → POST /api/workspace/{file}
                                          ↓
                              Writes to ~/.openclaw/workspace/
                                          ↓
                              EventBus emits 'kai:fileEdited'
                                          ↓
                              Activity logs it
                                          ↓
                              Memory extracts it
```

---

## Skills Browser Module

### Purpose
Browse and view installed OpenClaw skills.

### Current State
**Static catalog** — Reads skill metadata from filesystem.

### Features
- Grid view of all 50+ installed skills
- Search by name
- Category tags
- View SKILL.md content

### Data Source
```
/usr/local/lib/node_modules/openclaw/skills/
├── github/SKILL.md
├── weather/SKILL.md
├── mind/SKILL.md
└── ... (50+ skills)
```

### Categories
- Development (github, mind, obsidian)
- Media (video-frames)
- System (healthcheck)
- External (weather)

### Future Features
- Filter by category
- One-click install from clawhub.com
- Skill usage statistics

---

## System Dashboard Module

### Purpose
Monitor OpenClaw gateway health, channels, cron jobs, and sessions.

### Real Data Components

#### Cron Jobs
- **Source:** `openclaw cron list` command
- **Data:** ID, name, schedule, next run, last run, status
- **Refresh:** On tab open (manual refresh button planned)

#### Channels
- **Source:** `~/.openclaw/openclaw.json`
- **Data:** Name, enabled status, connection status
- **Channels:** Telegram, WebChat

#### Sessions
- **Current:** Static demo data
- **Future:** Real session list from OpenClaw API

#### Config Preview
- **Current:** Static JSON preview
- **Future:** Live `openclaw.json` view

### Layout
```
┌─────────────────┬─────────────────┐
│   Channels      │   Sessions      │
├─────────────────┴─────────────────┤
│           Cron Jobs               │
├─────────────────┴─────────────────┤
│         Config Preview            │
└───────────────────────────────────┘
```

### API Endpoints
- `GET /api/crons` — Real cron jobs
- `GET /api/channels` — Channel status from config
- `GET /api/sessions` — *Future: Real sessions*

---

## Schedule & Heartbeat Module

### Purpose
Track daily rhythm, upcoming tasks, and system health.

### Components

#### Daily Rhythm
- Session start protocol checklist
- Session end protocol checklist
- Visual completion status

#### Upcoming Checks
- Next cron job runs
- Manual refresh shows real data from `/api/crons`

#### Heartbeat Status
- Backup system health
- GitHub monitor status
- Memory sync status
- Gateway health

#### Weekly Review
- Next review date (Sunday evening)
- Task checklist:
  - Project health check
  - Pattern analysis
  - Memory curation

#### Active Hours
- 07:00-23:00: Active monitoring
- 23:00-07:00: Quiet mode (alerts only)

### Layout
```
┌─────────────────┬─────────────────┐
│  Daily Rhythm   │  Upcoming       │
│                 │  Checks         │
├─────────────────┼─────────────────┤
│  Weekly Review  │  Active Hours   │
├─────────────────┴─────────────────┤
│        Heartbeat Status           │
└───────────────────────────────────┘
```

---

## Cross-Module Event Bus

### Purpose
Enable communication between all modules without tight coupling.

### Event Types
| Event | Emitter | Listeners | Data |
|-------|---------|-----------|------|
| `chat:message` | Chat API | Activity | Message object |
| `kanban:taskCreated` | Kanban save | Activity | Task details |
| `kanban:taskMoved` | Kanban save | Activity | Move details |
| `kai:fileEdited` | Profile save | Activity, Memory | Filename |

### Event Log
All events persisted to `data/events.json` (last 100 events).

### API
- `GET /api/events` — View event log
- `POST /api/trigger` — Manually emit event

---

## Data Storage Summary

| File | Purpose | Max Size |
|------|---------|----------|
| `flow-data.json` | Kanban boards & cards | Unlimited |
| `data/activity.json` | Activity stream | 50 entries |
| `data/memory.json` | Curated memories | 50 entries |
| `data/messages.json` | Chat history | Unlimited |
| `data/events.json` | Event bus log | 100 entries |
| `data/deliverables.json` | File tracking | 50 entries |

---

## API Reference

### Kanban
- `GET/POST /api/data` — Board data

### Activity
- `GET /api/activity` — Activity stream

### Memory
- `GET /api/memory` — Memory entries
- `POST /api/memory/refresh` — Force re-parse

### Chat
- `GET /api/messages` — All messages
- `POST /api/messages` — Send message (FLOW only)

### System
- `GET /api/crons` — Real cron jobs
- `GET /api/channels` — Channel status
- `GET /api/events` — Event bus log
- `POST /api/trigger` — Emit event

### Workspace
- `GET /api/workspace/{file}.md` — Load file
- `POST /api/workspace/{file}.md` — Save file

---

## Development Notes

### Adding a New Module
1. Create HTML structure in `dashboard.html`
2. Add CSS styles
3. Add navigation tab
4. Implement `load{Module}()` function
5. Wire up event listeners
6. Document in this file

### Data Persistence Pattern
```javascript
// Load
const response = await fetch('/api/data');
const data = await response.json();

// Modify
data.boards[0].columns[0].cards.push(newCard);

// Save
await fetch('/api/data', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
});
```

### Cross-Module Trigger Pattern
```javascript
// Frontend: Trigger event
await fetch('/api/trigger', {
    method: 'POST',
    body: JSON.stringify({
        event: 'custom:event',
        data: { key: 'value' }
    })
});

// Backend: Handle event
EventBus.on('custom:event', (data) => {
    // Do something
});
```

---

## Troubleshooting

### Chat not syncing
1. Check server running: `curl http://localhost:3456/`
2. Check OpenClaw sessions exist: `ls ~/.openclaw/agents/main/sessions/`
3. Manual sync: Refresh Chat tab

### Activity empty
1. Check `data/activity.json` exists
2. Trigger test event: Send chat message
3. Check browser console for errors

### Memory not updating
1. Force refresh: `POST /api/memory/refresh`
2. Check daily log format matches expected pattern
3. Check server logs for parse errors

### Kanban changes not saving
1. Check `flow-data.json` permissions
2. Verify network tab shows 200 on POST /api/data
3. Check Activity tab for "Task moved" events

---

## Future Roadmap

### Short Term
- [ ] Real session data in System Dashboard
- [ ] Auto-detect deliverables from file system
- [ ] Memory tagging from chat (`#memory`)
- [ ] Mobile responsive pass

### Medium Term
- [ ] Multi-user support (teams)
- [ ] Plugin system for custom modules
- [ ] Advanced search across all modules
- [ ] Export reports (PDF, Markdown)

### Long Term
- [ ] Knowledge graph visualization
- [ ] AI-suggested task priorities
- [ ] Predictive maintenance alerts
- [ ] Integration marketplace

---

*This documentation is auto-generated and should be updated when features change.*
