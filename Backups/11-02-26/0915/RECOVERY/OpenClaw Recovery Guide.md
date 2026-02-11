
## 🦞 Peter's OpenClaw Recovery Guide  
*Tested & verified on macOS with OpenClaw 2026.2.6-3 — no guesswork, just what works*

---

### ⚠️ Critical Pre-Install: Backup Your Brain First
```bash
# Backup workspace (.md files = your agent's identity)
cp -r ~/.openclaw/workspace ~/Desktop/openclaw-backup-workspace-$(date +%Y%m%d)

# Backup session logs (conversation history)
cp -r ~/.openclaw/memory/sessions ~/Desktop/openclaw-backup-sessions-$(date +%Y%m%d)
```
> 💡 Store these backups on Desktop/Cloud — they're your agent's entire personality + memory.

---

### 🔥 Nuclear Reinstall (When Config Is Broken)

#### Step 1: Wipe Everything Clean
```bash
# Stop gateway
openclaw gateway stop 2>/dev/null

# Uninstall package
npm uninstall -g openclaw

# ⚠️ DELETE ENTIRE ~/.openclaw DIRECTORY (this is required — OpenClaw preserves it across reinstalls)
rm -rf ~/.openclaw
```

#### Step 2: Fresh Install
```bash
npm install -g openclaw@latest
openclaw --version  # Verify: 2026.2.6-3 or later
```

#### Step 3: Initial Setup (QuickStart Mode ONLY)
```bash
openclaw configure
```
→ When prompted:  
- **Onboarding mode:** Select `QuickStart` (press `Enter`)  
- **Telegram bot token:** Paste your token (`6843928473:AAH...`)  
- **Kimi API key:** Paste your key (`sk-xxxxx...`)  
→ *Do NOT choose "Manual" — it triggers Ollama detection*

#### Step 4: Install Gateway Service (Critical!)
```bash
openclaw gateway install
openclaw gateway start
openclaw gateway status  # Verify: "Runtime: running (pid XXXX)"
```
> ⚠️ **This step is mandatory** — npm reinstall does NOT auto-register the macOS LaunchAgent service.

---

### 🔙 Restore Your Agent's Brain

#### Step 5: Restore Identity Files (`.md` files)
```bash
# Create workspace folder (if missing)
mkdir -p ~/.openclaw/workspace

# Copy YOUR backed-up .md files directly into workspace/
cp ~/Desktop/openclaw-backup-workspace-*/**/*.md ~/.openclaw/workspace/

# Verify
ls ~/.openclaw/workspace/*.md  # Should show 15+ files (IDENTITY.md, SOUL.md, etc.)
```
> ✅ **Correct:** Files live directly in `~/.openclaw/workspace/`  
> ❌ **Wrong:** Files nested in subfolders like `workspace/backup/`

#### Step 6: Restore Session Logs (Conversation History)
```bash
# Create sessions folder
mkdir -p ~/.openclaw/memory/sessions

# Copy session logs INTO sessions/ (not directly in memory/)
cp ~/Desktop/openclaw-backup-sessions-*/**/*.md ~/.openclaw/memory/sessions/

# Verify structure
ls ~/.openclaw/memory/sessions/  # Should show dated logs (08-02-2026.md, LESSONS.md, etc.)
```
> ✅ **Correct:** `~/.openclaw/memory/sessions/08-02-2026.md`  
> ❌ **Wrong:** `~/.openclaw/memory/08-02-2026.md` (logs ignored if not in `sessions/`)

#### Step 7: Restart Gateway to Load Files
```bash
openclaw gateway restart && sleep 5
```

---

### ✅ Verify Full Restoration

#### Step 8: Launch TUI & Test
```bash
openclaw tui
```

**Test prompts (copy-paste these exactly):**
```
hi
```
→ Should respond instantly with Kimi 2.5

```
Your name is Kai.
```
→ Confirms identity from `IDENTITY.md`

```
Review your session logs from yesterday (February 8th) and tell me what we worked on.
```
→ ✅ **Critical:** Must include **explicit date reference** for OpenClaw 2026.2.x  
→ Should recall specific details from your session logs

---

### 🚫 What NOT To Do (Based on Hard Lessons)

| Mistake | Why It Fails | Correct Approach |
|---------|--------------|------------------|
| Editing `~/.openclaw/openclaw.json` manually | JSON syntax errors break entire system | **Delete config entirely** → let OpenClaw regenerate via `configure` |
| Using `openclaw config set memorySearch...` | Not supported in 2026.2.6-3 → validation errors | **Skip entirely** — QuickStart auto-loads session logs |
| Putting session logs in `~/.openclaw/memory/` | Gateway ignores them → no recall | **Must be in `memory/sessions/`** |
| Skipping `openclaw gateway install` | Service not registered → TUI can't connect | **Always run after fresh install** |
| Asking "what did we do yesterday?" | Too vague for 2026.2.x → "I don't have an answer" | **Use explicit date prompts** ("Review session logs from February 8th...") |
| Choosing "Manual" mode in wizard | Triggers Ollama detection → config corruption | **Always choose QuickStart** |

---

### 💡 Pro Tips for Future Recovery

1. **Backup command to run monthly:**
   ```bash
   cp -r ~/.openclaw/workspace ~/Desktop/openclaw-backup-workspace-$(date +%Y%m%d) && \
   cp -r ~/.openclaw/memory/sessions ~/Desktop/openclaw-backup-sessions-$(date +%Y%m%d)
   ```

2. **Fix `.zshrc` error (harmless but annoying):**
   ```bash
   sed -i '' '/\.openclaw\/completions\/openclaw\.zsh/d' ~/.zshrc && source ~/.zshrc
   ```

3. **Telegram bot restoration (if needed):**
   ```bash
   openclaw config set channels.telegram.botToken "YOUR_TOKEN" && openclaw gateway restart
   ```

---

### 🦞 You're Done in <5 Minutes

1. `rm -rf ~/.openclaw` → nuclear wipe  
2. `npm install -g openclaw` → fresh install  
3. `openclaw configure` → QuickStart + enter tokens  
4. `openclaw gateway install && start` → critical service step  
5. Copy `.md` files → `workspace/`  
6. Copy session logs → `memory/sessions/`  
7. `openclaw gateway restart` → load everything  
8. `openclaw tui` → chat with restored Kai ✨

**No config debugging. No JSON errors. No Ollama interference.**  
Your agent's brain is 100% restored — ready to work exactly as before. 🚀