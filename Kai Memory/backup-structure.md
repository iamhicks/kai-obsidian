# Backup Structure Specification

**Last Updated:** 11-02-2026 (corrected from 00:44 mistake)

## Agreed Structure (10-02-2026)

### Kai Memory Files
```
~/Documents/Kai/Kai_Memory/
├── Sessions/
│   └── dd-mm-yy/
│       └── hhmm/          # Session exports
└── Workspace/
    └── dd-mm-yy/
        └── hhmm/          # OpenClaw workspace backup
```

### Application Repositories
```
~/Documents/Kai/Repos/
├── mind/
│   ├── app/               # Current Electron app
│   ├── demo/              # Demo version
│   └── dd-mm-yy/
│       └── hhmm/          # Versioned backups
├── flow/
├── edge/
└── website/
```

## What NOT to use

- ~~`~/Documents/Kai/Backup/`~~ — Old structure, deprecated
- ~~`~/Documents/Kai/Kai_Memory/Backups/`~~ — Wrong location (where 00:44 backup went)

## Script Location

`~/.openclaw/workspace/backup-all.sh` — Updated 11-02-2026 to use correct paths

## Cron Job Check

The cron job should verify:
1. `~/Documents/Kai/Kai_Memory/Workspace/dd-mm-yy/hhmm` exists
2. `~/Documents/Kai/Kai_Memory/Sessions/dd-mm-yy/hhmm` exists
3. `~/Documents/Kai/Repos/mind/dd-mm-yy/hhmm` exists (if MIND app exists)
