import '../domain/models.dart';

abstract interface class OrganizationRepository {
  List<TaskItem> get tasks;
  List<ShoppingEntry> get shopping;
  List<NoteEntry> get notes;

  void setTaskCompleted(int index, bool completed);
  void setSubtaskCompleted(int taskIndex, int subtaskIndex, bool completed);
  void setShoppingCompleted(int index, bool completed);
  void addTask(TaskItem task);
  void addShoppingEntry(ShoppingEntry entry);
  void addNote(NoteEntry note);
}

class InMemoryOrganizationRepository implements OrganizationRepository {
  final List<TaskItem> _tasks = [
    TaskItem(
      'Finish the presentation',
      NexoSpace.personal,
      priority: TaskPriority.high,
      dueDate: DateTime.now().add(const Duration(hours: 3)),
      subtasks: [
        SubtaskItem('Review the final slides', completed: true),
        SubtaskItem('Practice the introduction'),
        SubtaskItem('Send the document'),
      ],
    ),
    TaskItem(
      'Buy medication',
      NexoSpace.household,
      priority: TaskPriority.high,
      dueDate: DateTime.now().add(const Duration(days: 1)),
      subtasks: [
        SubtaskItem('Check the prescription'),
        SubtaskItem('Confirm pharmacy hours'),
      ],
    ),
    TaskItem(
      'Confirm the appointment',
      NexoSpace.personal,
      priority: TaskPriority.medium,
      dueDate: DateTime.now().add(const Duration(days: 3)),
    ),
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

  @override
  List<TaskItem> get tasks => List.unmodifiable(_tasks);

  @override
  List<ShoppingEntry> get shopping => List.unmodifiable(_shopping);

  @override
  List<NoteEntry> get notes => List.unmodifiable(_notes);

  @override
  void setTaskCompleted(int index, bool completed) {
    final task = _tasks[index];
    task.completed = completed;
    if (completed) {
      for (final subtask in task.subtasks) {
        subtask.completed = true;
      }
    }
  }

  @override
  void setSubtaskCompleted(
    int taskIndex,
    int subtaskIndex,
    bool completed,
  ) {
    final task = _tasks[taskIndex];
    task.subtasks[subtaskIndex].completed = completed;
    task.completed =
        task.subtasks.isNotEmpty && task.subtasks.every((item) => item.completed);
  }

  @override
  void setShoppingCompleted(int index, bool completed) {
    _shopping[index].completed = completed;
  }

  @override
  void addTask(TaskItem task) {
    _tasks.add(task);
  }

  @override
  void addShoppingEntry(ShoppingEntry entry) {
    _shopping.add(entry);
  }

  @override
  void addNote(NoteEntry note) {
    _notes.insert(0, note);
  }
}
