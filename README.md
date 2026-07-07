# Nexo

> A work-in-progress cross-platform app for calm personal and family organization.

Nexo connects personal planning with household coordination without mixing private and shared information. The long-term goal is one coherent experience for tasks, calendars, shopping, inventory, expiration dates, reminders, alarms, and notes across mobile and desktop.

## Project status

**Pre-alpha / initial implementation.** The repository contains an early functional Flutter interface, a FastAPI foundation, automated tests, and GitHub CI. It is not ready for installation, real data, or production use.

The initial interface currently demonstrates:

- Adaptive mobile and desktop navigation
- Light, dark, and system-default themes
- Today dashboard
- Shared task state between Today and Plan
- Household shopping and expiration views
- Personal and household notes
- Quick creation for tasks, purchases, and notes
- Appearance preferences
- FastAPI health and task endpoints
- Flutter and backend tests

Data is currently held in memory and resets when the app restarts. Authentication, SQLite persistence, PostgreSQL, synchronization, notifications, and production security are future work.

## Why Nexo?

Most productivity tools treat calendars, tasks, shopping lists, notes, and household inventory as unrelated features. Nexo aims to connect them:

- A completed shopping item can become an inventory item.
- Inventory can warn the household before a product expires.
- A note can become a task, reminder, event, or shopping item.
- A task can be scheduled directly on the calendar.
- Personal information stays private unless explicitly shared.
- Household members can coordinate without surveillance or productivity scoring.

## Planned experience

### Today

A calm daily overview with upcoming events, priorities, reminders, expiring products, and relevant household activity.

### Plan

Daily, weekly, monthly, and yearly calendar views combined with tasks, subtasks, routines, deadlines, recurrence, and optional focus sessions.

### Home

Shared shopping lists, household inventory, expiration tracking, responsibilities, family events, and configurable member permissions.

### Notes

Private or shared notes with text, checklists, images, files, and conversion into actionable items.

### Quick capture

A universal creation flow designed to understand requests such as:

> Buy milk tomorrow at 6 PM and share it with Home.

The user should always review interpreted information before saving it.

## Target platforms

- Android
- iOS
- Windows
- macOS
- Web may be used for previews or introduced as a supported platform later

The current repository contains shared Flutter application code. Native platform host folders will be added as the project moves beyond the initial prototype.

## Technical direction

- **Client:** Flutter
- **Backend:** Python with FastAPI
- **Local storage:** SQLite (planned)
- **Cloud database:** PostgreSQL (planned)
- **Data model:** Offline-first synchronization (planned)
- **Notifications:** Local reminders and remote household updates (planned)

### Repository structure

```text
.
├── lib/main.dart
├── test/
├── backend/
│   ├── app/
│   └── tests/
├── docs/
├── .github/
├── pubspec.yaml
└── ROADMAP.md
```

## Development

Flutter and Python must already be installed in the development environment.

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Backend:

```bash
cd backend
python -m pip install -e ".[dev]"
uvicorn app.main:app --reload
pytest
```

These commands are documentation only; CI runs checks remotely on GitHub.

## Privacy principles

- Private by default
- Explicit personal and household spaces
- Least-privilege household roles
- No advertising based on family data
- No manipulative streaks or guilt-based productivity
- User-controlled notifications
- Export and deletion as first-class capabilities

## Documentation

- [Product vision](docs/PRODUCT_VISION.md)
- [Roadmap](ROADMAP.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

No open-source license has been selected yet. Until a license is added, all rights are reserved and the repository content may be viewed and discussed but not reused, modified, or redistributed without permission.
