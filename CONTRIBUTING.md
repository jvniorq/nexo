# Contributing to Nexo

Thank you for your interest in Nexo. The project is still in its planning and pre-alpha stage, so discussion, product feedback, accessibility observations, and focused documentation improvements are especially valuable.

## Before contributing

- Read the [README](README.md) and [roadmap](ROADMAP.md).
- Search existing issues before opening a new one.
- Do not include private information, credentials, tokens, or real household data.
- Keep personal and shared data separation in mind.
- For security concerns, follow [SECURITY.md](SECURITY.md) instead of opening a public issue.

## Issues

A useful issue should explain:

1. The problem or opportunity.
2. Who experiences it.
3. The desired outcome.
4. Relevant platform details.
5. Accessibility, privacy, or synchronization implications.

Feature requests should describe the need before prescribing a specific implementation.

## Pull requests

When source code is introduced, contributors should:

1. Fork the repository and create a focused branch.
2. Keep each pull request limited to one coherent change.
3. Add or update tests when behavior changes.
4. Run formatting, static analysis, and relevant tests.
5. Explain what changed, why it changed, and how it was verified.
6. Include screenshots for visible interface changes in light and dark modes.

## Design principles

Contributions should preserve these principles:

- Private by default
- Explicit sharing
- Calm, non-judgmental language
- Accessible interaction
- Useful motion with reduced-motion support
- Offline behavior as a first-class requirement
- Adaptive mobile and desktop experiences
- User ownership of data

## Commit messages

Use concise, descriptive messages. Conventional-style examples are welcome:

```text
feat: add household shopping list model
fix: preserve the selected appearance mode
docs: clarify offline synchronization goals
test: cover recurring task completion
```

## Code style

The planned client will follow official Dart and Flutter formatting conventions. The planned backend will use Python type hints, automated formatting, linting, and tests. Business rules should remain separate from presentation code.

## Conduct

Be respectful, constructive, and patient. Critique ideas and implementations, not people. Harassment, discrimination, intimidation, or publication of another person's private information will not be tolerated.

By participating, you agree that your contributions may be reviewed, revised, or declined to protect the direction and quality of the project.
