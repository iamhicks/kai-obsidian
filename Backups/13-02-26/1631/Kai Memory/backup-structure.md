# Complete Backup & Sync Architecture

**Last Updated:** 12-02-2026  
**Purpose:** Reference document for how all backups, syncs, and GitHub pushes work

---

## Quick Reference — Manual Commands

**Run these from any terminal:**

```bash
# ═══════════════════════════════════════════════════════════
# FULL SYSTEM (Local + GitHub) — Everything with GitHub push
# ═══════════════════════════════════════════════════════════
# LOCAL BACKUP:
#   • Workspace       → Kai_Memory/Workspace/
#   • Sessions        → Kai_Memory/Sessions/
#   • MIND app/demo   → Repos/mind/*/Backups/daily/
#   • FLOW app/demo   → Repos/flow/*/Backups/daily/
#   • Website         → Repos/website/Backups/daily/
#   • Obsidian        → Kai_Obsidian/Kai/Backups/
#
# GITHUB PUSH:
#   • kai-memory repo (workspace)
#   • kai-obsidian repo (vault)
cd ~/.openclaw/workspace && bash auto-push.sh full


# ═══════════════════════════════════════════════════════════
# KAI MEMORY (Quick GitHub) — Workspace + Sessions only
# ═══════════════════════════════════════════════════════════
# LOCAL BACKUP:
#   • Workspace     → Kai_Memory/Workspace/
#   • Sessions      → Kai_Memory/Sessions/
#
# GITHUB PUSH:
#   • kai-memory repo
#
# Note: Use 'full' mode for Products (MIND/FLOW/Website)
cd ~/.openclaw/workspace && bash auto-push.sh


# ═══════════════════════════════════════════════════════════
# FULL BACKUP (Local only) — Everything without GitHub push
# ═══════════════════════════════════════════════════════════
# LOCAL BACKUP:
#   • Workspace       → Kai_Memory/Workspace/
#   • Sessions        → Kai_Memory/Sessions/
#   • MIND app/demo   → Repos/mind/*/Backups/daily/
#   • FLOW app/demo   → Repos/flow/*/Backups/daily/
#   • Website         → Repos/website/Backups/daily/
#   • Obsidian        → Kai_Obsidian/Kai/Backups/
#
# Note: No GitHub push (local only)
cd ~/.openclaw/workspace && bash backup-all.sh full


# ═══════════════════════════════════════════════════════════
# LOCAL BACKUP (Quick) — Workspace + Sessions + MIND, no GitHub
# ═══════════════════════════════════════════════════════════
# LOCAL BACKUP:
#   • Workspace  → Kai_Memory/Workspace/
#   • Sessions   → Kai_Memory/Sessions/
#   • MIND app   → Repos/mind/app/Backups/daily/
#
# Note: No GitHub push (local only)
cd ~/.openclaw/workspace && bash backup-all.sh


# ═══════════════════════════════════════════════════════════
# OBSIDIAN ONLY — Memory files to Obsidian, no GitHub
# ═══════════════════════════════════════════════════════════
# LOCAL SYNC:
#   • workspace/memory/* → Kai_Obsidian/Kai Memory/
#
# Note: No other files, no GitHub push
cd ~/.openclaw/workspace && bash sync-to-obsidian.sh
```

**Check last backup:**
```bash
ls -la ~/Documents/Kai/Kai_Memory/Workspace/
```

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
└── Backups/                  # Hourly vault snapshots (INSIDE vault, appears in Obsidian left sidebar)
    └── dd-mm-yy/
        └── hhmm/
```

### 3. Product Repositories

```
~/Documents/Kai/Repos/
├── mind/
│   ├── app/                  # Current Electron app code
│   │   └── Backups/
│   │       ├── daily/        # Auto timestamped backups
│   │       │   └── dd-mm-yy/
│   │       │       └── hhmm/
│   │       ├── stable/       # Named milestones (manual)
│   │       │   └── v1.0-ai-chat/
│   │       └── dev/          # Debug/dev checkpoints (temporary)
│   │           └── DEBUG1/
│   └── demo/                 # Demo version
│       └── Backups/
│           └── daily/
├── flow/
│   ├── app/
│   │   └── Backups/
│   │       └── daily/
│   └── demo/
│       └── Backups/
│           └── daily/
├── edge/                     # (when created)
└── website/
    └── Backups/
        └── daily/
```

---

## GitHub Repositories

| Repo | URL | Contents | Push Frequency |
|------|-----|----------|----------------|
| `kai-memory` | github.com/iamhicks/kai-memory | `~/.openclaw/workspace/` — SOUL.md, USER.md, memory/, skills/, *.sh | Hourly (auto-push.sh) |
| `kai-obsidian` | github.com/iamhicks/kai-obsidian | `~/Documents/Kai/Kai_Obsidian/Kai/` — Full vault | Hourly (auto-push.sh full) |
| `mind` | github.com/iamhicks/mind | `~/Documents/Kai/Repos/mind/` — Electron app + demo | Manual (during dev) |
| `flow` | github.com/iamhicks/flow | `~/Documents/Kai/Repos/flow/` — Task app | Manual (during dev) |
| `website` | github.com/iamhicks/website | `~/Documents/Kai/Repos/website/` — Marketing site | Manual (during dev) |

---

## Script Details

### 1. `auto-push.sh` (Primary Automation)

**Location:** `~/.openclaw/workspace/auto-push.sh`  
**Schedule:** Every hour (cron) — runs in QUICK mode  
**What it does:**

```
QUICK MODE (default, hourly cron):
Step 1: Backup workspace → Kai_Memory/Workspace/dd-mm-yy/hhmm/
        - Copies all .md, .sh, memory/, skills/

Step 2: Backup sessions → Kai_Memory/Sessions/dd-mm-yy/hhmm/
        - Copies .jsonl session files

Step 3: Push workspace → GitHub (kai-memory repo)
        - Commits with timestamp: "Auto-sync: DD-MM-YYYY HH:MM"

FULL MODE (manual only):
Step 4: Backup MIND app → Repos/mind/app/Backups/daily/dd-mm-yy/hhmm/
Step 5: Backup MIND demo → Repos/mind/demo/Backups/daily/dd-mm-yy/hhmm/
Step 6: Backup FLOW → Repos/flow/*/Backups/daily/dd-mm-yy/hhmm/
Step 7: Backup website → Repos/website/Backups/daily/dd-mm-yy/hhmm/
Step 8: Backup Obsidian vault → Kai_Obsidian/Kai/Backups/dd-mm-yy/hhmm/
Step 9: Push Obsidian → GitHub (kai-obsidian repo)
Step 10: Sync memory files to Obsidian
```

### 2. `backup-all.sh` (Manual/On-Demand)

**Location:** `~/.openclaw/workspace/backup-all.sh`  
**When to use:** Before major changes, manual checkpoint  
**What it does:**

```
Step 1: Backup workspace → Kai_Memory/Workspace/dd-mm-yy/hhmm/
Step 2: Backup sessions → Kai_Memory/Sessions/dd-mm-yy/hhmm/
Step 3: Backup MIND app → Repos/mind/app/Backups/daily/dd-mm-yy/hhmm/

FULL MODE:
Step 4: Backup MIND demo → Repos/mind/demo/Backups/daily/dd-mm-yy/hhmm/
Step 5: Backup FLOW → Repos/flow/*/Backups/daily/dd-mm-yy/hhmm/
Step 6: Backup website → Repos/website/Backups/daily/dd-mm-yy/hhmm/
Step 7: Backup Obsidian → Kai_Obsidian/Kai/Backups/dd-mm-yy/hhmm/
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

| Data Source | Local Backup | GitHub | Frequency |
|-------------|--------------|--------|-----------|
| Workspace .md files | ✓ Kai_Memory/Workspace/ | ✓ kai-memory | Hourly (quick) |
| Session transcripts | ✓ Kai_Memory/Sessions/ | ✓ kai-memory | Hourly (quick) |
| MIND app/demo | ✓ Repos/mind/*/Backups/daily/ | Manual | Full mode only |
| FLOW app/demo | ✓ Repos/flow/*/Backups/daily/ | Manual | Full mode only |
| Website | ✓ Repos/website/Backups/daily/ | Manual | Full mode only |
| Obsidian vault | ✓ Kai_Obsidian/Backups/ | ✓ kai-obsidian | Full mode only |

---

## Dev Workflow — Active Development Checkpoints

When actively developing MIND, FLOW, EDGE, or Website, use **manual checkpoints** at key moments:

### When to Create Checkpoints

| Trigger | Action | Where |
|---------|--------|-------|
| Feature works | Save to `stable/` | `Repos/mind/app/Backups/stable/v1.2-feature-name/` |
| Before risky change | Save to `dev/` | `Repos/mind/app/Backups/dev/before-refactor/` |
| End of session | Run full backup | `auto-push.sh full` |
| Milestone achieved | Copy to `stable/` with version | `Backups/stable/v1.0-ai-chat-working/` |

### Quick Checkpoint Commands

```bash
# Navigate to product directory
cd ~/Documents/Kai/Repos/mind/app

# Create stable milestone (feature works)
mkdir -p Backups/stable/v1.2-tab-switch-fix
cp -r * Backups/stable/v1.2-tab-switch-fix/ 2>/dev/null
echo "✓ Stable checkpoint created"

# Create dev checkpoint (before risky change)
mkdir -p Backups/dev/before-experiment
cp -r * Backups/dev/before-experiment/ 2>/dev/null
echo "✓ Dev checkpoint created"
```

### Dev Session End Protocol

```bash
# 1. Quick checkpoint of current state
mkdir -p Backups/dev/end-of-session-$(date +%H%M)
cp -r * Backups/dev/end-of-session-$(date +%H%M)/ 2>/dev/null

# 2. Run full backup (includes this checkpoint)
cd ~/.openclaw/workspace && bash auto-push.sh full
```

### Naming Conventions

| Folder | Purpose | Example |
|--------|---------|---------|
| `stable/` | Working versions, named milestones | `v1.0-ai-chat/`, `v1.2-tab-fix/` |
| `dev/` | Temporary checkpoints, experiments | `before-refactor/`, `debug-attempt-1/` |
| `daily/` | Auto timestamped (cron) | `12-02-26/0800/` |

### Rule

**Cron skips products** (saves space). **You checkpoint manually** during dev. **Full backup at end.**

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

# List all MIND backups
ls -la ~/Documents/Kai/Repos/mind/app/Backups/daily/

# List all Obsidian backups
ls -la ~/Documents/Kai/Kai_Obsidian/Kai/Backups/
```

---

## Checklist: What Should Exist After Hourly Run (Quick Mode)

- [ ] `~/Documents/Kai/Kai_Memory/Workspace/dd-mm-yy/hhmm/` — with memory/, skills/, *.sh
- [ ] `~/Documents/Kai/Kai_Memory/Sessions/dd-mm-yy/hhmm/` — with .jsonl files
- [ ] GitHub kai-memory repo — latest commit within 1 hour

## Checklist: What Should Exist After Full Mode

- [ ] Everything from quick mode PLUS:
- [ ] `~/Documents/Kai/Repos/mind/app/Backups/daily/dd-mm-yy/hhmm/` — MIND app backup
- [ ] `~/Documents/Kai/Repos/mind/demo/Backups/daily/dd-mm-yy/hhmm/` — MIND demo backup
- [ ] `~/Documents/Kai/Repos/flow/*/Backups/daily/dd-mm-yy/hhmm/` — FLOW backups
- [ ] `~/Documents/Kai/Repos/website/Backups/daily/dd-mm-yy/hhmm/` — website backup
- [ ] `~/Documents/Kai/Kai_Obsidian/Kai/Backups/dd-mm-yy/hhmm/` — Obsidian vault snapshot
- [ ] GitHub kai-obsidian repo — latest commit

---

*This document lives in workspace/memory/ and syncs to Obsidian. Edit in either location.*
