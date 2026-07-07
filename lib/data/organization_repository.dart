import '../domain/models.dart';

abstract interface class OrganizationRepository {
  List<TaskItem> get tasks;
  List<ShoppingEntry> get shopping;
  List<NoteEntry> get notes;

  void setTaskCompleted(int index, bool completed);
  void setShoppingCompleted(int index, bool completed);
  void addTask(TaskItem task);
  void addShoppingEntry(ShoppingEntry entry);
  void addNote(NoteEntry note);
}

class InMemoryOrganizationRepository implements OrganizationRepository {
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

  @override
  List<TaskItem> get tasks => List.unmodifiable(_tasks);

  @override
  List<ShoppingEntry> get shopping => List.unmodifiable(_shopping);

  @override
  List<NoteEntry> get notes => List.unmodifiable(_notes);

  @override
  void setTaskCompleted(int index, bool completed) {
    _tasks[index].completed = completed;
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
