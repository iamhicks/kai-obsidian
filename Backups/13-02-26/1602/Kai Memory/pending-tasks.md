# Pending Tasks

## FLOW v2 Development (Active)

### Priority Order (Updated 13-02-2026)

#### 1. Module Interconnection 🔄
**Status:** In Progress  
**Priority:** HIGH  

Ensure all FLOW modules can communicate:
- Chat messages sync to Activity stream
- Tasks created in Chat appear in Kanban
- Kai Profile changes reflect in System Dashboard
- Schedule module triggers notifications

**Files to modify:**
- `server.js` — Add cross-module event bus
- `dashboard.html` — Module-to-module messaging

---

#### 2. UI Polish ✨
**Status:** Not started  
**Priority:** HIGH  

- Consistent styling across all modules
- Mobile responsiveness check
- Dark mode refinements
- Loading states for all async operations

---

#### 3. MIND Final Bug Fixes 🐛
**Status:** Not started  
**Priority:** HIGH  

- Message box positioning (bottom of sidebar)
- Any remaining AI chat issues
- Export functionality test
- Backup/restore verification

**See:** `MIND Technical Specification.md` for checklist

---

#### 4. Website Content Updates 🌐
**Status:** Not started  
**Priority:** MEDIUM  

**For MIND Launch:**
- Homepage hero update
- Feature list refinement
- Pricing page ($29)
- Demo video/gif
- Gumroad integration

**See:** `Website brief.md` in Obsidian

---

## Completed

- [x] Kai Profile / Soul Editor
- [x] Skills Browser / Manager
- [x] System Dashboard
- [x] Unified Chat with real-time sync
- [x] Schedule & Heartbeat module
- [x] STABLE backup created (STABLE-13-02-2026)
- [x] 3-Product Strategy documented
- [x] Unified App Architecture documented

---

## Strategy Reference

**Current Plan:** 3 Separate Products
1. **MIND** ($29) — Launch first, simple, offline-first
2. **FLOW** ($29) — Launch second, power-user tool
3. **MIND+FLOW** ($49) — Build only if demand exists

**See Obsidian:**
- `Business/Strategy/3-Product Strategy.md`
- `i_am-Hicks/i_am_Flow/Unified App Architecture.md`

---

*Last updated: 13-02-2026*
