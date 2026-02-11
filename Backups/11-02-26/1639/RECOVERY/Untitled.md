
## 🦞 Peter's Complete OpenClaw Recovery Guide  
*Tested on macOS — no loops, no guesswork, just what works*

---

### 🔥 Phase 1: Nuclear Wipe (Complete Removal)

#### Step 1: Stop All OpenClaw Processes
```bash
pkill -f openclaw 2>/dev/null || true
launchctl unload ~/Library/LaunchAgents/ai.openclaw.gateway.plist 2>/dev/null || true
sleep 2
```

#### Step 2: Uninstall npm Package
```bash
npm uninstall -g openclaw
```

#### Step 3: Delete Config Folder (Critical!)
```bash
rm -rf ~/.openclaw
```
> ⚠️ **This is the key step** — OpenClaw preserves this folder across reinstalls. Deleting it ensures a *truly clean* slate.

#### Step 4: Clean Up LaunchAgent Remnants
```bash
rm -f ~/Library/LaunchAgents/ai.openclaw.gateway.plist
```

#### Step 5: Verify Clean Slate
```bash
ls ~/.openclaw 2>&1 | grep -q "No such file" && echo "✓ OpenClaw fully wiped"
```
✅ Should print: `✓ OpenClaw fully wiped`

---

### 🚀 Phase 2: Fresh Install + Safe Setup

#### Step 6: Install OpenClaw
```bash
npm install -g openclaw@latest
openclaw --version  # Verify: 2026.2.6-3 or later
```

#### Step 7: Run Wizard (Skip Telegram First!)
```bash
openclaw configure
```

**Follow these exact selections:**
| Prompt | Your Action |
|--------|-------------|
| **Onboarding mode** | Press `Enter` (accept `QuickStart`) |
| **Telegram bot token** | Press `Enter` (**leave blank** — skip Telegram for now) |
| **Kimi API key** | Paste your **standard Moonshot API key** from https://platform.moonshot.cn/ (80+ chars, starts with `sk-`, **NO `-kimi-` prefix**) |
| **All other prompts** | Press `Enter` (accept defaults) |

> 💡 **Critical:** Skip Telegram initially to avoid wizard loops. We'll add it later after Kimi is working.

#### Step 8: Install Gateway Service
```bash
openclaw gateway install
openclaw gateway start
sleep 5
openclaw gateway status  # Verify: "Runtime: running (pid XXXX)"
```

#### Step 9: Test Kimi Works
```bash
openclaw tui
```
→ Type `hi` → should get **instant response** ✅  
→ If not: your key is invalid — regenerate at https://platform.moonshot.cn/

---

### 🗂️ Phase 3: Find OpenClaw Folders in Finder (GUI Method)

#### Step 10: Open Workspace Folder (Where `.md` Identity Files Live)
1. Open **Finder**
2. Press `Cmd+Shift+G` (Go to Folder)
3. Type exactly:
   ```
   ~/.openclaw/workspace
   ```
4. Press **Go**

✅ You'll see the folder where your agent's brain lives (`IDENTITY.md`, `SOUL.md`, etc.)

#### Step 11: Open Sessions Folder (Where Conversation Logs Live)
1. In Finder, press `Cmd+Shift+G` again
2. Type exactly:
   ```
   ~/.openclaw/memory/sessions
   ```
3. Press **Go**

✅ You'll see the folder for your session logs (`08-02-2026.md`, `LESSONS.md`, etc.)

> 💡 **Pro Tip:** Drag these folders to your Finder sidebar for 1-click access next time.

---

### ♻️ Phase 4: Restore Your Agent's Brain (`.md` Files)

#### Step 12: Copy Identity Files to Workspace
**In Finder:**
1. Open your backup folder (e.g., `~/Desktop/openclaw-workspace-backup/`)
2. Select **all `.md` files** (`IDENTITY.md`, `SOUL.md`, `PROTOCOL_*.md`, etc.)
3. Drag them into the `workspace` folder you opened in Step 10

**Or via Terminal (faster):**
```bash
cp ~/Desktop/openclaw-workspace-backup/*.md ~/.openclaw/workspace/
```

#### Step 13: Copy Session Logs to Sessions Folder
**In Finder:**
1. Open your sessions backup folder (e.g., `~/Desktop/openclaw-sessions-backup/`)
2. Select **all `.md` files**
3. Drag them into the `sessions` folder from Step 11

**Or via Terminal:**
```bash
mkdir -p ~/.openclaw/memory/sessions
cp ~/Desktop/openclaw-sessions-backup/*.md ~/.openclaw/memory/sessions/
```

> ✅ **Critical:** Files must be **directly inside** `workspace/` and `sessions/` — not in subfolders.

---

### 🔄 Phase 5: Force Agent to Recognize Files

#### Step 14: Restart Gateway (Reloads All Files)
```bash
openclaw gateway restart && sleep 5
```
> ⚡ This forces OpenClaw to:
> - Reload all `.md` files from `workspace/`
> - Rebuild index of session logs in `memory/sessions/`

#### Step 15: Launch TUI
```bash
openclaw tui
```

---

### ✅ Phase 6: Verify Full Restoration

**In TUI, type these exact prompts:**

| Prompt | Expected Response | Confirms |
|--------|-------------------|----------|
| `Your name is?` | "I'm Kai" | ✅ `IDENTITY.md` loaded |
| `What are your core protocols?` | Details from `SOUL.md` + `PROTOCOL_*.md` | ✅ Personality files active |
| `Review session logs from February 8th and tell me what we worked on.` | Specific details from `08-02-2026.md` | ✅ Session logs indexed |

> 💡 **Critical for OpenClaw 2026.2.6-3:** Session logs require **explicit date prompts** — vague questions like "what did we do yesterday?" won't trigger recall.

---

### 🔌 Phase 7: Add Telegram (Optional — Only After Kimi Works)

Once Kimi is responding reliably:

```bash
openclaw config set channels.telegram.botToken "YOUR_TELEGRAM_BOT_TOKEN"
openclaw config set channels.telegram.enabled true
openclaw config set channels.telegram.dmPolicy "allowlist"
openclaw config set channels.telegram.allowFrom '["498418257"]'
openclaw gateway restart
```

Then message `@Hello_Kaibot` on Telegram — it will respond instantly ✨

---

## 📋 Quick Reference Cheat Sheet

| Task | Command / Action |
|------|------------------|
| **Nuclear wipe** | `rm -rf ~/.openclaw` + `npm uninstall -g openclaw` |
| **Open workspace folder** | Finder → `Cmd+Shift+G` → `~/.openclaw/workspace` |
| **Open sessions folder** | Finder → `Cmd+Shift+G` → `~/.openclaw/memory/sessions` |
| **Reload all files** | `openclaw gateway restart && sleep 5` |
| **Test identity** | In TUI: `Your name is?` |
| **Test session recall** | In TUI: `Review session logs from February 8th...` |
| **Fix `.zshrc` error** | `sed -i '' '/\.openclaw\/completions/d' ~/.zshrc && source ~/.zshrc` (harmless — fix later) |

---

## 💡 Critical Reminders

1. **Use standard Moonshot API key** — NOT Kimi Coding subscription key (`sk-kimi-...`)
   - Get it from: https://platform.moonshot.cn/ → API Keys
   - Format: `sk-` + 80+ random characters (NO `-kimi-` prefix)

2. **Session logs need explicit prompts** — OpenClaw 2026.2.6-3 won't auto-recall vague questions

3. **Skip Telegram during initial setup** — avoids wizard loops in this version

4. **`.zshrc` error is harmless** — the missing completions file doesn't affect functionality

---

## 🦞 You're Done in 5 Minutes Flat

1. Run **Phase 1** (nuclear wipe) → 30 seconds  
2. Run **Phase 2** (fresh install + safe setup) → 2 minutes  
3. Run **Phases 3–4** (restore `.md` files via Finder) → 1 minute  
4. Run **Phase 5** (restart gateway) → 10 seconds  
5. Run **Phase 6** (verify) → 30 seconds  

✅ **Your agent is fully restored** — personality intact, memory active, Kimi responding instantly.  
✅ **No config debugging. No validation loops. No reinstall needed again.**  

Save this guide — you'll never need to debug OpenClaw again. 🦞✨