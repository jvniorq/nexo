# Nexo

> A work-in-progress concept for a calm, cross-platform personal and family organization app.

Nexo is being designed to connect personal planning with household coordination without mixing private and shared information. The long-term goal is a single experience for tasks, calendars, shopping, inventory, expiration dates, reminders, alarms, and notes across mobile and desktop.

## Project status

**Planning / pre-alpha.** This repository currently documents the product vision, scope, architecture direction, and contribution process. The application is not ready for installation or production use yet.

## Why Nexo?

Most productivity tools treat calendars, tasks, shopping lists, notes, and household inventory as unrelated features. Nexo aims to connect them:

- A completed shopping item can become an inventory item.
- Inventory can warn the household before a product expires.
- A note can become a task, reminder, event, or shopping item.
- A task can be scheduled directly on the calendar.
- Personal information stays private unless the user explicitly shares it.
- Household members can coordinate without surveillance or productivity scoring.

## Planned experience

### Today

A calm daily overview with upcoming events, priorities, reminders, expiring products, and relevant household activity.

### Plan

Daily, weekly, monthly, and yearly calendar views combined with tasks, subtasks, routines, deadlines, recurrence, and optional focus sessions.

### Home

Shared shopping lists, household inventory, expiration tracking, responsibilities, family events, and configurable member permissions.

### Notes

Private or shared notes with text, checklists, images, files, and the ability to convert content into actionable items.

### Quick capture

A universal creation flow designed to understand requests such as:

> Buy milk tomorrow at 6 PM and share it with Home.

The user will always review the interpreted information before saving it.

## Target platforms

- Android
- iOS
- Windows
- macOS
- Web may be used for previews or introduced as a supported platform later

Mobile, tablet, and desktop layouts will be adaptive rather than simple scaled copies.

## Appearance and accessibility

Nexo is planned with:

- Light, dark, and system-default themes
- Clear typography and accessible contrast
- Reduced-motion support
- Screen-reader semantics
- Large text support
- Keyboard navigation and shortcuts on desktop
- Motion that explains state changes instead of adding visual noise

## Technical direction

- **Client:** Flutter
- **Backend:** Python with FastAPI
- **Local storage:** SQLite
- **Cloud database:** PostgreSQL
- **Data model:** offline-first with later synchronization
- **Notifications:** local reminders plus remote household updates
- **Security:** server-side authorization, protected credentials, export, and account deletion

These choices are architectural direction, not a claim that the complete stack is already implemented.

## Privacy principles

- Private by default
- Explicit personal and household spaces
- Least-privilege household roles
- No advertising based on family data
- No manipulative streaks or guilt-based productivity
- User-controlled notifications
- Export and deletion as first-class capabilities

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the planned milestones.

## Contributing

Nexo is at a very early stage, but thoughtful feedback and discussion are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening an issue or pull request.

## Security

Please do not report vulnerabilities in public issues. Follow the process in [SECURITY.md](SECURITY.md).

## License

No open-source license has been selected yet. Until a license is added, all rights are reserved and the repository content may be viewed and discussed but not reused, modified, or redistributed without permission.
