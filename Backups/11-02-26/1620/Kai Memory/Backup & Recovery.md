# Backup & Recovery

*Last updated: 06/02/2026*

**To export to external drive:**

```bash
# Copy the latest backup
cp -r ~/Documents/Kai/Backup/2026-02-06_07-26/ /Volumes/YourDrive/KaiBackup/

# Or run fresh backup first
~/.openclaw/workspace/backup-all.sh
```


## What Gets Backed Up

### 1. Kai Memory (GitHub)
**Location:** `~/.openclaw/workspace/` → GitHub (`kai-memory` repo)

**Includes:**
- `MEMORY.md` — Long-term curated memory
- `memory/YYYY-MM-DD.md` — Daily session logs
- `memory/LESSONS.md` — What went wrong & how to fix
- `AGENTS.md` — Agent configuration
- `SOUL.md` — Identity & personality
- `USER.md` — Your preferences & context
- `TOOLS.md` — Environment-specific notes
- `HEARTBEAT.md` — Periodic task checklist
- `IDENTITY.md` — Name, emoji, vibe
- `BOOTSTRAP.md` — First-run instructions (usually deleted after setup)
- `sync-to-obsidian.sh` — Sync script

**Excludes:**
- `config.json` (sensitive API keys)
- `media/` (large files)
- Runtime files

### 2. Obsidian Vault (Local + Git)
**Location:** `/Users/peteroberts/Documents/Kai/Kai_Obsidian/Kai/`

**Includes:**
- Everything from Kai Memory (copied via sync script)
- Trading notes & scripts
- Business ideas & marketing
- Task boards
- Project documentation
- Any files you manually add

### 3. Project Files (GitHub + Local)
**Individual repos:**
- `iamhicks-website` — Marketing site at `/Users/peteroberts/Documents/Kai/Website/`
  - Contains: iamhicks-landing.html (main site), mind-landing.html, taskmaster-features.html
- `website` (mind-demo) — Mind app at `/Users/peteroberts/Documents/Kai/KnowledgeBase/`
  - Contains: index.html (Mind app), mind-demo/ (deployed version)
- `kai-obsidian` — Obsidian vault
- TradingJournal, TaskMaster, FinanceTracker — as configured

**⚠️ IMPORTANT:** Website (marketing) and KnowledgeBase (Mind app) are DIFFERENT folders. Do not confuse them.

### 4. Local Backup Copy (External Drive)
**Location:** `/Users/peteroberts/Documents/Kai/Backup/`

**Structure:**
```
/Backup/
  README.txt              - Master index
  /Website/dd-mm-yy/      - Marketing website (iamhicks.com)
  /Obsidian/dd-mm-yy/     - Obsidian vault
  /Mind/dd-mm-yy/         - Mind knowledge base app
  /Edge/dd-mm-yy/         - TradingJournal
  /Flow/dd-mm-yy/         - TaskMaster
  /OpenClaw/dd-mm-yy/     - OpenClaw config + memory files
```

**Includes:**
- Complete copy of each component
- Timestamped folders (dd-mm-yy format)
- Master README with restore instructions

**Retention:**
- Last 10 backups per component kept automatically
- Older backups auto-deleted

**Use this for:**
- Exporting to external drive
- Offline backup
- Quick restore without internet

## When Backups Happen

| Trigger | What Happens |
|---------|--------------|
| **End of session** | I commit memory files to GitHub |
| **Major changes** | I commit immediately (marked as such) |
| **Explicit request** | You say "backup now" → immediate commit |
| **Obsidian sync** | Manual via `./sync-to-obsidian.sh` or implicitly at session end |
| **Project deploys** | Each deploy to `mind-demo/` etc is a git commit |
| **Master script** | Run `~/.openclaw/workspace/backup-all.sh` for everything |

## Quick Backup Command

**Backup everything to GitHub + create local copy:**
```bash
~/.openclaw/workspace/backup-all.sh
```

This will:
1. Commit Kai Memory to GitHub
2. Sync & commit Obsidian to GitHub
3. Commit all project repos to GitHub
4. Create local backup in `~/Documents/Kai/Backup/`
5. Keep only last 10 local backups

**For local copy only (no GitHub):**
```bash
# Copy timestamped backup folder to external drive
cp -r ~/Documents/Kai/Backup/2026-*-*/ /Volumes/YourDrive/KaiBackup/
```

## How to Check Backup Status

### GitHub (Kai Memory)
```bash
cd ~/.openclaw/workspace
git log --oneline -5  # See last 5 commits
git status             # See uncommitted changes
```

### Obsidian Vault
```bash
cd ~/Documents/Kai/Kai_Obsidian/Kai
git log --oneline -5
git status
```

### Project Repos
```bash
cd ~/Documents/Kai/KnowledgeBase  # or other project
git log --oneline -5
git status
```

## Recovery Scenarios

### Scenario 1: New Machine Setup

**Prerequisites:**
- macOS (or Linux with modifications)
- Homebrew installed
- GitHub account with SSH keys

**Step-by-Step:**

1. **Install Homebrew** (if not present):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install required packages:**
   ```bash
   brew install git node ffmpeg
   ```

3. **Install OpenClaw:**
   ```bash
   # Follow OpenClaw installation guide
   # (Usually: download from clawhub.com or install via npm)
   ```

4. **Clone Kai Memory:**
   ```bash
   mkdir -p ~/.openclaw
   cd ~/.openclaw
   git clone git@github.com:hellokaibot-alt/kai-memory.git workspace
   ```

5. **Create necessary directories:**
   ```bash
   mkdir -p ~/.openclaw/workspace/memory
   mkdir -p ~/Documents/Kai_Obsidian
   ```

6. **Clone Obsidian vault:**
   ```bash
   mkdir -p ~/Documents/Kai
   cd ~/Documents/Kai
   git clone git@github.com:hellokaibot-alt/kai-obsidian.git Kai_Obsidian
   ```

7. **Open Obsidian** and point it to `~/Documents/Kai/Kai_Obsidian/Kai/`

7. **Clone project repos as needed:**
   ```bash
   mkdir -p ~/Documents/Kai
   cd ~/Documents/Kai
   git clone git@github.com:hellokaibot-alt/website.git
   # etc for other projects
   ```

8. **Start OpenClaw** — I should now have full access to all memory and context

### Scenario 2: Obsidian Vault Lost/Corrupted

**Recovery options:**

1. **From GitHub:**
   ```bash
   mkdir -p ~/Documents/Kai
   cd ~/Documents/Kai
   rm -rf Kai_Obsidian  # Remove corrupted
   git clone git@github.com:hellokaibot-alt/kai-obsidian.git Kai_Obsidian
   ```

2. **From Kai Memory sync:**
   ```bash
   cd ~/.openclaw/workspace
   ./sync-to-obsidian.sh
   # This copies all memory files to Obsidian
   ```

### Scenario 3: Specific File Recovery

**From Git history:**
```bash
cd ~/.openclaw/workspace
git log --all --full-history -- memory/2026-02-05.md  # Find commits with file
git show <commit-hash>:memory/2026-02-05.md > recovered.md
```

**From GitHub web:**
1. Go to github.com/hellokaibot-alt/kai-memory
2. Navigate to file
3. Click "History"
4. Find version you want
5. Click "View" then "Raw" to download

## What I've Installed (For Reference)

### System Tools
- **Homebrew** — Package manager
- **Git** — Version control
- **Node.js** — JavaScript runtime
- **ffmpeg** — Video/audio processing

### OpenClaw Components
- **OpenClaw Gateway** — Core daemon
- **OpenClaw Agent** — This agent (main)
- **Channel plugins** — Telegram, etc.

### Project Dependencies
- **Phosphor Icons** — Icon font (CDN)
- **GitHub Pages** — Static hosting

## Backup Checklist (For Pete)

- [ ] Run master backup weekly: `~/.openclaw/workspace/backup-all.sh`
- [ ] Copy local backup to external drive monthly
- [ ] Verify GitHub repos are accessible
- [ ] Keep SSH keys backed up (for GitHub access)

## Emergency Contacts

If recovery fails:
1. Check GitHub repos directly (all code/memory is there)
2. Daily memory files have timestamps — easy to identify latest
3. Project repos separate from memory — can recover independently

---

## Current Repo Status

| Repo | GitHub | Local Backup |
|------|--------|--------------|
| kai-memory | ✅ github.com/hellokaibot-alt/kai-memory | ✅ ~/Documents/Kai/Backup/ |
| kai-obsidian | ✅ github.com/hellokaibot-alt/kai-obsidian | ✅ Included above |
| iamhicks-website | ✅ github.com/hellokaibot-alt/iamhicks-website | ✅ Included above |
| mind-demo | ✅ github.com/hellokaibot-alt/website | ✅ Included above |
