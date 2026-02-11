# Memory System Index

## Obsidian Folder Structure

```
Kai Memory/
├── MEMORY.md              ← Curated long-term memory
├── SOUL.md               ← Identity & principles
├── AGENTS.md             ← Session protocols
├── USER.md               ← User context
├── IDENTITY.md           ← My identity details
├── TOOLS.md              ← Tool configurations
│
├── Daily Sessions/        ← Raw daily session logs
│   ├── 03-02-2026.md
│   ├── 04-02-2026.md
│   └── ...
│
├── Reference/            ← Templates & guides
│   ├── README.md         ← This file
│   ├── TEMPLATE.md       ← Session summary template
│   ├── LESSONS.md        ← Mistakes & learnings
│   └── SYSTEM.md         ← Technical setup notes
│
└── Archive/              ← Old daily files (3+ months)
    └── (moved quarterly)
```

## File Purposes

| Location | File | Purpose |
|----------|------|---------|
| Root | `MEMORY.md` | Curated long-term memory |
| Root | `SOUL.md` | Identity & core principles |
| Root | `AGENTS.md` | Session start/end protocols |
| Root | `USER.md` | Pete's context & preferences |
| Daily Sessions | `DD-MM-YYYY.md` | Raw daily session logs |
| Reference | `TEMPLATE.md` | Session summary template |
| Reference | `LESSONS.md` | Mistakes & how to avoid them |
| Reference | `SYSTEM.md` | Technical setup notes |
| Reference | `README.md` | This system guide |

## Quick Reference

### Start of Session
1. Read `SOUL.md` — identity check
2. Read `USER.md` — user context
3. Read `Daily Sessions/DD-MM-YYYY.md` — today's + yesterday's notes
4. Read `MEMORY.md` — key decisions/status
5. Read `Reference/LESSONS.md` — what went wrong before
6. Use `memory_search` for specific topics

### End of Session
1. Copy `Reference/TEMPLATE.md` to `Daily Sessions/DD-MM-YYYY.md`
2. Fill in: accomplishments, decisions, current state, next steps, lessons
3. Update `MEMORY.md` with curated key points
4. Run `./sync-to-obsidian.sh` to sync all changes

### Tagging Convention

Use inline tags for cross-referencing:
- `#trading` — Trading-related decisions
- `#iamhicks` — Product suite work
- `#family` — Personal/family context
- `#lesson` — Things to remember
- `#decision` — Key decisions made
- `#bug` — Bugs encountered & fixes
- `#feature` — New features built