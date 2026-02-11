# Complete Backup & Sync Architecture

**Last Updated:** 11-02-2026  
**Purpose:** Reference document for how all backups, syncs, and GitHub pushes work

---

## Overview

Three scripts manage the backup ecosystem:

| Script | Location | Purpose | Trigger |
|--------|----------|---------|---------|
| `backup-all.sh` | `~/.openclaw/workspace/` | Manual or on-demand backups | Run manually |
| `auto-push.sh` | `~/.openclaw/workspace/` | Automated hourly backup + GitHub push | Cron job (hourly) |
| `sync-to-obsidian.sh` | `~/.openclaw/workspace/` | Sync workspace memory → Obsidian | Called by auto-push.sh |

---

## Local Folder Structure

### 1. Kai Memory (Local Timestamps)

```
~/Documents/Kai/Kai_Memory/
├── Sessions/
│   └── dd-mm-yy/
│       └── hhmm/              # OpenClaw session transcripts (.jsonl)
└── Workspace/
    └── dd-mm-yy/
        └── hhmm/              # Full workspace backup
            ├── *.md           # AGENTS.md, SOUL.md, USER.md, etc.
            ├── *.sh           # backup-all.sh, auto-push.sh, etc.
            ├── memory/        # Daily notes, LESSONS.md, etc.
            └── skills/        # Skill definitions
```

### 2. Obsidian Vault (Working Notes)

```
~/Documents/Kai/Kai_Obsidian/Kai/
├── Kai Memory/                # ← SYNCED from workspace/memory/
│   ├── DD-MM-YYYY.md         # Daily session notes
│   ├── LESSONS.md
│   ├── SYSTEM.md
│   ├── backup-structure.md   # This file
│   ├── pending-requests.md
│   ├── archive/
│   └── weekly-reviews/
├── Business/
├── Family/
├── Personal/
├── Trading/
├── Tasks/
├── SOUL.md                   # Copied from workspace
├── USER.md                   # Copied from workspace
├── AGENTS.md                 # Copied from workspace
├── MEMORY.md                 # Curated long-term memory
└── Backups/                  # Hourly Obsidian backups
    └── dd-mm-yy/
        └── hhmm/
```

### 3. Product Repositories

```
~/Documents/Kai/Repos/
├── mind/
│   ├── app/                  # Current Electron app code
│   │   └── Backups/
│   │       └── dd-mm-yy/
│   │           └── hhmm/
│   └── demo/                 # Demo version
│       └── Backups/
│           └── dd-mm-yy/
│               └── hhmm/
├── flow/
│   ├── app/
│   └── demo/
├── edge/                     # (when created)
└── website/
    └── Backups/
        └── dd-mm-yy/
            └── hhmm/
```

---

## GitHub Repositories

| Repo | URL | Contents | Push Frequency |
|------|-----|----------|----------------|
| `kai-memory` | github.com/iamhicks/kai-memory | `~/.openclaw/workspace/` — SOUL.md, USER.md, memory/, skills/, *.sh | Hourly (auto-push.sh) |
| `kai-obsidian` | github.com/iamhicks/kai-obsidian | `~/Documents/Kai/Kai_Obsidian/Kai/` — Full vault | Hourly (auto-push.sh) |
| `mind` | github.com/iamhicks/mind | `~/Documents/Kai/Repos/mind/` — Electron app + demo | Manual (during dev) |
| `flow` | github.com/iamhicks/flow | `~/Documents/Kai/Repos/flow/` — Task app | Manual (during dev) |
| `website` | github.com/iamhicks/website | `~/Documents/Kai/Repos/website/` — Marketing site | Manual (during dev) |

---

## Script Details

### 1. `auto-push.sh` (Primary Automation)

**Location:** `~/.openclaw/workspace/auto-push.sh`  
**Schedule:** Every hour (cron)  
**What it does:**

```
Step 1: Backup workspace → Kai_Memory/Workspace/dd-mm-yy/hhmm/
        - Copies all .md, .sh, memory/, skills/

Step 2: Backup sessions → Kai_Memory/Sessions/dd-mm-yy/hhmm/
        - Copies .jsonl session files

Step 3: Backup Obsidian → Kai_Obsidian/Kai/Backups/dd-mm-yy/hhmm/
        - Full vault snapshot (excludes Backups/ folder)

Step 4: Push workspace → GitHub (kai-memory repo)
        - Commits with timestamp: "Auto-sync: DD-MM-YYYY HH:MM"

Step 5: Push Obsidian → GitHub (kai-obsidian repo)
        - Same commit format

Step 6: Backup product repos
        - website/Backups/
        - mind/app/Backups/
        - mind/demo/Backups/
        - flow/app/Backups/
        - flow/demo/Backups/

Step 7: Sync workspace memory → Obsidian
        - Runs sync-to-obsidian.sh
        - Copies workspace/memory/* → Kai_Obsidian/Kai/Kai Memory/
```

### 2. `backup-all.sh` (Manual/On-Demand)

**Location:** `~/.openclaw/workspace/backup-all.sh`  
**When to use:** Before major changes, manual checkpoint  
**What it does:**

```
Step 1: Backup workspace → Kai_Memory/Workspace/dd-mm-yy/hhmm/
Step 2: Prepare sessions directory → Kai_Memory/Sessions/dd-mm-yy/hhmm/
Step 3: Backup MIND app → Repos/mind/dd-mm-yy/hhmm/
Step 4: Backup MIND demo → Repos/mind-demo/dd-mm-yy/hhmm/
```

**Note:** This does NOT push to GitHub. Use auto-push.sh or manual git push for that.

### 3. `sync-to-obsidian.sh` (Memory Sync)

**Location:** `~/.openclaw/workspace/sync-to-obsidian.sh`  
**When to use:** Called automatically by auto-push.sh, or run manually after editing workspace memory files  
**What it does:**

```
Copies: ~/.openclaw/workspace/memory/* 
    → ~/Documents/Kai/Kai_Obsidian/Kai/Kai Memory/

Includes subdirectories:
    - archive/
    - weekly-reviews/
```

---

## Cron Schedule

| Job | Frequency | Script | Purpose |
|-----|-----------|--------|---------|
| Auto-push | Hourly (:00) | `auto-push.sh` | Full backup + GitHub sync |
| Heartbeat | Every 30 min | — | Health checks, alerts |

**Cron entries:**
```bash
# Hourly auto-push (runs at :00)
0 * * * * cd ~/.openclaw/workspace && bash auto-push.sh >> ~/.openclaw/logs/auto-push.log 2>&1

# Heartbeat checks (runs at :00 and :30)
0,30 * * * * [heartbeat command]
```

---

## What Gets Backed Up When

| Data Source | Local Backup | GitHub | Obsidian | Frequency |
|-------------|--------------|--------|----------|-----------|
| Workspace .md files | ✓ Kai_Memory/Workspace/ | ✓ kai-memory | ✓ (via memory sync) | Hourly |
| Session transcripts | ✓ Kai_Memory/Sessions/ | ✓ kai-memory | ✗ | Hourly |
| Obsidian vault | ✓ Kai_Obsidian/Backups/ | ✓ kai-obsidian | N/A | Hourly |
| MIND app | ✓ Repos/mind/Backups/ | Manual | ✗ | Manual/Auto |
| FLOW app | ✓ Repos/flow/Backups/ | Manual | ✗ | Manual/Auto |
| Website | ✓ Repos/website/Backups/ | Manual | ✗ | Manual/Auto |

---

## Deprecated / Don't Use

| Location | Reason | Status |
|----------|--------|--------|
| `~/Documents/Kai/Backup/` | Old structure, replaced by Kai_Memory/ | ❌ Deprecated |
| `~/Documents/Kai/Kai_Memory/Backups/` | Wrong location (00:44 mistake) | ❌ Wrong |

---

## Recovery Procedures

### Restore Workspace from GitHub
```bash
cd ~/.openclaw/workspace
git pull origin main
```

### Restore Obsidian from GitHub
```bash
cd ~/Documents/Kai/Kai_Obsidian/Kai
git pull origin main
```

### Find Historical Backup
```bash
# List all workspace backups
ls -la ~/Documents/Kai/Kai_Memory/Workspace/

# List all Obsidian backups
ls -la ~/Documents/Kai/Kai_Obsidian/Kai/Backups/
```

---

## Checklist: What Should Exist After Hourly Run

- [ ] `~/Documents/Kai/Kai_Memory/Workspace/dd-mm-yy/hhmm/` — with memory/, skills/, *.sh
- [ ] `~/Documents/Kai/Kai_Memory/Sessions/dd-mm-yy/hhmm/` — with .jsonl files
- [ ] `~/Documents/Kai/Kai_Obsidian/Kai/Backups/dd-mm-yy/hhmm/` — full vault snapshot
- [ ] `~/Documents/Kai/Kai_Obsidian/Kai/Kai Memory/` — synced from workspace/memory/
- [ ] GitHub kai-memory repo — latest commit within 1 hour
- [ ] GitHub kai-obsidian repo — latest commit within 1 hour

---

*This document lives in workspace/memory/ and syncs to Obsidian. Edit in either location.*
