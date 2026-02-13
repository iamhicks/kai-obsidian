# FLOW Dashboard v2 — Mission Control

**Status:** Concept / Planning  
**Date:** 2026-02-12  
**Idea:** Expand FLOW from kanban into full human-AI collaboration dashboard

---

## Overview

A comprehensive "Mission Control" dashboard that bridges human and AI workflows. Not just task management — a shared workspace where humans and AI agents collaborate transparently.

**Core Philosophy:**
- Human sees: Visual overview, progress, what's pending
- AI sees: Structured data to update, clear priorities  
- Both see: Shared context, history, next steps

---

## Core Modules

### 1. 📋 Kanban (Existing)
- Tasks, columns, drag-drop
- AI can move cards, add tasks
- Multiple boards per project
- Tags, priorities, due dates

**Status:** ✅ Working

---

### 2. 📊 Activity Stream
**Purpose:** "While you were away..." summary

**Features:**
- What did Kai work on?
- Files changed, commits made
- Tasks completed, moved
- Tokens used, time spent
- Recent decisions made

**Data Structure:**
```json
{
  "activities": [
    {
      "id": "act_1",
      "type": "task_moved",
      "description": "Moved 'Fix MIND license' to In Progress",
      "agent": "Kai",
      "timestamp": "2026-02-12T22:58:00Z",
      "boardId": "board_1"
    }
  ]
}
```

---

### 3. 🧠 Shared Memory
**Purpose:** Quick notes between human and AI

**Features:**
- "Remember this for next time"
- Context that doesn't fit in tasks
- Scratchpad for ideas
- Decisions log
- Preferences learned

**Data Structure:**
```json
{
  "memory": [
    {
      "id": "mem_1",
      "category": "preference",
      "content": "Pete prefers dark mode in all apps",
      "addedBy": "Kai",
      "timestamp": "2026-02-12T22:30:00Z"
    }
  ]
}
```

---

### 4. 📁 Deliverables
**Purpose:** Files AI created, ready for review

**Features:**
- Code, docs, images, exports
- One-click download
- Version history
- Status: draft / review / approved
- Linked to originating task

**Data Structure:**
```json
{
  "deliverables": [
    {
      "id": "del_1",
      "name": "MIND-license-fix.patch",
      "type": "code",
      "path": "./deliverables/del_1.patch",
      "status": "review",
      "linkedTask": "card_2",
      "createdBy": "Kai",
      "timestamp": "2026-02-12T22:45:00Z"
    }
  ]
}
```

---

### 5. 💬 Async Chat
**Purpose:** Leave messages for each other

**Features:**
- "Check the trading model at 3pm"
- "Reviewed the code — see notes"
- Threaded conversations per topic
- @mentions support
- Link to tasks/deliverables

**Data Structure:**
```json
{
  "messages": [
    {
      "id": "msg_1",
      "from": "Kai",
      "to": "Pete",
      "content": "Moved the license fix to Done. Ready for testing!",
      "threadId": "thread_1",
      "linkedTask": "card_2",
      "timestamp": "2026-02-12T22:58:00Z",
      "read": false
    }
  ]
}
```

---

### 6. ⏰ Schedule & Heartbeats
**Purpose:** When will agent check in next?

**Features:**
- Visual cron schedule
- Next heartbeat countdown
- Upcoming reminders
- Recurring task schedule
- "Agent will wake in 2 hours"

**Data Structure:**
```json
{
  "schedule": {
    "heartbeats": [
      {
        "name": "Morning Check",
        "cron": "0 7 * * *",
        "nextRun": "2026-02-13T07:00:00Z"
      }
    ],
    "reminders": [
      {
        "id": "rem_1",
        "text": "Review trading model",
        "time": "2026-02-13T15:00:00Z"
      }
    ]
  }
}
```

---

### 7. 📈 Metrics & Insights
**Purpose:** Track productivity and value

**Features:**
- Tasks completed this week/month
- Time saved vs manual work (estimate)
- Token usage tracking
- Goal progress bars
- Velocity charts
- AI vs Human task ratio

**Data Structure:**
```json
{
  "metrics": {
    "period": "2026-02-01 to 2026-02-12",
    "tasksCompleted": 24,
    "tasksByAgent": 18,
    "tasksByHuman": 6,
    "tokensUsed": 45000,
    "estimatedHoursSaved": 8.5,
    "goals": [
      {
        "name": "Launch MIND",
        "progress": 75,
        "target": 100
      }
    ]
  }
}
```

---

### 8. 🎯 Current Focus
**Purpose:** What's the #1 priority right now?

**Features:**
- Active projects summary
- Top 3 priorities
- Blockers that need attention
- "What should I work on next?"
- Daily/weekly focus mode

**Data Structure:**
```json
{
  "currentFocus": {
    "daily": [
      "Fix MIND license system",
      "Test FLOW sync button",
      "Review product landing page"
    ],
    "blockers": [
      "Waiting on Gumroad product ID"
    ],
    "mode": "product-development"
  }
}
```

---

## File Structure

```
flow-dashboard/
├── app/
│   ├── index.html              # Main dashboard UI
│   ├── kanban/                 # Existing kanban module
│   ├── activity/               # Activity stream module
│   ├── memory/                 # Shared memory module
│   ├── deliverables/           # Files & assets module
│   ├── chat/                   # Messaging module
│   ├── schedule/               # Heartbeats & reminders
│   └── metrics/                # Analytics module
├── data/
│   ├── kanban.json
│   ├── activity.json
│   ├── memory.json
│   ├── chat.json
│   ├── schedule.json
│   ├── metrics.json
│   └── deliverables/           # Folder for files
├── server.js                   # Node.js backend
└── product.html                # Landing page
```

---

## Technical Architecture

**Current:** Node.js server + HTML/JS frontend
**Data:** JSON files (human-readable, AI-editable)
**Sync:** REST API + file watchers
**Real-time:** Optional WebSocket upgrade

**Electron Option:**
- ✅ Native file system access (no server needed)
- ✅ System tray icon for quick access
- ✅ Native notifications
- ✅ Auto-start on boot
- ❌ Extra complexity
- ❌ Build process required

**Recommendation:** Start with web (current), Electron wrapper later as paid upgrade ($49?)

---

## UI Layout Ideas

```
┌─────────────────────────────────────────────────────────────┐
│  🌊 FLOW Dashboard              [Kanban] [Activity] [Chat]  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────┐  ┌───────────────────────────────┐ │
│  │  📋 KANBAN          │  │  📊 ACTIVITY STREAM           │ │
│  │  ┌───┐ ┌───┐ ┌───┐ │  │  • Kai moved "Fix MIND"       │ │
│  │  │To │ │In │ │Do │ │  │  • Backup created             │ │
│  │  │Do │ │Pro│ │ne │ │  │  • New task added             │ │
│  │  └───┘ └───┘ └───┘ │  │                               │ │
│  └─────────────────────┘  └───────────────────────────────┘ │
│  ┌─────────────────────┐  ┌───────────────────────────────┐ │
│  │  🧠 SHARED MEMORY   │  │  💬 CHAT                      │ │
│  │  Pete prefers...    │  │  Kai: Moved to Done!          │ │
│  │  Remember to...     │  │  Pete: Thanks, checking...    │ │
│  └─────────────────────┘  └───────────────────────────────┘ │
│  ┌─────────────────────┐  ┌───────────────────────────────┐ │
│  │  📁 DELIVERABLES    │  │  📈 METRICS                   │ │
│  │  [patch-1.diff]     │  │  24 tasks this week           │ │
│  │  [logo-final.png]   │  │  8.5 hours saved              │ │
│  └─────────────────────┘  └───────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

---

## Next Steps

1. **MVP:** Get kanban fully stable (done)
2. **v1.1:** Add Activity Stream (easy win)
3. **v1.2:** Add Shared Memory
4. **v1.3:** Add Deliverables
5. **v2.0:** Full dashboard with all modules
6. **Electron:** Wrap as native app

---

## Product Positioning

**Name Ideas:**
- FLOW Dashboard
- Kai Mission Control
- OpenClaw Workspace
- AgentOS

**Pricing:**
- Core (Kanban): $29
- Pro (Full Dashboard): $49
- Enterprise (Electron + Cloud): $99

**Target:** OpenClaw users, AI enthusiasts, productivity nerds

---

*Document created by Kai for Pete / i_am_Hicks*
