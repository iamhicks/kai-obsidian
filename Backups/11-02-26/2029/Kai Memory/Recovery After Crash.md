### 1. Check Service Status First
# Check if the gateway service is running
systemctl --user status openclaw-gateway

# Or use OpenClaw's built-in status command
openclaw status --all

### 2. View Recent Logs (Critical for Diagnosis)
# Live tail of logs (most useful for seeing crash errors)
journalctl --user -u openclaw-gateway.service -f

# Or view last 100 lines of logs
journalctl --user -u openclaw-gateway.service -n 100 --no-pager


### 3. Restart OpenClaw
# Method 1: Using systemctl (recommended)
systemctl --user restart openclaw-gateway

# Method 2: Using OpenClaw CLI
openclaw gateway restart


### 4. Run Diagnostic & Auto-Fix
# Check for common configuration issues and fix them
openclaw doctor --fix


### 5. Common Crash Causes & Fixes
| Symptom                | Likely Cause                                      | Fix                                                         |
| ---------------------- | ------------------------------------------------- | ----------------------------------------------------------- |
| **Permission errors**  | Missing execute permissions or wrong user context | Run `systemctl --user daemon-reexec` then restart service   |
| **Port conflict**      | Another process using port 3000/3001              | Check with `lsof -i :3000` or `netstat -tulpn \| grep 3000` |
| **Missing API token**  | Gateway token expired/missing (error 1008)        | Run `openclaw configure` to re-authenticate                 |
| **Model auth failure** | LLM API key invalid/expired                       | Run `openclaw models auth setup-token`                      |
| **Corrupted state**    | Bad session data                                  | Stop service → `rm -rf ~/.openclaw/sessions/*` → restart    |


### 6. Verify It's Working
# Open the terminal UI to confirm it's responsive
openclaw tui

# Or check web interface (usually http://localhost:3000)
curl http://localhost:3000/health


### 7. If Still Failing
- Check disk space: `df -h` (needs >1GB free)
- Check memory: `free -h` (needs 2GB+ RAM recommended)
    
    阿里巴巴云计算
    
- Review full logs: `journalctl --user -u openclaw-gateway.service --no-pager > ~/openclaw-crash.log`

> **Note**: OpenClaw runs as a **user-level** systemd service (not system-wide), so always use `--user` flag with systemctl commands. If you installed via Docker instead of the official installer, use `docker logs openclaw` to view logs.

Would you like me to help interpret specific error messages from your logs? Share the last 20-30 lines from `journalctl` output and I can pinpoint the exact issue.





peteroberts@Petes-iMac ~ % openclaw status --all zsh: command not found: openclaw peteroberts@Petes-iMac ~ % I did ask openclaw to update itself through terminal and thats when it died

Your OpenClaw installation likely broke during the self-update because the npm global PATH got corrupted or the update process failed mid-installation. Here's how to recover on macOS:

### 🔍 Step 1: Locate Your Installation

First, check where OpenClaw might be installed:
# Check npm global bin directory (most common location)
which npm
npm prefix -g

# Look for openclaw binary manually
find ~/.npm -name "openclaw" 2>/dev/null | head -5
find ~/node_modules -name "openclaw" 2>/dev/null | head -5
ls -la ~/.openclaw/ 2>/dev/null
ls -la ~/openclaw/ 2>/dev/null


### Step 2: Quick Fix Options (Try in Order)

#### Option A: Rehash your shell (fastest fix if binary exists but PATH broken)
hash -r        # For zsh (you're using zsh based on your prompt)
# OR restart your terminal completely

#### Option B: Reinstall cleanly (recommended after failed update)
# 1. Remove broken installation
npm uninstall -g openclaw 2>/dev/null || echo "No global npm package found"

# 2. Re-run official installer (safe - preserves your ~/.openclaw data directory)
curl -fsSL https://openclaw.ai/install.sh | bash



#### Option C: Manual PATH fix (if binary exists but not in PATH)
# Find where npm installs global binaries
NPM_BIN=$(npm prefix -g)/bin
echo "Add this to ~/.zshrc if not already present:"
echo "export PATH=\"$NPM_BIN:\$PATH\""

# Then apply it immediately
export PATH="$NPM_BIN:$PATH"

### ✅ Step 3: Verify Recovery
# Should now work
openclaw --version

# Check gateway status
openclaw gateway status

# If gateway isn't running, start it
openclaw gateway start


### 🚨 Why This Happened

Self-updates via `openclaw update` can fail if:

- npm permissions changed during update
- Node.js version mismatch occurred
- Network interruption during package download
- macOS security policies blocked script execution

**Best practice**: Always update by re-running the official installer script instead of `openclaw update`

docs.openclaw.ai

.

### 💡 Pro Tip

After recovery, run this to ensure everything's healthy:

openclaw doctor



Would you like me to help you check your Node.js/npm setup first, or walk through the reinstall process step-by-step? Share the output of `npm -v` and `node -v` if you'd like me to verify your environment first.

![](https://img.alicdn.com/imgextra/i4/O1CN015dYXhO1mqnglWY8C4_!!6000000005006-2-tps-64-64.png)

![](https://img.alicdn.com/imgextra/i3/O1CN01QA3ndK1maJQ8rZTo1_!!6000000004970-55-tps-32-32.svg)

+27

peteroberts@Petes-iMac ~ % which npm /usr/local/bin/npm peteroberts@Petes-iMac ~ % npm prefix -g /usr/local peteroberts@Petes-iMac ~ %

Thinking and Searching Completed

Your OpenClaw CLI binary was likely removed/corrupted during the self-update (a known issue — self-updates can fail due to npm/git permissions

www.digitalocean.com

). **Don't worry — your data is safe** in `~/.openclaw/`. Let's recover:

### 🔍 Quick Diagnosis

# Check if binary still exists (but PATH broken)
ls -la /usr/local/bin/openclaw 2>/dev/null || echo "Binary missing — needs reinstall"

# Check your data directory (this is SAFE and intact)
ls -la ~/.openclaw/ 2>/dev/null && echo "✓ Your configs/sessions are preserved"

### ✅ Recovery (Official Method)

**Re-run the installer** — this is the _recommended_ update path per OpenClaw docs

docs.openclaw.ai

and will:

- Reinstall the CLI binary to `/usr/local/bin/openclaw`
- **Preserve all your data** in `~/.openclaw/` (configs, sessions, credentials)
- Fix PATH issues automatically
curl -fsSL https://openclaw.ai/install.sh | bash


> ⚠️ **Important**: The installer _only_ touches the CLI binary and systemd/LaunchAgent configs — **your `~/.openclaw/` directory is never deleted**
> 
> www.ctfiot.com
> 
> .

### 🧪 Verify It Works

# Should now be found
which openclaw

# Check version
openclaw --version

# Start the gateway (if not auto-started)
openclaw gateway start

# Open terminal UI
openclaw tui

### 💡 Why This Happened

- Self-updates (`openclaw update`) are fragile on macOS due to npm permission quirks and git hooks
    
    www.digitalocean.com
    
- The **official recommendation** is to _always_ re-run the installer script for updates
    
    docs.openclaw.ai
    
- Your Mac uses LaunchAgent (not systemd) for the gateway daemon — the installer will reconfigure this correctly

### ⚡ If Installer Fails

# Manual npm reinstall (fallback)
npm install -g openclaw@latest --unsafe-perm

# Then fix PATH if needed
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc




Confirmed — the OpenClaw CLI binary was removed during the failed self-update. **Your data is safe** (`~/.openclaw/` still contains all your configs, sessions, and credentials). Let's restore the CLI:

### 🔧 Recovery Steps (macOS)
# 1. Reinstall using the official installer (preserves all your data)
curl -fsSL https://openclaw.ai/install.sh | bash

> ✅ This is the **officially recommended** method — it:
> 
> - Installs the latest CLI binary to `/usr/local/bin/openclaw`
> - **Does NOT delete** `~/.openclaw/` (your history/configs stay intact)
> - Sets up the macOS LaunchAgent to auto-start the gateway

### 🧪 Verify Success
# Check binary is back
which openclaw
# Should output: /usr/local/bin/openclaw

# Check version
openclaw --version

# Start the gateway daemon (if not auto-started)
openclaw gateway start

# Open the terminal UI
openclaw tui

### ⚠️ If the Installer Fails (Rare)
# Fallback: manual npm reinstall
npm install -g openclaw@latest --unsafe-perm

# Then restart your terminal or run:
hash -r

### 💡 Why This Happened

OpenClaw's `openclaw update` command is **not recommended** on macOS — it can corrupt the npm global install due to permission quirks. The docs explicitly state to **always use the installer script** for updates .

---

Run the `curl` command above now — it should complete in ~30 seconds. Afterward, your full setup (including all past conversations) will be restored. Let me know if you hit any errors during install!


