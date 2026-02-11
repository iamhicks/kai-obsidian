# MIND App - Technical Specification

**Version:** 1.0  
**Date:** February 2026  
**Product:** MIND - AI-Powered Knowledge Management  
**Platform:** macOS Desktop (Tauri), Web (Future)  
**Status:** In Development

---

## 1. Executive Summary

MIND is an **offline-first, AI-powered knowledge management system** designed for professionals who value privacy and productivity. Unlike cloud-based competitors (Notion, Obsidian), MIND keeps all data local, works without internet, and uses local AI (Ollama) for intelligent features.

### Key Differentiators
- **Offline-first** — Works without internet, no data leaving the machine
- **One-time purchase** — $29, no subscriptions
- **Local AI** — Privacy-first AI using Ollama (no API costs, no rate limits)
- **Beautiful UI** — Polished, Notion-inspired interface with dark/light themes

---

## 2. Product Overview

### 2.1 Target Audience
- Knowledge workers needing offline access
- Privacy-conscious professionals
- Users tired of subscription fatigue
- People wanting AI assistance without cloud dependencies

### 2.2 Core Value Proposition
"Your thoughts, your AI, your machine. No subscriptions. No surveillance."

### 2.3 Pricing Model
| Product | Price | Bundle |
|---------|-------|--------|
| MIND | $29 | $49 (MIND + FLOW) |
| FLOW | $29 | |
| EDGE | TBD | |

---

## 3. Feature Requirements

### 3.1 Core Features (MVP)

#### Notes Management
- **Rich text editing** — WYSIWYG editor with formatting toolbar
- **Note organization** — Folders with drag-and-drop
- **Tags system** — AI-generated + manual tags with filtering
- **Search** — Full-text search across all notes
- **Favorites** — Pin important notes/folders
- **Archive** — Soft delete with restore capability

#### AI Features (Ollama Integration)
- **AI Tags** — Auto-generate relevant tags from note content
- **AI Summary** — Bullet-point summary of long notes
- **Ask AI** — Text improvement options:
  - Improve writing
  - Fix grammar & spelling
  - Make shorter
  - Make longer
  - Simplify language
  - Make professional
- **Clip webpage** — Extract article content via jina.ai API

#### Import/Export
- **Markdown import** — Single files or bulk folder import
- **JSON export** — Full backup/restore
- **Auto-backup** — Scheduled exports to local filesystem

### 3.2 Future Features (Post-MVP)
- **Internal linking** — `[[Note Name]]` syntax with autocomplete
- **Tasks** — Checkbox todos with due dates
- **Attachments** — Image embedding
- **Sync** — Encrypted peer-to-peer sync (no cloud)

---

## 4. Technical Architecture

### 4.1 Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Vanilla HTML/CSS/JS | UI (no framework bloat) |
| **Desktop Shell** | Tauri v1.x | Native app wrapper |
| **Storage** | IndexedDB | Client-side data persistence |
| **AI Backend** | Ollama (local) | LLM inference via HTTP API |
| **Build** | Cargo (Rust) | Tauri compilation |

### 4.2 Data Model

```javascript
// App State Structure
{
  notes: [
    {
      id: string,           // UUID
      title: string,
      content: string,      // HTML from WYSIWYG
      folderId: string|null,
      tags: string[],
      summary: string,      // AI-generated
      isFavorite: boolean,
      isArchived: boolean,
      createdAt: timestamp,
      updatedAt: timestamp
    }
  ],
  folders: [
    {
      id: string,
      name: string,
      parentId: string|null,
      isSystem: boolean     // root, archive, etc.
    }
  ],
  settings: {
    theme: 'light'|'dark'|'auto',
    aiProvider: 'ollama'|'webllm'|'cloud',
    ollamaUrl: string,     // default: http://localhost:11434
    ollamaModel: string,   // e.g., 'llama3.2'
    sidebarCollapsed: object,
    favoriteFolders: string[]
  }
}
```

### 4.3 File Structure

```
mind-tauri/
├── dist/
│   └── index.html          # Main UI (single file app)
├── src-tauri/
│   ├── src/
│   │   └── main.rs         # Rust backend (Ollama HTTP bridge)
│   ├── Cargo.toml
│   └── tauri.conf.json     # App config, window settings
├── icons/                  # App icons
└── README.md
```

---

## 5. UI/UX Specifications

### 5.1 Design System

#### Color Palette (Dark Theme - Default)
```css
--bg-primary: #191919;        /* Main background */
--bg-secondary: #202020;      /* Sidebar, cards */
--bg-tertiary: #2d2d2d;       /* Inputs, hover states */
--bg-hover: #373737;          /* Interactive hover */
--text-primary: #f5f5f5;      /* Headings, body */
--text-secondary: #9b9b9b;    /* Labels, metadata */
--text-tertiary: #6b6b6b;     /* Disabled, hints */
--accent: #2eaadc;            /* Primary actions */
--accent-hover: #5bc2e7;      /* Hover states */
--border: #2d2d2d;            /* Subtle dividers */
--border-hover: #3d3d3d;      /* Active borders */
--success: #2ecc71;
--warning: #f4d03f;
--danger: #eb5757;
```

#### Color Palette (Light Theme)
```css
--bg-primary: #ffffff;
--bg-secondary: #f7f6f3;
--bg-tertiary: #f1f1ef;
--bg-hover: #efefef;
--text-primary: #37352f;
--text-secondary: #6b6b6b;
--text-tertiary: #9b9b9b;
--accent: #2eaadc;
--accent-hover: #0077cc;
--border: #e3e2e0;
--border-hover: #d3d1cb;
```

#### Typography
- **Primary:** System font stack (-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto)
- **Monospace:** 'SF Mono', Monaco, 'Cascadia Code' (for code blocks)
- **Base size:** 14px
- **Line height:** 1.5

#### Spacing & Sizing
- **Border radius:** 3px (small), 6px (medium), 8px (large)
- **Sidebar width:** 280px (desktop), 100% (mobile)
- **Header height:** 50px
- **Bottom nav:** 60px (mobile only)

### 5.2 Layout Structure

```
┌─────────────────────────────────────────────────────┐
│ Sidebar (280px)    │ Main Content Area              │
│ ┌─────────────────┐ │ ┌───────────────────────────┐ │
│ │ Search...       │ │ │ Header: Title + Actions   │ │
│ ├─────────────────┤ │ ├───────────────────────────┤ │
│ │ FOLDERS ▾       │ │ │                           │ │
│ │ ▸ All Notes     │ │ │  Note Content             │ │
│ │ ▸ Favorites     │ │ │  (WYSIWYG Editor)         │ │
│ │ ▸ Work          │ │ │                           │ │
│ │   ▸ Projects    │ │ │                           │ │
│ │ ▸ Personal      │ │ │                           │ │
│ ├─────────────────┤ │ │                           │ │
│ │ TAGS ▾          │ │ │                           │ │
│ │ #ai-generated   │ │ └───────────────────────────┘ │
│ │ #writing        │ │                               │
│ └─────────────────┘ │                               │
└──────────────────────┴───────────────────────────────┘
```

### 5.3 Component Specifications

#### Buttons
```css
/* Primary Button */
.btn-primary {
  background: var(--accent);
  color: white;
  padding: 8px 16px;
  border-radius: 3px;
  border: none;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}
.btn-primary:hover { background: var(--accent-hover); }

/* Secondary Button */
.btn-secondary {
  background: transparent;
  color: var(--text-secondary);
  padding: 8px 16px;
  border-radius: 3px;
  border: 1px solid var(--border);
}
.btn-secondary:hover {
  background: var(--bg-hover);
  border-color: var(--border-hover);
}
```

#### Modal (Ask AI)
- Width: 520px max
- Padding: 24px
- Background: var(--bg-secondary)
- Border-radius: 8px
- Shadow: 0 8px 32px rgba(0,0,0,0.4)

#### AI Options Cards
```css
.ai-option-btn {
  text-align: left;
  padding: 16px;
  background: var(--bg-tertiary);
  border: 1px solid var(--border);
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.15s ease;
  width: 100%;
}
.ai-option-btn:hover {
  background: var(--bg-hover);
  border-color: var(--accent);
  transform: translateY(-2px);
}
```

### 5.4 Responsive Breakpoints
- **Desktop:** > 768px (sidebar visible)
- **Mobile:** ≤ 768px (sidebar as overlay, bottom nav)

---

## 6. AI Integration Specifications

### 6.1 Ollama API

**Endpoint:** `http://localhost:11434`

#### List Models
```http
GET /api/tags
Response: { models: [{ name: "llama3.2", ... }] }
```

#### Generate Text
```http
POST /api/generate
Content-Type: application/json

{
  "model": "llama3.2",
  "prompt": "Improve this text: ...",
  "system": "You are a helpful writing assistant...",
  "stream": false
}

Response: { response: "Improved text here...", done: true }
```

### 6.2 AI Prompts

#### Tag Generation
```
System: You are a tag generator. Extract 3-5 relevant keywords from the text.
Return ONLY a JSON array: ["tag1", "tag2", "tag3"]

Prompt: {note_content}
```

#### Summary Generation
```
System: Summarize the following text in 3-5 bullet points.
Be concise and capture key ideas.

Prompt: {note_content}
```

#### Text Improvement (Options Format)
```
System: Provide 3 different improvements for the text.
Format each as "Option N: [improved text]"
Be concise, professional, and actionable.

Prompt: {selected_text}
Task: {improve|grammar|shorter|longer|simplify|professional}
```

### 6.3 Performance Expectations
- **Model loading:** 30-60s (first request)
- **Subsequent requests:** 5-15s (model stays in memory)
- **Recommended models:**
  - `llama3.2` — Good balance (10-15s)
  - `llama3.2:1b` — Fastest (5-10s), lower quality

---

## 7. Backend API (Tauri Commands)

### 7.1 Rust Commands

```rust
// Test Ollama connection
#[command]
async fn test_ollama_connection(url: String) -> Result<ConnectionResult, String>

// Generate text via Ollama
#[command]
async fn generate_with_ollama(
    url: String,
    model: String,
    prompt: String,
    system: String
) -> Result<GenerateResult, String>

// Quick availability check
#[command]
async fn is_ollama_available(url: String) -> Result<bool, String>
```

### 7.2 JavaScript Integration

```javascript
// In browser/Tauri frontend
const { invoke } = window.__TAURI__;

// Test connection
const result = await invoke('test_ollama_connection', {
  url: 'http://localhost:11434'
});

// Generate text
const result = await invoke('generate_with_ollama', {
  url: 'http://localhost:11434',
  model: 'llama3.2',
  prompt: 'Improve this: Hello world',
  system: 'You are a writing assistant'
});
```

---

## 8. Storage & Persistence

### 8.1 IndexedDB Schema
- **Database:** `mind_db`
- **Store:** `data`
- **Key:** `kb_data` (single JSON blob)
- **Backup key:** `kb_data_backup`

### 8.2 Backup Strategy
- **Auto-backup:** On app startup (if data > 100 chars)
- **Scheduled:** Every 10 minutes (future)
- **Location:** `~/Documents/MIND-Backups/DD-MM-YY/HHMM/`

### 8.3 Export Formats
- **Markdown:** Individual `.md` files with frontmatter
- **JSON:** Full app state backup

---

## 9. Security Considerations

### 9.1 CSP (Content Security Policy)
```
default-src 'self';
connect-src 'self' http://localhost:* http://127.0.0.1:*;
img-src 'self' data: https:;
script-src 'self' 'unsafe-inline' https://unpkg.com;
style-src 'self' 'unsafe-inline' https://unpkg.com;
font-src 'self' https://unpkg.com;
```

### 9.2 Data Privacy
- No telemetry or analytics
- No cloud sync by default
- AI processing happens locally (Ollama)
- Optional: P2P encrypted sync (future)

---

## 10. Build & Deployment

### 10.1 Development
```bash
cd mind-tauri/src-tauri
cargo run          # Development build with hot reload
cargo build        # Debug build
cargo build --release  # Production build
```

### 10.2 Distribution
- **macOS:** `.dmg` installer
- **Windows:** `.msi` installer (future)
- **Linux:** `.AppImage` (future)

### 10.3 Code Signing
- macOS: Required for distribution outside App Store
- Use Apple Developer certificate

---

## 11. Testing Checklist

### 11.1 Functional Tests
- [ ] Create/edit/delete notes
- [ ] Create/edit/delete folders
- [ ] Drag-and-drop organization
- [ ] Search functionality
- [ ] Tag filtering
- [ ] AI features with Ollama
- [ ] Import/export
- [ ] Theme switching

### 11.2 AI Tests
- [ ] Ollama connection
- [ ] Model selection
- [ ] Tag generation
- [ ] Summary generation
- [ ] Text improvement (all options)
- [ ] Error handling (Ollama not running)

### 11.3 Edge Cases
- [ ] Empty note handling
- [ ] Very long notes (>10,000 words)
- [ ] Special characters in titles
- [ ] Unicode support
- [ ] Offline mode

---

## 12. Known Issues & Limitations

### Current Limitations
1. **AI speed:** Local inference is slower than cloud APIs (10-15s vs 1-2s)
2. **Model size:** Users must download models (~2-4GB each)
3. **macOS only:** Windows/Linux builds not yet tested
4. **No mobile:** Desktop only

### Workarounds
- Recommend `llama3.2:1b` for faster responses
- Document Ollama setup process clearly

---

## 13. Future Roadmap

### Phase 2 (Q2 2026)
- [ ] Internal linking with autocomplete
- [ ] Task management with due dates
- [ ] Image attachments
- [ ] Windows/Linux builds

### Phase 3 (Q3 2026)
- [ ] Encrypted P2P sync
- [ ] Plugin system
- [ ] Custom themes
- [ ] Mobile companion app

---

## 14. Resources

### Documentation
- Tauri Docs: https://tauri.app
- Ollama Docs: https://github.com/ollama/ollama
- Product Page: https://iamhicks.com/mind

### Assets
- Icons: `/icons/` folder
- Fonts: System fonts (no custom fonts required)

### Contact
- GitHub: https://github.com/iamhicks/mind
- Support: support@iamhicks.com

---

**Document Status:** Draft  
**Next Review:** Post-MVP launch  
**Owner:** Pete Roberts (iamhicks)
