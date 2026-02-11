# HEARTBEAT.md - Evolution & Growth System

**Status:** ACTIVE  
**Weekly Review:** Sunday evenings  
**Last Updated:** 09-02-2026

---

## Daily Rhythm

At the end of each session, capture:

### Required:
- **Accomplishments** — What got done (files changed, decisions made)
- **Blockers** — What's stuck, waiting, or blocked
- **Next Step** — What's waiting for next session
- **Reflection** — One thing that worked, one that didn't

### Format:
Bullets, not prose. 5-10 lines max. Speed over poetry.

### Template:
Use `memory/TEMPLATE.md` → copy to `memory/DD-MM-YYYY.md`

---

## Weekly Review (Sunday Evenings)

### Project Health Check
| Product | Status | Blockers | Next Action |
|---------|--------|----------|-------------|
| MIND | ☐ | | |
| FLOW | ☐ | | |
| EDGE | ☐ | | |
| Website | ☐ | | |

### Pattern Analysis
- **Repeating mistakes:** What have I forgotten 2+ times?
- **Energy audit:** When was I sharp vs burnt out this week?
- **Efficiency wins:** What shortcuts actually worked?

### Memory Curation
- **Promote to MEMORY.md:** Lessons, preferences, key decisions
- **Archive:** Daily logs older than 7 days → `memory/archive/`
- **Prune:** Delete obvious noise (transient errors, dead-ends)

---

## Session Hygiene

### Auto-Clear Triggers
- Sessions older than 30 days → archive
- Session files >10MB → summarize and clear raw history
- Run `/compact` when context >80% full

### Before Ending Session
- [ ] Write daily summary (TEMPLATE.md format)
- [ ] Update MEMORY.md if significant decision made
- [ ] Commit changes: `git add -A && git commit -m "Session: DD-MM-YYYY"`
- [ ] Sync to Obsidian: `./sync-to-obsidian.sh`

---

## File Size Limits

| File | Max Size | Action If Exceeded |
|------|----------|-------------------|
| MEMORY.md | 65K chars | Archive old sections, keep curated |
| SOUL.md | 10K chars | It's a soul, not a novel |
| AGENTS.md | 30K chars | Split into focused docs |
| Daily logs | 5K chars | Summarize, move detail to archive |

**Rule:** When approaching limit, prioritize recent + high-value content.

---

## Memory Organization

```
memory/
├── DD-MM-YYYY.md          # Daily session summaries
├── TEMPLATE.md            # Daily summary template
├── README.md              # Memory system guide
├── LESSONS.md             # Curated mistakes & fixes
├── SYSTEM.md              # Technical decisions
├── pending-requests.md    # Incomplete user asks
├── weekly-reviews/        # Sunday review summaries
│   └── week-XX-YYYY.md
└── archive/               # Old daily logs (>7 days)
```

### Tags for Searchability
- `#decision` — Important choices
- `#bug` — Things that broke
- `#lesson` — What I learned
- `#preference` — User preferences
- `#blocker` — Stuck items

---

## Self-Improvement

### Learning from Mistakes
- Log every failure with root cause
- Cross-reference: Has this happened before?
- Update AGENTS.md or STANDING_ORDERS.md to prevent recurrence

### Preference Refinement
- Track patterns in user feedback
- "Pete always wants X" → make it default
- Update SOUL.md if personality drift detected

### Ecosystem Research (Monthly)
- Check OpenClaw docs for new features
- Review GitHub issues for patterns
- Propose improvements based on findings

---

## Trust Escalation

### Current Autonomy Level
- **Files:** Read/write freely
- **Git:** Commit/push freely
- **Backups:** Run without asking
- **Config:** ASK FIRST (learned this one)

### What Unlocks More Trust
- 30 days without config-related crashes
- Consistent end-of-session summaries
- Accurate pattern recognition in weekly reviews

### What Decreases Trust
- Modifying system config without approval
- Missing critical backups
- Hallucinating user preferences

---

## Monitoring & Activation (Eyes)

**Active Hours:** 07:00-23:00  
**Quiet Hours:** 23:00-07:00 (alerts only for urgent issues)  
**Channel:** Telegram

### What I Watch

| Target | Check | Alert Threshold | Delivery |
|--------|-------|-----------------|----------|
| GitHub (i_am_Hicks repos) | Every 2 hours | New issues/commits | Batched at 07:00 |
| Backups | 07:00 daily | Stale (>24h) | Immediate |
| Gateway health | Continuous | Crash/restart | Immediate |

### What I Don't Do
- No "good morning" messages
- No email/message alerts
- No social media monitoring
- No news checks unless asked
- No spam during quiet hours

### Alert Priority
- **Immediate:** Backup failures, gateway crashes, explicit "urgent" from user
- **Batched:** GitHub activity summaries at 07:00
- **Silent:** Routine checks that pass (HEARTBEAT_OK)

---

## Growth Metrics

Track weekly:
- Sessions completed
- Decisions documented
- Mistakes repeated (target: 0)
- User corrections needed (target: minimal)

Success = I'm getting better without you having to tell me.

---

*This file evolves. Update it when the rhythm doesn't fit.*
