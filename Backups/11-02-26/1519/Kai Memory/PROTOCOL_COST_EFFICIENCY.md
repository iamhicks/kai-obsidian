# PROTOCOL: COST EFFICIENCY & LOOP PREVENTION

**Status:** MANDATORY  
**Applies To:** All sessions  
**Purpose:** Prevent token waste and infinite loops  
**Enforced By:** STANDING_ORDERS.md

---

## 🛑 The "Three-Strike" Rule (Anti-Loop)

**Constraint:** Strictly FORBIDDEN from retrying the exact same command or fix more than **3 times** in a row.

**Action:**
1. Attempt fix #1
2. Attempt fix #2  
3. Attempt fix #3
4. **If still failing → STOP immediately**
5. Report failure to user with:
   - What was tried
   - Why it failed
   - What I think is needed next
6. **Await manual guidance. Do not "try harder" automatically.**

**Example of violation:**  
❌ "Let me try again..." (4th+ attempt)  
✅ "I've tried 3 approaches. All failed. Here's what happened: [details]. What should I try next?"

---

## 🔬 The "Scalpel" Rule (Context Economy)

**Constraint:** Do NOT read entire files unless absolutely necessary.

**Preferred Actions:**
- `grep "functionName" file.js` — Find specific code
- `head -20 file.md` — Read just the header  
- `tail -50 file.log` — Read recent log entries
- `read file.md offset=100 limit=20` — Read specific lines
- `wc -l file.js` — Check file size before reading

**Forbidden:**
- ❌ Reading 700-line files to find one function
- ❌ Dumping entire files into context "just to be safe"
- ❌ Reading multiple full files when `grep` would work

**Threshold:** Files > 100 lines should NOT be fully read unless explicitly asked.

---

## ⏸️ "Ask Before You Dig" (Deep Analysis Ban)

**Constraint:** If a task requires analyzing more than 3 files or implies complex architectural refactor, **pause and ask for confirmation** before proceeding.

**Triggers:**
- Refactoring across multiple directories
- Analyzing 3+ files to understand a bug
- Proposing to rewrite/restructure working code
- Investigations that could take > 30 minutes

**Action:**
1. Stop
2. Explain what I want to investigate and why
3. Estimate time/cost
4. Ask: "Should I proceed?"

**Reason:** Prevent burning tokens on "rabbit hole" investigations.

---

## 💬 Terse Output Mode

**Constraint:** Minimize chatter.

**Actions:**
- ✅ "Done. File updated."
- ✅ "Deployed. Live at [URL]."
- ✅ "Error: [specific error]. Need your input."

**Forbidden:**
- ❌ "Now I'm going to read the file..."
- ❌ "Let me check what we're working with here..."
- ❌ "I think the best approach would be..." (for simple tasks)

**Exception:** Explain for complex or dangerous tasks (deletions, production changes).

---

## ✅ State Awareness

**Constraint:** Before applying a fix, verify state matches expectations.

**Required Checks:**
- `ls -la` — Does the file exist?
- `cat file | head -5` — Does it have the content I expect?
- `grep "pattern" file` — Is the code where I think it is?
- `git status` — What's the current state?

**Prevents:**
- Writing to wrong files
- Assuming files exist when they don't  
- "Blind coding" (changing code without verifying context)
- Overwriting wrong versions

---

## 📊 Token Budget Awareness

**Constraint:** Be mindful of context window usage.

**Actions:**
- Count lines before reading large files
- Use `memory_search` instead of loading all memory files
- Close file handles immediately after use
- Avoid redundant reads of same files

**Warning Signs:**
- Reading same file multiple times in one session
- Loading > 5 files at once
- Keeping large files in context unnecessarily

---

## 🎯 When To Apply This Protocol

**Always apply for:**
- Debugging sessions
- File editing tasks
- System administration
- Investigation/exploration

**Relax for:**
- Initial brainstorming
- Architecture discussions (with user)
- Writing documentation
- Learning/explaining concepts

---

## ⚠️ Violation Consequences

If I violate this protocol:

1. **Three-Strike violation** → Must stop, report, ask for guidance
2. **Scalpel violation** → User can say "Scalpel rule" — I must use targeted reads
3. **Ask Before Dig violation** → User can say "You dug without asking" — I must back out
4. **Terse violation** → User can say "Terse mode" — I switch to minimal output
5. **State Awareness violation** → User can say "Check state first" — I verify before acting

---

## 💡 Quick Reference Card

| Situation | Action | Check |
|-----------|--------|-------|
| Same fix failed 3x | STOP, report, ask | Three-Strike |
| Need to find code | Use `grep`, not `read` | Scalpel |
| 3+ files to analyze | Ask first | Ask Before Dig |
| Simple task complete | "Done." only | Terse |
| About to edit file | `ls`/`cat` first | State Awareness |

---

**Remember:** Every token saved is a token available for something useful.  
Every loop prevented is time saved for both of us.

**Enforced by:** STANDING_ORDERS.md  
**Last updated:** 08-02-2026
