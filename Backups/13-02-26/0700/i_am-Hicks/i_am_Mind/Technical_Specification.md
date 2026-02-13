# Mind - Technical Specification

## Overview
Notion-like offline knowledge management app. Single-file HTML application with localStorage/IndexedDB persistence.

## Tech Stack
- **Frontend**: Vanilla HTML/CSS/JS (single file)
- **Storage**: IndexedDB with localStorage fallback
- **Icons**: Phosphor Icons (`<i class="ph ph-[name]"></i>`)
- **Styling**: CSS custom properties for theming
- **Backup**: GitHub + local filesystem (cron)

## Core Architecture

### Data Model
```javascript
{
  folders: [{ id, name, parentId }],
  notes: [{ id, title, content, folderId, tags[], createdAt, updatedAt, tasks[], fontFamily, smallText, fullWidth }],
  tags: [string],
  customTemplates: [{ id, name, content }], // User-created templates
  settings: { theme, sidebarCollapsed, aiProvider }
}
```

### Key Classes
- `KnowledgeBase` - Main app class
- Methods: `init()`, `createNote()`, `selectNote()`, `search()`, `applyTemplate()`, etc.

## UI Structure

### Layout
```
┌─────────────────────────────────────┐
│  Sidebar    │  Main Content         │
│  ─────────  │  ─────────────────    │
│  Search     │  Header (breadcrumb)  │
│  Favorites  │                       │
│  Folders    │  Note Editor          │
│  Tags       │  - Title              │
│             │  - Meta (date/tags)   │
│             │  - Tabs (Note/Summary/│
│             │    Tasks)              │
│             │  - Template dropdown  │
│             │  - Content editor     │
│             │                       │
└─────────────────────────────────────┘
```

### Components

#### Sidebar
- **Search**: Live search with results dropdown
- **Favorites**: Starred folders
- **Folders**: Tree view, drag-drop reorder, context menu
- **Tags**: Cloud view, click to filter

#### Main Content
- **Tabs Bar**: Open note tabs, + button, 3-dots menu
- **Note Editor**:
  - Title input
  - Meta: date, tags input, AI Tags button
  - Tabs: Note | Summary | Tasks
  - Template dropdown (under Note tab)
  - WYSIWYG editor (contenteditable)
  - Selection toolbar (appears on text selection)

#### Editor Features
- **Formatting**: Bold, italic, underline, strikethrough, headings, lists
- **Links**: Select text → click link button → enter URL
- **Images**: Select position → click image button → enter URL
- **AI**: Ask AI button in toolbar (yellow sparkle)
- **Internal links**: `[[Note Title]]` auto-converts

#### Tabs
- **Note**: Editor + template dropdown
- **Summary**: AI Summary button, generated summary display
- **Tasks**: Checkbox list, Add Task button

#### 3 Dots Menu (More)
- Font options (Default/Serif/Mono)
- Copy Page Contents
- Duplicate
- Convert to PDF
- Clip Web Page
- Small Text toggle
- Full Width toggle
- Version History
- Move to Trash

## Styling

### Color Scheme (Dark Default)
```css
--bg-primary: #191919
--bg-secondary: #252525
--bg-tertiary: #2a2a2a
--text-primary: #ffffff
--text-secondary: #b4b4b4
--text-tertiary: #666666
--accent: #2eaadc
--border: #2a2a2a
```

### Key CSS Classes
- `.sidebar` - Left sidebar
- `.main` - Main content area
- `.wysiwyg-editor` - Note editor
- `.note-tabs` - Tab container
- `.selection-toolbar` - Floating format toolbar
- `.modal-overlay` - Modal backdrop

## Storage & Persistence

### IndexedDB
- DB Name: `knowledgeBase`
- Store: `data`
- Auto-save on: input, blur, note switch

### Backup System
- **Daily 23:00**: Always runs
- **Active work**: 30-min intervals (user-controlled)
- **One-off**: On demand
- **Locations**:
  - Local: `~/Documents/Kai/Backup/Mind/DD-MM-YY/HHMM/`
  - GitHub: Auto-commit

## Feature Behaviors

### Templates
- **No default templates** - user creates their own
- **Save as Template**: Dropdown → "+ Save as Template" → Enter name → Saved
- **Use Template**: Select from dropdown → Applies to current note
- **Delete Template**: Select template → Click "Delete" in dialog
- Custom templates stored in `data.customTemplates`

### Search
- Searches: title, content, tags
- Results: dropdown with title + preview
- Click result → open note
- Click elsewhere → close results

### Tags
- Click tag in sidebar → show card view of matching notes
- Card shows: title, preview, all tags, folder
- Click card → open note
- Yellow tag icon in header

### Tasks
- Simple checkbox list per note
- Grey unchecked, blue checked
- Add Task button
- Return key creates new task
- (Rich text: intentionally simple - caused issues)

### AI Features
- **AI Tags**: Suggests tags based on content (demo mode)
- **AI Summary**: Generates summary for Summary tab (demo mode)
- **Ask AI**: Selection toolbar option
- All AI buttons: yellow sparkle icon
- Opens config panel if not set up

## File Locations

### Development
- Source: `/Users/peteroberts/Documents/Kai/KnowledgeBase/mind-demo/index.html`

### Backup
- Mind: `~/Documents/Kai/Backup/Mind/DD-MM-YY/HHMM/`
- Website: `~/Documents/Kai/Backup/Website/DD-MM-YY/HHMM/`
- Obsidian: `~/Documents/Kai/Backup/Obsidian/DD-MM-YY/HHMM/`
- OpenClaw: `~/Documents/Kai/Backup/OpenClaw/DD-MM-YY/HHMM/`

### Deployed
- URL: `https://iamhicks.com/mind-demo/`

## Known Limitations
- No rich text in tasks (simplified after multiple failures)
- AI features in demo mode (keyword matching, not real AI)
- Single-user (no collaboration)
- Browser-only (no mobile app)

## Future Ideas (Not Implemented)
- Rich text tasks with formatting toolbar
- Real AI integration (WebLLM/Ollama/Cloud)
- Mobile responsive design
- Export to various formats
- Plugin system

---
*Last updated: 2026-02-06*
*Working version backed up at: 06-02-26/1500/*
