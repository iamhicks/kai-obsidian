# Unified Chat Feature

**Status:** Implemented  
**Date:** 13-02-2026  
**Module:** FLOW Dashboard — Chat

---

## Overview

Unified Chat aggregates all conversations across channels into a single, searchable interface. It provides a complete history of interactions regardless of which platform (Telegram, FlowChat, etc.) the message originated from.

---

## Features

### 1. Cross-Channel Message Aggregation
- **Telegram messages** — Synced from OpenClaw session logs
- **FlowChat messages** — Web interface conversations
- **Future channels** — WhatsApp, Discord, Slack, iMessage (extensible)

All messages appear in chronological order in a unified timeline.

### 2. Real-Time Search
- **Instant filtering** — Type to filter messages as you type
- **Highlighting** — Matching text highlighted in yellow
- **Cross-channel search** — Searches across all channels simultaneously
- **Preserves scroll** — User's scroll position maintained during search

### 3. Channel Display (Informational)
- **Static channel list** — Shows connected channels (Telegram, FlowChat)
- **Status indicators** — Green dot = connected
- **No filtering** — Channels are for status display only, not message filtering
- **Message count** — Shows total messages (e.g., "500 messages")

### 4. Message Styling
- **User messages** — Grey bubble (#ece9e4 light, #2d2d2d dark), rounded corners with triangle effect
- **AI messages** — No bubble, clean background text
- **No avatars** — Clean, minimal design
- **Timestamps** — Hover to see time + channel tag
- **Channel tags** — Shows which channel message came from

### 5. Auto-Refresh
- **3-second polling** — New messages appear automatically
- **Smart scroll** — Only auto-scrolls if user is at bottom and not searching
- **New message indicator** — "New messages" button appears when scrolled up

---

## Technical Implementation

### Data Source
```
OpenClaw Session Logs (.jsonl)
  ↓
FLOW Server (/api/messages)
  ↓
Dashboard (real-time polling)
```

### Message Format
```json
{
  "id": "msg_timestamp",
  "channel": "telegram|flowchat",
  "channelName": "Telegram|FlowChat",
  "sender": "Pete|Kai",
  "senderType": "human|ai",
  "text": "message content",
  "timestamp": "ISO-8601"
}
```

### API Endpoints
- `GET /api/messages` — Fetch all messages
- `POST /api/messages` — Send message (simulated)

### Key Files
- `app/dashboard.html` — UI component
- `server.js` — Message sync from OpenClaw sessions
- `data/messages.json` — Local message cache

---

## User Experience

### Typical Flow
1. User sends message in Telegram
2. Message appears in Unified Chat (lag: ~3 seconds)
3. User switches to FLOW dashboard
4. Full conversation history visible, searchable
5. User searches "token usage" — finds relevant messages from any channel

### Benefits
- **Never lose context** — Conversation history preserved regardless of platform
- **Single source of truth** — One place to review all interactions
- **Powerful search** — Find any message, any time, any channel
- **Clean UI** — No visual clutter, focus on content

---

## Future Enhancements

### Short Term
- [ ] Screenshot/image paste support
- [ ] Message threading/replies
- [ ] Export conversation to Markdown

### Long Term
- [ ] AI-suggested search based on current task
- [ ] Conversation summaries
- [ ] Sentiment analysis per conversation
- [ ] Cross-conversation linking ("This relates to your question about X")

---

## Design Principles

1. **Unified over fragmented** — One timeline, not multiple tabs
2. **Search-first** — Finding old messages should be effortless
3. **Minimal chrome** — Content (messages) is the focus
4. **Real-time** — Messages appear without manual refresh
5. **Persistent** — History survives sessions, available forever

---

## Related Documentation

- [[FLOW Module Documentation]] — Overall FLOW architecture
- [[Chat Styling]] — UI/UX details
- [[MIND Technical Specification]] — Inspiration for chat design

---

*Document created: 13-02-2026*  
*Last updated: 13-02-2026*