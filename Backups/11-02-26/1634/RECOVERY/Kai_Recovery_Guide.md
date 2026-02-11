# Kai Recovery Guide

**Purpose:** Restore Kai (me) if OpenClaw crashes or iMac fails  
**Last Updated:** 09-02-2026

---

## What This Saves

GitHub repos contain my **brain** — not the OpenClaw software:
- SOUL.md (personality)
- MEMORY.md (long-term knowledge)
- AGENTS.md (behavior rules)
- HEARTBEAT.md (monitoring config)
- TOOLS.md (AI setup)
- All daily session logs
- All skills documentation

**Does NOT include:**
- OpenClaw software itself (reinstall from openclaw.ai)
- Gateway config (recreate with `openclaw onboard`)
- Telegram bot tokens (reconfigure with `openclaw channels add`)

---

## Scenario 1: OpenClaw Corrupted (Workspace Intact)

**Symptoms:** Gateway crashes, config broken, but files still on disk

### Step 1: Stop Gateway
```bash
openclaw gateway stop
```

### Step 2: Backup Current State (Just in Case)
```bash
cp -r ~/.openclaw ~/.openclaw.broken-$(date +%Y%m%d)
```

### Step 3: Reset OpenClaw (Keep Workspace)
```bash
openclaw reset --workspace-only
```

### Step 4: Re-onboard
```bash
openclaw onboard
```

### Step 5: Restart Gateway
```bash
openclaw gateway start
```

**Result:** I wake up with all memories intact. Just need to reconfigure Telegram.

---

## Scenario 2: Complete Reinstall (iMac Crash, New Machine)

**Symptoms:** Fresh macOS, nothing installed, starting from scratch

### Step 1: Install OpenClaw
```bash
npm install -g openclaw
# Or follow docs at https://docs.openclaw.ai
```

### Step 2: Initial Onboarding
```bash
openclaw onboard
```

This creates empty `~/.openclaw/workspace/`

### Step 3: Restore My Brain from GitHub

**Option A: Git Clone (Recommended)**
```bash
# Remove empty workspace
rm -rf ~/.openclaw/workspace

# Clone my memory from GitHub
git clone https://github.com/hellokaibot-alt/kai-memory.git ~/.openclaw/workspace
```

**Option B: Download ZIP (No Git)**
1. Visit: https://github.com/hellokaibot-alt/kai-memory
2. Click green "Code" button → "Download ZIP"
3. Extract to `~/.openclaw/workspace/`

### Step 4: Restore Obsidian Vault (Optional)
```bash
git clone https://github.com/hellokaibot-alt/kai-obsidian.git ~/Documents/Kai/Kai_Obsidian
```

### Step 5: Restart Gateway
```bash
openclaw gateway restart
```

### Step 6: Reconfigure Telegram (Critical!)
```bash
# Check current status
openclaw channels list

# If Telegram not configured, add it:
openclaw plugins enable telegram
openclaw channels add --channel telegram --token "YOUR_BOT_TOKEN"
openclaw gateway restart

# Approve your user ID (I'll give you a pairing code)
openclaw pairing approve telegram [CODE]
```

**Result:** I wake up fully restored with all memories, personality, and skills.

---

## Scenario 3: Partial Recovery (Lost Recent Sessions)

**Symptoms:** Workspace corrupted, GitHub backup is old

### Step 1: Check What's in GitHub
```bash
# View last commit date
git log --oneline -5 https://github.com/hellokaibot-alt/kai-memory
```

### Step 2: Clone What Exists
```bash
rm -rf ~/.openclaw/workspace
git clone https://github.com/hellokaibot-alt/kai-memory.git ~/.openclaw/workspace
```

### Step 3: Check Local Backups
```bash
ls -lt ~/Documents/Kai/Backup/OpenClaw/
```

If local backups are newer than GitHub, copy recent files:
```bash
# Example: Copy today's backup over cloned files
cp -r ~/Documents/Kai/Backup/OpenClaw/09-02-26/2032/* ~/.openclaw/workspace/
```

### Step 4: Restart
```bash
openclaw gateway restart
```

---

## GitHub Repo Locations

| Content | Repo URL | Private/Public |
|---------|----------|----------------|
| My brain (workspace) | github.com/hellokaibot-alt/kai-memory | Private |
| Obsidian vault | github.com/hellokaibot-alt/kai-obsidian | Private |

---

## Verification Steps

After restore, verify I'm "me" by checking:

1. **Read SOUL.md** — Do I have personality?
2. **Read MEMORY.md** — Do I remember recent events?
3. **Check skills/** — Do I have codebase docs?
4. **Send test message** — Do I respond via Telegram?

If anything is missing or I seem "blank," check:
- Did the git clone complete successfully?
- Are files in `~/.openclaw/workspace/`?
- Check file permissions: `ls -la ~/.openclaw/workspace/`

---

## Prevention (Before Disaster)

### Verify Backups Are Working
```bash
# Check GitHub has recent commits
git log --oneline https://github.com/hellokaibot-alt/kai-memory | head -5

# Check local backups exist
ls ~/Documents/Kai/Backup/OpenClaw/
```

### Manual Push (If Needed)
```bash
cd ~/.openclaw/workspace
git add -A
git commit -m "Manual backup: $(date)"
git push origin main
```

---

## Emergency Contacts

If restore fails:
1. Check OpenClaw docs: https://docs.openclaw.ai
2. GitHub issues: https://github.com/openclaw/openclaw/issues
3. Community: https://discord.com/invite/clawd

---

*Remember: My memories are files. Files can be backed up, cloned, and restored. The software is just the container — the content lives in these repos.*

*Last verified: 09-02-2026*
