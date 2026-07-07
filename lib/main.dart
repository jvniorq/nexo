import 'package:flutter/material.dart';

import 'core/nexo_theme.dart';
import 'domain/models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexoApp());
}

class NexoApp extends StatefulWidget {
  const NexoApp({super.key});

  @override
  State<NexoApp> createState() => _NexoAppState();
}

class _NexoAppState extends State<NexoApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexo',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: NexoTheme.light,
      darkTheme: NexoTheme.dark,
      home: NexoShell(
        themeMode: _themeMode,
        onThemeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}

class NexoShell extends StatefulWidget {
  const NexoShell({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  State<NexoShell> createState() => _NexoShellState();
}

class _NexoShellState extends State<NexoShell> {
  int _selectedIndex = 0;

  final List<TaskItem> _tasks = [
    TaskItem('Finish the presentation', NexoSpace.personal),
    TaskItem('Buy medication', NexoSpace.household),
    TaskItem('Confirm the appointment', NexoSpace.personal),
  ];

  final List<ShoppingEntry> _shopping = [
    ShoppingEntry('Milk', '2 liters'),
    ShoppingEntry('Rice', '1 kg'),
    ShoppingEntry('Detergent', '1 unit'),
  ];

  final List<NoteEntry> _notes = [
    NoteEntry(
      'Ideas for the week',
      'Plan meals, review expenses, and organize the weekend.',
      NexoSpace.personal,
    ),
    NoteEntry(
      'Home information',
      'Useful household details and important contacts.',
      NexoSpace.household,
    ),
  ];

  static const _destinations = [
    ('Today', Icons.home_outlined, Icons.home_rounded),
    ('Plan', Icons.calendar_today_outlined, Icons.calendar_month_rounded),
    ('Home', Icons.house_outlined, Icons.house_rounded),
    ('Notes', Icons.note_outlined, Icons.note_rounded),
    ('Profile', Icons.person_outline, Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      TodayPage(tasks: _tasks, onTaskChanged: _toggleTask),
      PlanPage(tasks: _tasks, onTaskChanged: _toggleTask),
      HomePage(shopping: _shopping, onShoppingChanged: _toggleShopping),
      NotesPage(notes: _notes),
      ProfilePage(
        themeMode: widget.themeMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 900;
        return Scaffold(
          body: Row(
            children: [
              if (desktop)
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 1180,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _select,
                    leading: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: NexoMark(),
                    ),
                    destinations: [
                      for (final item in _destinations)
                        NavigationRailDestination(
                          icon: Icon(item.$2),
                          selectedIcon: Icon(item.$3),
                          label: Text(item.$1),
                        ),
                    ],
                  ),
                ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: KeyedSubtree(
                    key: ValueKey(_selectedIndex),
                    child: pages[_selectedIndex],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _select,
                  destinations: [
                    for (final item in _destinations)
                      NavigationDestination(
                        icon: Icon(item.$2),
                        selectedIcon: Icon(item.$3),
                        label: item.$1,
                      ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showQuickCreate,
            tooltip: 'Quick create',
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }

  void _select(int index) => setState(() => _selectedIndex = index);

  void _toggleTask(int index, bool value) {
    setState(() => _tasks[index].completed = value);
  }

  void _toggleShopping(int index, bool value) {
    setState(() => _shopping[index].completed = value);
  }

  Future<void> _showQuickCreate() async {
    final textController = TextEditingController();
    var type = 'Task';
    var space = NexoSpace.personal;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) => SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              8,
              24,
              24 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'What do you need to organize?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Write something...',
                      prefixIcon: Icon(Icons.auto_awesome_outlined),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'Task', label: Text('Task')),
                      ButtonSegment(value: 'Purchase', label: Text('Purchase')),
                      ButtonSegment(value: 'Note', label: Text('Note')),
                    ],
                    selected: {type},
                    onSelectionChanged: (value) {
                      setSheetState(() => type = value.first);
                    },
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<NexoSpace>(
                    segments: const [
                      ButtonSegment(
                        value: NexoSpace.personal,
                        label: Text('Personal'),
                      ),
                      ButtonSegment(
                        value: NexoSpace.household,
                        label: Text('Home'),
                      ),
                    ],
                    selected: {space},
                    onSelectionChanged: (value) {
                      setSheetState(() => space = value.first);
                    },
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      final text = textController.text.trim();
                      if (text.isEmpty) return;
                      setState(() {
                        if (type == 'Task') {
                          _tasks.add(TaskItem(text, space));
                        } else if (type == 'Purchase') {
                          _shopping.add(ShoppingEntry(text, '1 unit'));
                        } else {
                          _notes.insert(0, NoteEntry(text, '', space));
                        }
                      });
                      Navigator.pop(sheetContext);
                    },
                    child: Text('Create $type'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    textController.dispose();
  }
}

class NexoMark extends StatelessWidget {
  const NexoMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Nexo',
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          'N',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class TodayPage extends StatelessWidget {
  const TodayPage({
    super.key,
    required this.tasks,
    required this.onTaskChanged,
  });

  final List<TaskItem> tasks;
  final void Function(int, bool) onTaskChanged;

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Good morning',
      subtitle: 'Your day at a glance.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final priorityCard = PriorityCard(
            tasks: tasks,
            onTaskChanged: onTaskChanged,
          );
          final summary = Column(
            children: [
              const NextEventCard(),
              const SizedBox(height: 16),
              HomeSummaryCard(
                pendingShopping: 3,
                expiringProducts: 2,
              ),
            ],
          );
          if (constraints.maxWidth < 760) {
            return Column(
              children: [
                summary,
                const SizedBox(height: 16),
                priorityCard,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: summary),
              const SizedBox(width: 16),
              Expanded(flex: 4, child: priorityCard),
            ],
          );
        },
      ),
    );
  }
}

class NextEventCard extends StatelessWidget {
  const NextEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NEXT EVENT',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Text('10:30', style: Theme.of(context).textTheme.headlineMedium),
            Text(
              'Weekly meeting',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            const Text('In 45 minutes · Personal'),
          ],
        ),
      ),
    );
  }
}

class PriorityCard extends StatelessWidget {
  const PriorityCard({
    super.key,
    required this.tasks,
    required this.onTaskChanged,
  });

  final List<TaskItem> tasks;
  final void Function(int, bool) onTaskChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PRIORITIES', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (var index = 0; index < tasks.length; index++)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: tasks[index].completed,
                onChanged: (value) => onTaskChanged(index, value ?? false),
                title: Text(
                  tasks[index].title,
                  style: TextStyle(
                    decoration:
                        tasks[index].completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  tasks[index].space == NexoSpace.personal
                      ? 'Personal'
                      : 'Home',
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HomeSummaryCard extends StatelessWidget {
  const HomeSummaryCard({
    super.key,
    required this.pendingShopping,
    required this.expiringProducts,
  });

  final int pendingShopping;
  final int expiringProducts;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.house_rounded, size: 34),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Home', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '$pendingShopping purchases · '
                    '$expiringProducts expiring soon',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanPage extends StatelessWidget {
  const PlanPage({
    super.key,
    required this.tasks,
    required this.onTaskChanged,
  });

  final List<TaskItem> tasks;
  final void Function(int, bool) onTaskChanged;

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Plan',
      subtitle: 'Your time, tasks, and upcoming commitments.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WeekStrip(),
          const SizedBox(height: 20),
          Text('Tasks', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          PriorityCard(tasks: tasks, onTaskChanged: onTaskChanged),
        ],
      ),
    );
  }
}

class WeekStrip extends StatelessWidget {
  const WeekStrip({super.key});

  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: List.generate(7, (index) {
            final date = monday.add(Duration(days: index));
            final selected = date.day == now.day && date.month == now.month;
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Text(labels[index]),
                    const SizedBox(height: 5),
                    Text(
                      '${date.day}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.shopping,
    required this.onShoppingChanged,
  });

  final List<ShoppingEntry> shopping;
  final void Function(int, bool) onShoppingChanged;

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Home',
      subtitle: 'The shared space for your household.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shoppingCard = Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shopping', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  for (var index = 0; index < shopping.length; index++)
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: shopping[index].completed,
                      onChanged: (value) {
                        onShoppingChanged(index, value ?? false);
                      },
                      title: Text(shopping[index].name),
                      subtitle: Text(shopping[index].quantity),
                    ),
                ],
              ),
            ),
          );
          const expiryCard = Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiring soon',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.kitchen_outlined),
                    title: Text('Natural yogurt'),
                    subtitle: Text('Refrigerator'),
                    trailing: Text('2 days'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.inventory_2_outlined),
                    title: Text('Sliced bread'),
                    subtitle: Text('Pantry'),
                    trailing: Text('5 days'),
                  ),
                ],
              ),
            ),
          );
          if (constraints.maxWidth < 760) {
            return Column(
              children: [
                shoppingCard,
                const SizedBox(height: 16),
                expiryCard,
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: shoppingCard),
              const SizedBox(width: 16),
              Expanded(child: expiryCard),
            ],
          );
        },
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  const NotesPage({super.key, required this.notes});

  final List<NoteEntry> notes;

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Notes',
      subtitle: 'Keep private ideas and shared household knowledge.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth >= 760
              ? (constraints.maxWidth - 16) / 2
              : constraints.maxWidth;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final note in notes)
                SizedBox(
                  width: width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            note.space == NexoSpace.personal
                                ? Icons.lock_outline
                                : Icons.group_outlined,
                            size: 18,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            note.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(note.content),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return PageFrame(
      title: 'Profile',
      subtitle: 'Manage your household, appearance, and privacy.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person_rounded, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wilson',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text('Home administrator'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_outlined),
                label: Text('System'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('Light'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('Dark'),
              ),
            ],
            selected: {themeMode},
            onSelectionChanged: (value) => onThemeChanged(value.first),
          ),
          const SizedBox(height: 20),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notifications'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                ListTile(
                  leading: Icon(Icons.group_outlined),
                  title: Text('Members and permissions'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                ListTile(
                  leading: Icon(Icons.security_outlined),
                  title: Text('Privacy and security'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
