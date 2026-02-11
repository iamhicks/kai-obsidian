#!/bin/bash

# Master Backup Script (New Structure) - Runs every 30 minutes
# Backs up: Website, MIND (demo + app), FLOW (when ready), Obsidian, OpenClaw

BACKUP_ROOT="$HOME/Documents/Kai/Backup"
TIMESTAMP=$(date +%H%M)
DATE_FOLDER=$(date +%d-%m-%y)

echo "=== Master Backup Started at $(date) ==="

# 1. Backup OpenClaw
echo "[1/5] Backing up OpenClaw..."
mkdir -p "$BACKUP_ROOT/OpenClaw/$DATE_FOLDER/$TIMESTAMP"
cp -r "$HOME/.openclaw/workspace/"* "$BACKUP_ROOT/OpenClaw/$DATE_FOLDER/$TIMESTAMP/" 2>/dev/null || true
cp "$HOME/.openclaw/openclaw.json" "$BACKUP_ROOT/OpenClaw/$DATE_FOLDER/$TIMESTAMP/" 2>/dev/null || true
echo "  ✓ OpenClaw backed up"

# 2. Backup Obsidian
echo "[2/5] Backing up Obsidian..."
mkdir -p "$BACKUP_ROOT/Obsidian/$DATE_FOLDER/$TIMESTAMP"
cp -r "$HOME/Documents/Kai/Kai_Obsidian/"* "$BACKUP_ROOT/Obsidian/$DATE_FOLDER/$TIMESTAMP/" 2>/dev/null || true
echo "  ✓ Obsidian backed up"

# 3. Backup Website (marketing site only)
echo "[3/5] Backing up Website..."
mkdir -p "$BACKUP_ROOT/Website/$DATE_FOLDER/$TIMESTAMP"
cp -r ~/Documents/Kai/Repos/website/* "$BACKUP_ROOT/Website/$DATE_FOLDER/$TIMESTAMP/" 2>/dev/null || true
echo "  ✓ Website backed up"

# 4. Backup MIND (demo + app)
echo "[4/5] Backing up MIND..."
mkdir -p "$BACKUP_ROOT/MIND/$DATE_FOLDER/$TIMESTAMP/demo"
mkdir -p "$BACKUP_ROOT/MIND/$DATE_FOLDER/$TIMESTAMP/app"
cp -r ~/Documents/Kai/Repos/mind/demo/* "$BACKUP_ROOT/MIND/$DATE_FOLDER/$TIMESTAMP/demo/" 2>/dev/null || true
cp -r ~/Documents/Kai/Repos/mind/app/* "$BACKUP_ROOT/MIND/$DATE_FOLDER/$TIMESTAMP/app/" 2>/dev/null || true
echo "  ✓ MIND backed up (demo + app)"

# 5. Backup FLOW (when ready)
echo "[5/5] Backing up FLOW..."
if [ -d ~/Documents/Kai/Repos/flow/demo ] && [ "$(ls -A ~/Documents/Kai/Repos/flow/demo 2>/dev/null)" ]; then
  mkdir -p "$BACKUP_ROOT/FLOW/$DATE_FOLDER/$TIMESTAMP/demo"
  cp -r ~/Documents/Kai/Repos/flow/demo/* "$BACKUP_ROOT/FLOW/$DATE_FOLDER/$TIMESTAMP/demo/" 2>/dev/null || true
  echo "  ✓ FLOW backed up"
else
  echo "  ℹ FLOW not ready yet (skipped)"
fi

echo ""
echo "=== Backup Complete at $(date) ==="
echo "Location: $BACKUP_ROOT/{Component}/$DATE_FOLDER/$TIMESTAMP/"
echo ""
echo "Backed up components:"
ls -ld "$BACKUP_ROOT"/*/"$DATE_FOLDER"/"$TIMESTAMP" 2>/dev/null | awk '{print "  - " $9}'
